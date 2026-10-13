library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/providers.dart';
import '../ui/theme/theme.dart';
import '../ui/widgets/common.dart';
import 'sync_service.dart';

/// Sign in with an email code, then either share this family or join one.
class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key, this.joinMode = false});

  /// Opened from first launch with "عندي كود دعوة".
  final bool joinMode;

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _invite = TextEditingController();
  final _name = TextEditingController(text: 'ماما');
  var _sent = false;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    for (final c in [_email, _code, _invite, _name]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _run(Future<void> Function() f) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await f();
    } catch (e) {
      _error = e.toString().contains('invite code') ? 'الكود غلط أو انتهى. تأكدوا منه.' : 'ما زبطت: ${e.toString().split('\n').first}';
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final repo = ref.read(repositoryProvider);
    if (!SyncService.configured) {
      return Scaffold(
        appBar: AppBar(title: const Text('المزامنة')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('هالنسخة تشتغل على الموبايل بس، وكل شي محفوظ ومشفّر عليه. المزامنة بين الموبايلات تشتغل بالنسخة المربوطة بالسيرفر.',
              style: TextStyle(color: wf.mute, height: 1.7)),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.joinMode ? 'انضمّوا للعائلة' : 'المزامنة')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        if (!SyncService.signedIn) ...[
          Text('سجّلوا بالإيميل. يوصلكم رمز من 6 أرقام، بدون كلمة سر.', style: TextStyle(color: wf.mute, height: 1.7)),
          const SizedBox(height: 12),
          TextField(controller: _email, keyboardType: TextInputType.emailAddress, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'الإيميل')),
          if (_sent) ...[
            const SizedBox(height: 10),
            TextField(controller: _code, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'الرمز اللي وصلكم')),
          ],
          const SizedBox(height: 14),
          PrimaryButton(
            label: _sent ? 'تأكيد' : 'ابعثوا الرمز',
            onPressed: _busy
                ? null
                : () => _run(() async {
                      if (!_sent) {
                        await SyncService.sendCode(_email.text);
                        _sent = true;
                      } else {
                        await SyncService.verifyCode(_email.text, _code.text);
                        if (!widget.joinMode && await repo.hasHousehold()) {
                          final r = await SyncService.linkAndSync(repo);
                          if (context.mounted) Toaster.show(context, 'تمت المزامنة: ${r.pushed} رفع، ${r.pulled} نزول');
                        }
                      }
                    }),
          ),
        ] else ...[
          Text('مسجّلين بـ ${SyncService.email ?? ''}', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          if (!widget.joinMode)
            PrimaryButton(
              label: 'زامنوا هسه',
              onPressed: _busy
                  ? null
                  : () => _run(() async {
                        final r = await SyncService.linkAndSync(repo);
                        if (context.mounted) Toaster.show(context, 'تمت المزامنة: ${r.pushed} رفع، ${r.pulled} نزول');
                      }),
            ),
          const SizedBox(height: 24),
          Text('عندكم كود دعوة من موبايل ثاني؟', style: Theme.of(context).textTheme.titleMedium),
          Text('الانضمام يبدّل بيانات هالموبايل ببيانات العائلة.', style: TextStyle(color: wf.mute, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(controller: _invite, textCapitalization: TextCapitalization.characters, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'الكود', hintText: 'WF-7Q2K')),
          const SizedBox(height: 8),
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'اسمك بالعائلة')),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'انضمّوا',
            onPressed: _busy
                ? null
                : () => _run(() async {
                      await SyncService.join(repo, _invite.text, _name.text.trim().isEmpty ? 'عضو' : _name.text.trim());
                      if (context.mounted) Navigator.of(context).popUntil((r) => r.isFirst);
                    }),
          ),
          const SizedBox(height: 24),
          TextButton(onPressed: _busy ? null : () => _run(() async => SyncService.signOut()), child: const Text('اطلعوا من الحساب')),
        ],
        if (_error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_error!, style: TextStyle(color: wf.alert))),
      ]),
    );
  }
}
