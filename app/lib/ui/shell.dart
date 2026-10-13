library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/snapshot.dart';
import '../platform/lock.dart';
import '../platform/sms.dart';
import '../state/providers.dart';
import 'screens/add_sheet.dart';
import 'screens/envelopes_screen.dart';
import 'screens/family_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/report_screen.dart';
import 'screens/week_screen.dart';
import 'theme/theme.dart';
import 'widgets/common.dart';
import 'widgets/guilloche.dart';

/// Decides between onboarding and the app, and keeps background chores
/// (fixed bills, bank messages, the lock) running on resume.
class RootGate extends ConsumerStatefulWidget {
  const RootGate({super.key});
  @override
  ConsumerState<RootGate> createState() => _RootGateState();
}

class _RootGateState extends ConsumerState<RootGate> with WidgetsBindingObserver {
  var _locked = false;
  var _checkedLock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _onOpen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _onOpen();
    if (state == AppLifecycleState.hidden) _lockIfEnabled();
  }

  Future<void> _lockIfEnabled() async {
    if (await ref.read(repositoryProvider).getValue('lock') == '1' && mounted) setState(() => _locked = true);
  }

  Future<void> _onOpen() async {
    final repo = ref.read(repositoryProvider);
    if (!_checkedLock) {
      _checkedLock = true;
      await _lockIfEnabled();
    }
    if (_locked) await _unlock();
    if (!await repo.hasHousehold()) return;
    await repo.postDueBills();
    await SmsReader.scan(repo);
  }

  Future<void> _unlock() async {
    if (await AppLock.unlock() && mounted) setState(() => _locked = false);
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider);
    if (_locked) return _LockScreen(onUnlock: _unlock);
    return snap.when(
      loading: () => const _Splash(),
      error: (e, _) => Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Text('صار خلل بفتح البيانات: $e')))),
      data: (s) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: s == null ? const OnboardingScreen(key: ValueKey('ob')) : Shell(key: const ValueKey('shell'), snap: s),
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();
  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Color(0xFF0B231F),
        body: Center(child: Rosette(size: 220)),
      );
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({required this.onUnlock});
  final VoidCallback onUnlock;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF0B231F),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('وين فلوسي', style: TextStyle(fontFamily: WfText.brand, fontSize: 40, color: Colors.white)),
            const SizedBox(height: 24),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0B231F), minimumSize: const Size(200, 52)),
              onPressed: onUnlock,
              icon: const Icon(Icons.fingerprint),
              label: const Text('افتحوا'),
            ),
          ]),
        ),
      );
}

class Shell extends ConsumerWidget {
  const Shell({super.key, required this.snap});
  final Snapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(tabProvider);
    final wf = Wf.of(context);
    final pages = [
      WeekScreen(snap: snap),
      EnvelopesScreen(snap: snap),
      ReportScreen(snap: snap),
      FamilyScreen(snap: snap),
    ];
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: wf.surface, border: Border(top: BorderSide(color: wf.line))),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(children: [
              _Tab(icon: Icons.layers_outlined, label: 'الأسبوع', index: 0, current: tab),
              _Tab(icon: Icons.mail_outline, label: 'الظروف', index: 1, current: tab),
              SizedBox(
                width: 96,
                child: OverflowBox(
                  maxHeight: 90,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Semantics(
                      button: true,
                      label: 'سجّلوا صرفة',
                      child: GestureDetector(
                        onLongPress: () {
                          HapticFeedback.heavyImpact();
                          showWfSheet(context, (_) => const AddSheet(startWithVoice: true));
                        },
                        child: Material(
                          color: wf.primary,
                          borderRadius: BorderRadius.circular(24),
                          elevation: 8,
                          shadowColor: wf.shadow,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              showWfSheet(context, (_) => const AddSheet());
                            },
                            child: SizedBox(
                              width: 76,
                              height: 64,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.add, color: wf.onPrimary, size: 26),
                                Text('صرفت', style: TextStyle(color: wf.onPrimary, fontSize: 12, height: 1.3)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _Tab(icon: Icons.call_split, label: 'وين راحت', index: 2, current: tab),
              _Tab(icon: Icons.people_outline, label: 'العائلة', index: 3, current: tab),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Tab extends ConsumerWidget {
  const _Tab({required this.icon, required this.label, required this.index, required this.current});
  final IconData icon;
  final String label;
  final int index;
  final int current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final on = index == current;
    return Expanded(
      child: Semantics(
        selected: on,
        button: true,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            ref.read(tabProvider.notifier).go(index);
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 22, color: on ? wf.ink : wf.mute),
            Text(label, style: TextStyle(fontSize: 11, height: 1.3, color: on ? wf.ink : wf.mute, fontWeight: on ? FontWeight.w600 : FontWeight.w400)),
          ]),
        ),
      ),
    );
  }
}
