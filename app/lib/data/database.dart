/// Local-first database (Drift on SQLite3MultipleCiphers). Every synced row
/// carries an id generated on the device (UUIDv7), timestamps, a soft-delete
/// marker and a dirty flag the sync engine pushes.
library;

import 'package:drift/drift.dart';

part 'database.g.dart';

mixin SyncedRow on Table {
  TextColumn get id => text()();
  TextColumn get householdId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get dirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class Households extends Table with SyncedRow {
  TextColumn get name => text()();
  TextColumn get baseCurrency => text().withDefault(const Constant('IQD'))();

  /// Dinars for one US dollar, used as the default for new entries.
  IntColumn get usdRate => integer().withDefault(const Constant(1520))();
  TextColumn get inviteCode => text().nullable()();
}

class Members extends Table with SyncedRow {
  TextColumn get displayName => text()();

  /// owner | member | child
  TextColumn get role => text()();
  TextColumn get letter => text()();
  IntColumn get colorIndex => integer().withDefault(const Constant(0))();

  /// Supabase auth user, when the member has an account.
  TextColumn get userId => text().nullable()();

  /// Monthly "no questions asked" money; only the total is shown to others.
  IntColumn get freeAllowance => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class Wallets extends Table with SyncedRow {
  TextColumn get name => text()();

  /// cash | qi_card | bank | other
  TextColumn get kind => text()();
  TextColumn get currency => text().withDefault(const Constant('IQD'))();
  TextColumn get ownerMemberId => text().nullable()();
}

class Categories extends Table with SyncedRow {
  TextColumn get key => text()();
  TextColumn get name => text()();

  /// expense | income
  TextColumn get kind => text()();
  TextColumn get groupName => text()();
  BoolColumn get isFixed => boolean().withDefault(const Constant(false))();

  /// Comma separated words the parser maps here.
  TextColumn get keywords => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class Envelopes extends Table with SyncedRow {
  TextColumn get name => text()();

  /// vault | sinking | goal
  TextColumn get kind => text()();
  IntColumn get targetMinor => integer().withDefault(const Constant(0))();
  IntColumn get monthlyMinor => integer().withDefault(const Constant(0))();

  /// Both parents must agree before money leaves a locked envelope.
  BoolColumn get locked => boolean().withDefault(const Constant(false))();

  /// Which note is drawn peeking out of the envelope.
  IntColumn get noteDenomination => integer().withDefault(const Constant(10000))();
  TextColumn get memberId => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

/// One money movement. Kinds:
///   expense, income            money leaves / enters a wallet
///   transfer                   wallet to wallet (ATM withdrawal = Qi Card to cash)
///   envelope_in, envelope_out  money set aside into / taken from an envelope
///   adjust                     wallet balance set by counting (not spending)
class Txns extends Table with SyncedRow {
  TextColumn get kind => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text().withDefault(const Constant('IQD'))();

  /// Dinars per dollar at the moment of the transaction.
  IntColumn get fxRate => integer().withDefault(const Constant(1))();

  /// Amount in dinars, frozen at entry so old reports never change.
  IntColumn get amountBase => integer()();
  TextColumn get walletId => text().nullable()();
  TextColumn get toWalletId => text().nullable()();
  TextColumn get categoryKey => text().nullable()();
  TextColumn get envelopeId => text().nullable()();
  TextColumn get memberId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();

  /// What people called it ("صمون"), shown in lists.
  TextColumn get label => text().withDefault(const Constant(''))();
  TextColumn get note => text().withDefault(const Constant(''))();

  /// manual | text | voice | quick | sms | notification | pocket | recurring | payday | friday
  TextColumn get source => text().withDefault(const Constant('manual'))();

  /// True for everyday spending that comes out of the weekly allowance.
  BoolColumn get countsInWeek => boolean().withDefault(const Constant(false))();
}

class Plans extends Table with SyncedRow {
  IntColumn get salary => integer()();
  IntColumn get savePercent => integer().withDefault(const Constant(10))();
  IntColumn get payDay => integer().withDefault(const Constant(1))();
  IntColumn get minPerDay => integer().withDefault(const Constant(15000))();
}

class Bills extends Table with SyncedRow {
  TextColumn get name => text()();

  /// bolt | wifi | phone | bus | home | other
  TextColumn get icon => text()();
  IntColumn get amountMinor => integer()();
  IntColumn get dayOfMonth => integer()();
  TextColumn get categoryKey => text()();

  /// Generator bills are amps × price per amp; both editable.
  IntColumn get amps => integer().nullable()();
  IntColumn get pricePerAmp => integer().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  /// "2026-10" once this month's bill has been posted.
  TextColumn get lastPosted => text().nullable()();
}

class Debts extends Table with SyncedRow {
  TextColumn get personName => text()();

  /// in = they owe us, out = we owe them
  TextColumn get direction => text()();
  IntColumn get amountMinor => integer()();
  IntColumn get paidMinor => integer().withDefault(const Constant(0))();
  TextColumn get note => text().withDefault(const Constant(''))();
  BoolColumn get forgiven => boolean().withDefault(const Constant(false))();
}

class Roscas extends Table with SyncedRow {
  TextColumn get name => text()();
  TextColumn get organizer => text().withDefault(const Constant(''))();
  IntColumn get membersCount => integer()();
  IntColumn get contribution => integer()();
  IntColumn get startYear => integer()();
  IntColumn get startMonth => integer()();
  IntColumn get myTurn => integer()();
  IntColumn get paidRounds => integer().withDefault(const Constant(0))();

  /// Free text warning, e.g. someone collected and then paid late.
  TextColumn get warning => text().withDefault(const Constant(''))();
}

class KidProfiles extends Table with SyncedRow {
  TextColumn get memberId => text()();
  TextColumn get goalName => text().withDefault(const Constant('الهدف'))();
  IntColumn get goalMinor => integer().withDefault(const Constant(0))();

  /// Parent adds this percent of every save deposit (50 = 500 per 1,000).
  IntColumn get matchPercent => integer().withDefault(const Constant(50))();
  IntColumn get weeklyAllowance => integer().withDefault(const Constant(5000))();
}

/// Child jars: spend | save | give. kind: deposit | match | spend | allowance
class KidEntries extends Table with SyncedRow {
  TextColumn get memberId => text()();
  TextColumn get jar => text()();
  TextColumn get kind => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get label => text().withDefault(const Constant(''))();
  DateTimeColumn get occurredAt => dateTime()();
}

class WeekCloses extends Table with SyncedRow {
  DateTimeColumn get weekStart => dateTime()();
  IntColumn get leftover => integer()();
  IntColumn get toVault => integer()();
  IntColumn get carried => integer()();
}

/// Bank messages waiting for a one-tap confirmation. Local to the phone that
/// read them; the confirmed transaction is what syncs.
class InboxItems extends Table {
  TextColumn get id => text()();
  TextColumn get smsKey => text().unique()();
  TextColumn get sender => text()();
  TextColumn get body => text()();
  DateTimeColumn get receivedAt => dateTime()();

  /// purchase | withdrawal | credit
  TextColumn get kind => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text()();
  TextColumn get merchant => text().nullable()();
  TextColumn get suggestedCategory => text()();

  /// pending | accepted | dismissed
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get txnId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Device-only settings and markers (theme, sync cursors, last SMS scan).
class KeyValues extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [
  Households, Members, Wallets, Categories, Envelopes, Txns, Plans, Bills, Debts, Roscas,
  KidProfiles, KidEntries, WeekCloses, InboxItems, KeyValues,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement('CREATE INDEX txns_household_time ON txns (household_id, occurred_at)');
          await customStatement('CREATE INDEX txns_dirty ON txns (dirty)');
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Every synced table, in an order that keeps references valid when pulled.
  List<TableInfo<Table, Object?>> get syncedTables => [
        households, members, wallets, categories, envelopes, plans, bills, debts, roscas,
        kidProfiles, kidEntries, weekCloses, txns,
      ];
}
