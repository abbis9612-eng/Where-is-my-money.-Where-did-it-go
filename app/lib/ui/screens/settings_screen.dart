library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/money.dart';
import '../../platform/lock.dart';
import '../../platform/reminders.dart';
import '../../platform/sms.dart';
import '../../state/providers.dart';
import '../../sync/sync_screen.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final Map<String, String?> _values = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(repositoryProvider);
    for (final k in ['sms_enabled', 'remind_evening', 'remind_friday', 'lock', 'barakah']) {
      _values[k] = await repo.getValue(k);
    }
    if (mounted) setState(() {});
  }

  Future<void> _set(String key, bool on) async {
    final repo = ref.read(repositoryProvider);
    await repo.setValue(key, on ? '1' : '0');
    setState(() => _values[key] = on ? '1' : '0');
    if (key.startsWith('remind_')) {
      final snap = ref.read(snapshotProvider).value;
      await Reminders.reschedule(evening: _values['remind_evening'] == '1', friday: _values['remind_friday'] == '1', bills: snap?.bills ?? const []);
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider).value;
    final wf = Wf.of(context);
    final mode = ref.watch(themeModeProvider);
    if (snap == null) return const Scaffold();
    bool on(String k) => _values[k] == '1';
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        const SectionTitle('العائلة'),
        WfCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(snap.household.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text('كود الدعوة: خلّوا الثاني يدخله من موبايله حتى تشتركون بنفس الأرقام', style: TextStyle(color: wf.mute, fontSize: 13)),
            const SizedBox(height: 8),
            Row(children: [
              SelectableText(snap.household.inviteCode ?? '', style: WfText.money(22, weight: FontWeight.w600, color: wf.goldInk)),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: snap.household.inviteCode ?? ''));
                  Toaster.show(context, 'انسخ الكود. ابعثوه بالواتساب');
                },
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('انسخوا'),
              ),
            ]),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SyncScreen())),
              child: const Text('المزامنة بين الموبايلات'),
            ),
          ]),
        ),
        const SectionTitle('الدولار'),
        WfCard(
          onTap: () async {
            final c = TextEditingController(text: '${snap.household.usdRate}');
            final v = await showDialog<int>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('سعر الدولار اليوم'),
                content: TextField(controller: c, keyboardType: TextInputType.number, decoration: const InputDecoration(suffixText: 'دينار لكل دولار')),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                  FilledButton(onPressed: () => Navigator.pop(context, int.tryParse(c.text)), child: const Text('احفظوا')),
                ],
              ),
            );
            c.dispose();
            if (v != null && v > 100) await ref.read(repositoryProvider).setUsdRate(v);
          },
          child: Row(children: [
            const Expanded(child: Text('دينار لكل دولار. الصرفات القديمة تبقى بسعر يومها.')),
            Text(formatAmount(snap.household.usdRate), style: WfText.money(18, weight: FontWeight.w500, color: wf.ink)),
          ]),
        ),
        const SectionTitle('الإدخال التلقائي'),
        WfCard(
          padding: EdgeInsets.zero,
          child: SwitchListTile(
            title: const Text('اقروا رسائل الكي كارد والبنوك'),
            subtitle: Text('الرسائل من البنوك بس، وكل وحدة تنتظر تأكيدكم. ما تطلع من الموبايل.', style: TextStyle(color: wf.mute, fontSize: 12)),
            value: on('sms_enabled'),
            onChanged: (v) async {
              if (v && !await SmsReader.request()) {
                if (context.mounted) Toaster.show(context, 'بدون إذن الرسائل ما نكدر نقراها. تگدرون تسجلون بالكتابة أو الصوت.');
                return;
              }
              await _set('sms_enabled', v);
              if (v) {
                final n = await SmsReader.scan(ref.read(repositoryProvider));
                if (context.mounted) Toaster.show(context, n == 0 ? 'ماكو رسائل بنك جديدة' : 'لگينا $n صرفات تنتظر تأكيدكم');
              }
            },
          ),
        ),
        const SectionTitle('التذكيرات'),
        WfCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            SwitchListTile(
              title: const Text('بعد العشا نأكّد صرف اليوم'),
              subtitle: Text('مرة وحدة 9:30 بالليل', style: TextStyle(color: wf.mute, fontSize: 12)),
              value: on('remind_evening'),
              onChanged: (v) async {
                if (v) await Reminders.requestPermission();
                await _set('remind_evening', v);
              },
            ),
            SwitchListTile(
              title: const Text('جلسة الجمعة'),
              subtitle: Text('الجمعة 7 المسا، ومعها تذكير الفواتير قبل يوم', style: TextStyle(color: wf.mute, fontSize: 12)),
              value: on('remind_friday'),
              onChanged: (v) async {
                if (v) await Reminders.requestPermission();
                await _set('remind_friday', v);
              },
            ),
          ]),
        ),
        const SectionTitle('لمسة بركة'),
        WfCard(
          padding: EdgeInsets.zero,
          child: SwitchListTile(
            title: const Text('آيات وأحاديث بمكانها'),
            subtitle: Text('آية أو حديث صحيح وياه مصدره، يطلع يوم الراتب والجمعة ووقت الدين', style: TextStyle(color: wf.mute, fontSize: 12)),
            value: _values['barakah'] != '0',
            onChanged: (v) => _set('barakah', v),
          ),
        ),
        const SectionTitle('الشكل والأمان'),
        WfCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                const Expanded(child: Text('الوضع')),
                Segmented<ThemeMode>(
                  values: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
                  selected: mode,
                  label: (m) => switch (m) { ThemeMode.light => 'نهاري', ThemeMode.dark => 'ليلي', _ => 'ويا الموبايل' },
                  onChanged: (m) => ref.read(themeModeProvider.notifier).set(m),
                ),
              ]),
            ),
            SwitchListTile(
              title: const Text('قفل بالبصمة'),
              subtitle: Text('محد يفتح التطبيق غيركم', style: TextStyle(color: wf.mute, fontSize: 12)),
              value: on('lock'),
              onChanged: (v) async {
                if (v && !(await AppLock.available() && await AppLock.unlock())) return;
                await _set('lock', v);
              },
            ),
          ]),
        ),
        if (snap.isDemo) ...[
          const SectionTitle('البيانات التجريبية'),
          WfCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('هسه تشوفون عائلة تجريبية. امسحوها وابدأوا بأرقامكم الحقيقية.'),
              const SizedBox(height: 10),
              PrimaryButton(
                label: 'امسحوها وابدأوا',
                danger: true,
                onPressed: () async {
                  await ref.read(repositoryProvider).wipeLocal();
                  if (context.mounted) Navigator.of(context).popUntil((r) => r.isFirst);
                },
              ),
            ]),
          ),
        ],
        const SectionTitle('عن التطبيق'),
        WfCard(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('الرخص والخطوط'),
            subtitle: Text('IBM Plex Sans Arabic وReadex Pro وAref Ruqaa برخصة OFL', style: TextStyle(color: wf.mute, fontSize: 12)),
            onTap: () => showLicensePage(context: context, applicationName: 'وين فلوسي'),
          ),
        ),
      ]),
    );
  }
}
