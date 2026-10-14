/// The week's money shown as Iraqi dinar notes. Pure functions so the stack
/// animation and the "what leaves the stack" preview agree exactly.
library;

const List<int> kDenominations = [25000, 10000, 5000, 1000, 500, 250];

/// Greedy split of [amount] into notes, smallest first (bottom of the stack
/// first, so the largest note sits on top). Remainders under 250 are dropped:
/// there are no coins in daily use.
List<int> breakdown(int amount) {
  final out = <int>[];
  var rest = amount < 0 ? 0 : amount;
  for (final d in kDenominations) {
    while (rest >= d) {
      out.add(d);
      rest -= d;
    }
  }
  out.sort();
  return out;
}

class NotesDiff {
  const NotesDiff(this.removed, this.added);

  /// Notes that leave the stack, largest first.
  final List<int> removed;

  /// Notes that come back as change, largest first.
  final List<int> added;
}

/// Which notes leave and which come back when the stack moves from [before]
/// to [after]. Counts per denomination, so it is independent of order.
NotesDiff diffNotes(int before, int after) {
  final a = _count(breakdown(before));
  final b = _count(breakdown(after));
  final removed = <int>[];
  final added = <int>[];
  for (final d in kDenominations) {
    final delta = (a[d] ?? 0) - (b[d] ?? 0);
    for (var i = 0; i < delta; i++) {
      removed.add(d);
    }
    for (var i = 0; i < -delta; i++) {
      added.add(d);
    }
  }
  return NotesDiff(removed, added);
}

Map<int, int> _count(List<int> notes) {
  final m = <int, int>{};
  for (final n in notes) {
    m[n] = (m[n] ?? 0) + 1;
  }
  return m;
}

/// The note that best represents [amount] in small previews.
int denominationFor(int amount) =>
    kDenominations.firstWhere((d) => amount >= d, orElse: () => kDenominations.last);

class NotesPick {
  const NotesPick(this.indexes, this.total);

  /// Indexes into the notes list that would be handed over.
  final Set<int> indexes;
  final int total;

  int changeFor(int price) => total > price ? total - price : 0;
}

/// Chooses notes from [notes] to pay [price]: exact if possible, otherwise the
/// smallest single note that covers the gap, otherwise everything needed.
NotesPick pickNotes(List<int> notes, int price) {
  final order = List<int>.generate(notes.length, (i) => i)
    ..sort((x, y) => notes[y].compareTo(notes[x]));
  var sum = 0;
  final used = <int>{};
  for (final i in order) {
    if (sum + notes[i] <= price) {
      sum += notes[i];
      used.add(i);
    }
  }
  if (sum < price) {
    final rest = order.where((i) => !used.contains(i)).toList()
      ..sort((x, y) => notes[x].compareTo(notes[y]));
    final cover = rest.where((i) => notes[i] >= price - sum);
    if (cover.isNotEmpty) {
      sum += notes[cover.first];
      used.add(cover.first);
    }
    for (final i in order) {
      if (sum >= price) break;
      if (used.add(i)) sum += notes[i];
    }
  }
  return NotesPick(used, sum);
}

/// How people say each note, used on the small note chips.
String shortNoteLabel(int d) => switch (d) {
      25000 => '25 ألف',
      10000 => '10 آلاف',
      5000 => '5 آلاف',
      1000 => 'ألف',
      _ => '$d',
    };

String noteWords(int d) => switch (d) {
      25000 => 'خمسة وعشرون ألف دينار',
      10000 => 'عشرة آلاف دينار',
      5000 => 'خمسة آلاف دينار',
      1000 => 'ألف دينار',
      500 => 'خمسمية دينار',
      _ => 'ميتين وخمسين دينار',
    };

String easternDigits(int value) {
  const e = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return value.toString().split('').map((c) => e[int.parse(c)]).join();
}

/// "4 ورقات 25 ألف + ورقة 5 آلاف", largest note first.
String notesSentence(int amount) {
  final counts = <int, int>{};
  for (final n in breakdown(amount)) {
    counts[n] = (counts[n] ?? 0) + 1;
  }
  final parts = [
    for (final d in kDenominations)
      if (counts[d] case final c?) '${_sheets(c)} ${shortNoteLabel(d)}',
  ];
  return parts.join(' + ');
}

String _sheets(int n) => switch (n) {
      1 => 'ورقة',
      2 => 'ورقتين',
      <= 10 => '$n ورقات',
      _ => '$n ورقة',
    };
