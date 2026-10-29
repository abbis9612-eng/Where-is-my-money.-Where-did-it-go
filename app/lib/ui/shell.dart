library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/snapshot.dart';
import '../platform/lock.dart';
import '../platform/sms.dart';
import '../state/providers.dart';
import '../sync/sync_service.dart';
import 'screens/add_sheet.dart';
import 'screens/envelopes_screen.dart';
import 'screens/family_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/report_screen.dart';
import 'screens/week_screen.dart';
import 'theme/theme.dart';
import 'widgets/common.dart';
import 'widgets/guilloche.dart';
import 'widgets/wf_icons.dart';

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
  // The fingerprint prompt itself backgrounds the app; ignore those events.
  var _authenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SyncService.start(ref.read(repositoryProvider));
    _onOpen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_authenticating) return;
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
    // Chores never block the screen; a failure waits for the next resume.
    try {
      await repo.ensureDefaultCategories();
      await repo.postDueBills();
      await SmsReader.scan(repo);
      await SyncService.syncNow(repo);
    } catch (_) {}
  }

  Future<void> _unlock() async {
    if (_authenticating) return;
    _authenticating = true;
    try {
      if (await AppLock.unlock() && mounted) setState(() => _locked = false);
    } finally {
      _authenticating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(snapshotProvider);
    if (_locked) return _LockScreen(onUnlock: _unlock);
    return snap.when(
      loading: () => const _Splash(),
      error: (e, _) => Scaffold(
        body: Center(
          child: Padding(padding: const EdgeInsets.all(24), child: Text('صار خلل بفتح البيانات: $e')),
        ),
      ),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'وين فلوسي',
            style: TextStyle(fontFamily: WfText.brand, fontSize: 40, color: Colors.white),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0B231F), minimumSize: const Size(200, 52)),
            onPressed: onUnlock,
            icon: const Icon(Icons.fingerprint),
            label: const Text('افتحوا'),
          ),
        ],
      ),
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
    final pages = [WeekScreen(snap: snap), EnvelopesScreen(snap: snap), ReportScreen(snap: snap), FamilyScreen(snap: snap)];
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: Container(
        color: wf.bg,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The thumb dock lives where the thumb rests, on the home tab.
                AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  child: tab == 0 ? const Padding(padding: EdgeInsets.only(bottom: 6), child: AddDock()) : const SizedBox(width: double.infinity),
                ),
                Row(
                  children: [
                    _Tab(glyph: WfGlyph.today, label: 'اليوم', index: 0, current: tab),
                    _Tab(glyph: WfGlyph.envelopes, label: 'الظروف', index: 1, current: tab),
                    _Tab(glyph: WfGlyph.whereWent, label: 'وين راحت', index: 2, current: tab),
                    _Tab(glyph: WfGlyph.family, label: 'العائلة', index: 3, current: tab),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: tab == 0
          ? null
          : Semantics(
              label: 'سجّلوا صرفة',
              button: true,
              excludeSemantics: true,
              child: FloatingActionButton(
                onPressed: () => _openAdd(context),
                backgroundColor: wf.primary,
                foregroundColor: wf.onPrimary,
                elevation: 3,
                highlightElevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: WfIcon(WfGlyph.add, size: 30, color: wf.onPrimary, background: wf.primary),
              ),
            ),
    );
  }
}

void _openAdd(BuildContext context, {bool voice = false}) {
  HapticFeedback.mediumImpact();
  showWfSheet(context, (_) => AddSheet(startWithVoice: voice));
}

/// The green «صرفت» button with the gold voice button beside it.
class AddDock extends StatelessWidget {
  const AddDock({super.key});

  @override
  Widget build(BuildContext context) {
    final wf = Wf.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              label: 'صرفت، سجّلوا صرفة',
              excludeSemantics: true,
              child: GestureDetector(
                onLongPress: () => _openAdd(context, voice: true),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: dark ? Colors.black54 : wf.primary.withValues(alpha: .35),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: Material(
                    color: wf.primary,
                    borderRadius: BorderRadius.circular(22),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => _openAdd(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WfIcon(WfGlyph.add, size: 30, color: wf.onPrimary, background: wf.primary),
                          const SizedBox(width: 10),
                          Text(
                            'صرفت',
                            style: TextStyle(color: wf.onPrimary, fontSize: 19, fontWeight: FontWeight.w700, height: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            button: true,
            label: 'گولوها بصوتكم',
            excludeSemantics: true,
            child: Material(
              borderRadius: BorderRadius.circular(22),
              color: Colors.transparent,
              child: Ink(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF0D48F), Color(0xFFD8AE55)]),
                  boxShadow: const [BoxShadow(color: Color(0x66B88D3A), blurRadius: 24, offset: Offset(0, 12), spreadRadius: -10)],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () => _openAdd(context, voice: true),
                  child: const Center(
                    child: WfIcon(WfGlyph.mic, size: 30, color: Color(0xFF2B1D00), background: Color(0xFFE9C979)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends ConsumerWidget {
  const _Tab({required this.glyph, required this.label, required this.index, required this.current});
  final WfGlyph glyph;
  final String label;
  final int index;
  final int current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wf = Wf.of(context);
    final on = index == current;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = on ? (dark ? const Color(0xFF13302A) : wf.tint) : wf.bg;
    final ink = on ? (dark ? wf.mint : Wf.vaultGreen) : wf.mute;
    return Expanded(
      child: Semantics(
        selected: on,
        button: true,
        label: label,
        excludeSemantics: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Material(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                HapticFeedback.selectionClick();
                ref.read(tabProvider.notifier).go(index);
              },
              child: SizedBox(
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WfIcon(glyph, size: 26, color: ink, background: bg),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: TextStyle(fontSize: 12, height: 1.3, color: ink, fontWeight: on ? FontWeight.w600 : FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
