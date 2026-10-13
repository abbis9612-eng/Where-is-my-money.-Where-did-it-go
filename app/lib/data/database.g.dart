// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HouseholdsTable extends Households
    with TableInfo<$HouseholdsTable, Household> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseholdsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IQD'),
  );
  static const VerificationMeta _usdRateMeta = const VerificationMeta(
    'usdRate',
  );
  @override
  late final GeneratedColumn<int> usdRate = GeneratedColumn<int>(
    'usd_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1520),
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    baseCurrency,
    usdRate,
    inviteCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'households';
  @override
  VerificationContext validateIntegrity(
    Insertable<Household> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('usd_rate')) {
      context.handle(
        _usdRateMeta,
        usdRate.isAcceptableOrUnknown(data['usd_rate']!, _usdRateMeta),
      );
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Household map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Household(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      usdRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usd_rate'],
      )!,
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      ),
    );
  }

  @override
  $HouseholdsTable createAlias(String alias) {
    return $HouseholdsTable(attachedDatabase, alias);
  }
}

class Household extends DataClass implements Insertable<Household> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String name;
  final String baseCurrency;

  /// Dinars for one US dollar, used as the default for new entries.
  final int usdRate;
  final String? inviteCode;
  const Household({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.name,
    required this.baseCurrency,
    required this.usdRate,
    this.inviteCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['usd_rate'] = Variable<int>(usdRate);
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    return map;
  }

  HouseholdsCompanion toCompanion(bool nullToAbsent) {
    return HouseholdsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      name: Value(name),
      baseCurrency: Value(baseCurrency),
      usdRate: Value(usdRate),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
    );
  }

  factory Household.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Household(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      usdRate: serializer.fromJson<int>(json['usdRate']),
      inviteCode: serializer.fromJson<String?>(json['inviteCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'usdRate': serializer.toJson<int>(usdRate),
      'inviteCode': serializer.toJson<String?>(inviteCode),
    };
  }

  Household copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? name,
    String? baseCurrency,
    int? usdRate,
    Value<String?> inviteCode = const Value.absent(),
  }) => Household(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    usdRate: usdRate ?? this.usdRate,
    inviteCode: inviteCode.present ? inviteCode.value : this.inviteCode,
  );
  Household copyWithCompanion(HouseholdsCompanion data) {
    return Household(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      usdRate: data.usdRate.present ? data.usdRate.value : this.usdRate,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Household(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('usdRate: $usdRate, ')
          ..write('inviteCode: $inviteCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    baseCurrency,
    usdRate,
    inviteCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Household &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.baseCurrency == this.baseCurrency &&
          other.usdRate == this.usdRate &&
          other.inviteCode == this.inviteCode);
}

class HouseholdsCompanion extends UpdateCompanion<Household> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<String> baseCurrency;
  final Value<int> usdRate;
  final Value<String?> inviteCode;
  final Value<int> rowid;
  const HouseholdsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.usdRate = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HouseholdsCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    this.baseCurrency = const Value.absent(),
    this.usdRate = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name);
  static Insertable<Household> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<String>? baseCurrency,
    Expression<int>? usdRate,
    Expression<String>? inviteCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (usdRate != null) 'usd_rate': usdRate,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HouseholdsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? name,
    Value<String>? baseCurrency,
    Value<int>? usdRate,
    Value<String?>? inviteCode,
    Value<int>? rowid,
  }) {
    return HouseholdsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      usdRate: usdRate ?? this.usdRate,
      inviteCode: inviteCode ?? this.inviteCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (usdRate.present) {
      map['usd_rate'] = Variable<int>(usdRate.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseholdsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('usdRate: $usdRate, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _letterMeta = const VerificationMeta('letter');
  @override
  late final GeneratedColumn<String> letter = GeneratedColumn<String>(
    'letter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIndexMeta = const VerificationMeta(
    'colorIndex',
  );
  @override
  late final GeneratedColumn<int> colorIndex = GeneratedColumn<int>(
    'color_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _freeAllowanceMeta = const VerificationMeta(
    'freeAllowance',
  );
  @override
  late final GeneratedColumn<int> freeAllowance = GeneratedColumn<int>(
    'free_allowance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    displayName,
    role,
    letter,
    colorIndex,
    userId,
    freeAllowance,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('letter')) {
      context.handle(
        _letterMeta,
        letter.isAcceptableOrUnknown(data['letter']!, _letterMeta),
      );
    } else if (isInserting) {
      context.missing(_letterMeta);
    }
    if (data.containsKey('color_index')) {
      context.handle(
        _colorIndexMeta,
        colorIndex.isAcceptableOrUnknown(data['color_index']!, _colorIndexMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('free_allowance')) {
      context.handle(
        _freeAllowanceMeta,
        freeAllowance.isAcceptableOrUnknown(
          data['free_allowance']!,
          _freeAllowanceMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      letter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}letter'],
      )!,
      colorIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_index'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      freeAllowance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}free_allowance'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String displayName;

  /// owner | member | child
  final String role;
  final String letter;
  final int colorIndex;

  /// Supabase auth user, when the member has an account.
  final String? userId;

  /// Monthly "no questions asked" money; only the total is shown to others.
  final int freeAllowance;
  final int sortOrder;
  const Member({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.displayName,
    required this.role,
    required this.letter,
    required this.colorIndex,
    this.userId,
    required this.freeAllowance,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['display_name'] = Variable<String>(displayName);
    map['role'] = Variable<String>(role);
    map['letter'] = Variable<String>(letter);
    map['color_index'] = Variable<int>(colorIndex);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['free_allowance'] = Variable<int>(freeAllowance);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      displayName: Value(displayName),
      role: Value(role),
      letter: Value(letter),
      colorIndex: Value(colorIndex),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      freeAllowance: Value(freeAllowance),
      sortOrder: Value(sortOrder),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      displayName: serializer.fromJson<String>(json['displayName']),
      role: serializer.fromJson<String>(json['role']),
      letter: serializer.fromJson<String>(json['letter']),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      userId: serializer.fromJson<String?>(json['userId']),
      freeAllowance: serializer.fromJson<int>(json['freeAllowance']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'displayName': serializer.toJson<String>(displayName),
      'role': serializer.toJson<String>(role),
      'letter': serializer.toJson<String>(letter),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'userId': serializer.toJson<String?>(userId),
      'freeAllowance': serializer.toJson<int>(freeAllowance),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Member copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? displayName,
    String? role,
    String? letter,
    int? colorIndex,
    Value<String?> userId = const Value.absent(),
    int? freeAllowance,
    int? sortOrder,
  }) => Member(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    displayName: displayName ?? this.displayName,
    role: role ?? this.role,
    letter: letter ?? this.letter,
    colorIndex: colorIndex ?? this.colorIndex,
    userId: userId.present ? userId.value : this.userId,
    freeAllowance: freeAllowance ?? this.freeAllowance,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      role: data.role.present ? data.role.value : this.role,
      letter: data.letter.present ? data.letter.value : this.letter,
      colorIndex: data.colorIndex.present
          ? data.colorIndex.value
          : this.colorIndex,
      userId: data.userId.present ? data.userId.value : this.userId,
      freeAllowance: data.freeAllowance.present
          ? data.freeAllowance.value
          : this.freeAllowance,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('letter: $letter, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('userId: $userId, ')
          ..write('freeAllowance: $freeAllowance, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    displayName,
    role,
    letter,
    colorIndex,
    userId,
    freeAllowance,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.displayName == this.displayName &&
          other.role == this.role &&
          other.letter == this.letter &&
          other.colorIndex == this.colorIndex &&
          other.userId == this.userId &&
          other.freeAllowance == this.freeAllowance &&
          other.sortOrder == this.sortOrder);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> displayName;
  final Value<String> role;
  final Value<String> letter;
  final Value<int> colorIndex;
  final Value<String?> userId;
  final Value<int> freeAllowance;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.letter = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.userId = const Value.absent(),
    this.freeAllowance = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String displayName,
    required String role,
    required String letter,
    this.colorIndex = const Value.absent(),
    this.userId = const Value.absent(),
    this.freeAllowance = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       displayName = Value(displayName),
       role = Value(role),
       letter = Value(letter);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? displayName,
    Expression<String>? role,
    Expression<String>? letter,
    Expression<int>? colorIndex,
    Expression<String>? userId,
    Expression<int>? freeAllowance,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (displayName != null) 'display_name': displayName,
      if (role != null) 'role': role,
      if (letter != null) 'letter': letter,
      if (colorIndex != null) 'color_index': colorIndex,
      if (userId != null) 'user_id': userId,
      if (freeAllowance != null) 'free_allowance': freeAllowance,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? displayName,
    Value<String>? role,
    Value<String>? letter,
    Value<int>? colorIndex,
    Value<String?>? userId,
    Value<int>? freeAllowance,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      letter: letter ?? this.letter,
      colorIndex: colorIndex ?? this.colorIndex,
      userId: userId ?? this.userId,
      freeAllowance: freeAllowance ?? this.freeAllowance,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (letter.present) {
      map['letter'] = Variable<String>(letter.value);
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (freeAllowance.present) {
      map['free_allowance'] = Variable<int>(freeAllowance.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('letter: $letter, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('userId: $userId, ')
          ..write('freeAllowance: $freeAllowance, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalletsTable extends Wallets with TableInfo<$WalletsTable, Wallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IQD'),
  );
  static const VerificationMeta _ownerMemberIdMeta = const VerificationMeta(
    'ownerMemberId',
  );
  @override
  late final GeneratedColumn<String> ownerMemberId = GeneratedColumn<String>(
    'owner_member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    kind,
    currency,
    ownerMemberId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Wallet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('owner_member_id')) {
      context.handle(
        _ownerMemberIdMeta,
        ownerMemberId.isAcceptableOrUnknown(
          data['owner_member_id']!,
          _ownerMemberIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wallet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      ownerMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_member_id'],
      ),
    );
  }

  @override
  $WalletsTable createAlias(String alias) {
    return $WalletsTable(attachedDatabase, alias);
  }
}

class Wallet extends DataClass implements Insertable<Wallet> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String name;

  /// cash | qi_card | bank | other
  final String kind;
  final String currency;
  final String? ownerMemberId;
  const Wallet({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.name,
    required this.kind,
    required this.currency,
    this.ownerMemberId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || ownerMemberId != null) {
      map['owner_member_id'] = Variable<String>(ownerMemberId);
    }
    return map;
  }

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      name: Value(name),
      kind: Value(kind),
      currency: Value(currency),
      ownerMemberId: ownerMemberId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerMemberId),
    );
  }

  factory Wallet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallet(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      currency: serializer.fromJson<String>(json['currency']),
      ownerMemberId: serializer.fromJson<String?>(json['ownerMemberId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'currency': serializer.toJson<String>(currency),
      'ownerMemberId': serializer.toJson<String?>(ownerMemberId),
    };
  }

  Wallet copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? name,
    String? kind,
    String? currency,
    Value<String?> ownerMemberId = const Value.absent(),
  }) => Wallet(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    currency: currency ?? this.currency,
    ownerMemberId: ownerMemberId.present
        ? ownerMemberId.value
        : this.ownerMemberId,
  );
  Wallet copyWithCompanion(WalletsCompanion data) {
    return Wallet(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      currency: data.currency.present ? data.currency.value : this.currency,
      ownerMemberId: data.ownerMemberId.present
          ? data.ownerMemberId.value
          : this.ownerMemberId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('currency: $currency, ')
          ..write('ownerMemberId: $ownerMemberId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    kind,
    currency,
    ownerMemberId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.currency == this.currency &&
          other.ownerMemberId == this.ownerMemberId);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> currency;
  final Value<String?> ownerMemberId;
  final Value<int> rowid;
  const WalletsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.currency = const Value.absent(),
    this.ownerMemberId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalletsCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    required String kind,
    this.currency = const Value.absent(),
    this.ownerMemberId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name),
       kind = Value(kind);
  static Insertable<Wallet> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? currency,
    Expression<String>? ownerMemberId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (currency != null) 'currency': currency,
      if (ownerMemberId != null) 'owner_member_id': ownerMemberId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalletsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? currency,
    Value<String?>? ownerMemberId,
    Value<int>? rowid,
  }) {
    return WalletsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      currency: currency ?? this.currency,
      ownerMemberId: ownerMemberId ?? this.ownerMemberId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (ownerMemberId.present) {
      map['owner_member_id'] = Variable<String>(ownerMemberId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('currency: $currency, ')
          ..write('ownerMemberId: $ownerMemberId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFixedMeta = const VerificationMeta(
    'isFixed',
  );
  @override
  late final GeneratedColumn<bool> isFixed = GeneratedColumn<bool>(
    'is_fixed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fixed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _keywordsMeta = const VerificationMeta(
    'keywords',
  );
  @override
  late final GeneratedColumn<String> keywords = GeneratedColumn<String>(
    'keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    key,
    name,
    kind,
    groupName,
    isFixed,
    keywords,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('is_fixed')) {
      context.handle(
        _isFixedMeta,
        isFixed.isAcceptableOrUnknown(data['is_fixed']!, _isFixedMeta),
      );
    }
    if (data.containsKey('keywords')) {
      context.handle(
        _keywordsMeta,
        keywords.isAcceptableOrUnknown(data['keywords']!, _keywordsMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      isFixed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fixed'],
      )!,
      keywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keywords'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String key;
  final String name;

  /// expense | income
  final String kind;
  final String groupName;
  final bool isFixed;

  /// Comma separated words the parser maps here.
  final String keywords;
  final int sortOrder;
  const Category({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.key,
    required this.name,
    required this.kind,
    required this.groupName,
    required this.isFixed,
    required this.keywords,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['group_name'] = Variable<String>(groupName);
    map['is_fixed'] = Variable<bool>(isFixed);
    map['keywords'] = Variable<String>(keywords);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      key: Value(key),
      name: Value(name),
      kind: Value(kind),
      groupName: Value(groupName),
      isFixed: Value(isFixed),
      keywords: Value(keywords),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      groupName: serializer.fromJson<String>(json['groupName']),
      isFixed: serializer.fromJson<bool>(json['isFixed']),
      keywords: serializer.fromJson<String>(json['keywords']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'groupName': serializer.toJson<String>(groupName),
      'isFixed': serializer.toJson<bool>(isFixed),
      'keywords': serializer.toJson<String>(keywords),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? key,
    String? name,
    String? kind,
    String? groupName,
    bool? isFixed,
    String? keywords,
    int? sortOrder,
  }) => Category(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    key: key ?? this.key,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    groupName: groupName ?? this.groupName,
    isFixed: isFixed ?? this.isFixed,
    keywords: keywords ?? this.keywords,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      isFixed: data.isFixed.present ? data.isFixed.value : this.isFixed,
      keywords: data.keywords.present ? data.keywords.value : this.keywords,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('groupName: $groupName, ')
          ..write('isFixed: $isFixed, ')
          ..write('keywords: $keywords, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    key,
    name,
    kind,
    groupName,
    isFixed,
    keywords,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.key == this.key &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.groupName == this.groupName &&
          other.isFixed == this.isFixed &&
          other.keywords == this.keywords &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> key;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> groupName;
  final Value<bool> isFixed;
  final Value<String> keywords;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.groupName = const Value.absent(),
    this.isFixed = const Value.absent(),
    this.keywords = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String key,
    required String name,
    required String kind,
    required String groupName,
    this.isFixed = const Value.absent(),
    this.keywords = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       key = Value(key),
       name = Value(name),
       kind = Value(kind),
       groupName = Value(groupName);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? groupName,
    Expression<bool>? isFixed,
    Expression<String>? keywords,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (groupName != null) 'group_name': groupName,
      if (isFixed != null) 'is_fixed': isFixed,
      if (keywords != null) 'keywords': keywords,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? key,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? groupName,
    Value<bool>? isFixed,
    Value<String>? keywords,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      key: key ?? this.key,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      groupName: groupName ?? this.groupName,
      isFixed: isFixed ?? this.isFixed,
      keywords: keywords ?? this.keywords,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (isFixed.present) {
      map['is_fixed'] = Variable<bool>(isFixed.value);
    }
    if (keywords.present) {
      map['keywords'] = Variable<String>(keywords.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('groupName: $groupName, ')
          ..write('isFixed: $isFixed, ')
          ..write('keywords: $keywords, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EnvelopesTable extends Envelopes
    with TableInfo<$EnvelopesTable, Envelope> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnvelopesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMinorMeta = const VerificationMeta(
    'targetMinor',
  );
  @override
  late final GeneratedColumn<int> targetMinor = GeneratedColumn<int>(
    'target_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _monthlyMinorMeta = const VerificationMeta(
    'monthlyMinor',
  );
  @override
  late final GeneratedColumn<int> monthlyMinor = GeneratedColumn<int>(
    'monthly_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lockedMeta = const VerificationMeta('locked');
  @override
  late final GeneratedColumn<bool> locked = GeneratedColumn<bool>(
    'locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("locked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteDenominationMeta = const VerificationMeta(
    'noteDenomination',
  );
  @override
  late final GeneratedColumn<int> noteDenomination = GeneratedColumn<int>(
    'note_denomination',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10000),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    kind,
    targetMinor,
    monthlyMinor,
    locked,
    noteDenomination,
    memberId,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'envelopes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Envelope> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('target_minor')) {
      context.handle(
        _targetMinorMeta,
        targetMinor.isAcceptableOrUnknown(
          data['target_minor']!,
          _targetMinorMeta,
        ),
      );
    }
    if (data.containsKey('monthly_minor')) {
      context.handle(
        _monthlyMinorMeta,
        monthlyMinor.isAcceptableOrUnknown(
          data['monthly_minor']!,
          _monthlyMinorMeta,
        ),
      );
    }
    if (data.containsKey('locked')) {
      context.handle(
        _lockedMeta,
        locked.isAcceptableOrUnknown(data['locked']!, _lockedMeta),
      );
    }
    if (data.containsKey('note_denomination')) {
      context.handle(
        _noteDenominationMeta,
        noteDenomination.isAcceptableOrUnknown(
          data['note_denomination']!,
          _noteDenominationMeta,
        ),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Envelope map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Envelope(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      targetMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_minor'],
      )!,
      monthlyMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_minor'],
      )!,
      locked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}locked'],
      )!,
      noteDenomination: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_denomination'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $EnvelopesTable createAlias(String alias) {
    return $EnvelopesTable(attachedDatabase, alias);
  }
}

class Envelope extends DataClass implements Insertable<Envelope> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String name;

  /// vault | sinking | goal
  final String kind;
  final int targetMinor;
  final int monthlyMinor;

  /// Both parents must agree before money leaves a locked envelope.
  final bool locked;

  /// Which note is drawn peeking out of the envelope.
  final int noteDenomination;
  final String? memberId;
  final int sortOrder;
  const Envelope({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.name,
    required this.kind,
    required this.targetMinor,
    required this.monthlyMinor,
    required this.locked,
    required this.noteDenomination,
    this.memberId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['target_minor'] = Variable<int>(targetMinor);
    map['monthly_minor'] = Variable<int>(monthlyMinor);
    map['locked'] = Variable<bool>(locked);
    map['note_denomination'] = Variable<int>(noteDenomination);
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  EnvelopesCompanion toCompanion(bool nullToAbsent) {
    return EnvelopesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      name: Value(name),
      kind: Value(kind),
      targetMinor: Value(targetMinor),
      monthlyMinor: Value(monthlyMinor),
      locked: Value(locked),
      noteDenomination: Value(noteDenomination),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      sortOrder: Value(sortOrder),
    );
  }

  factory Envelope.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Envelope(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      targetMinor: serializer.fromJson<int>(json['targetMinor']),
      monthlyMinor: serializer.fromJson<int>(json['monthlyMinor']),
      locked: serializer.fromJson<bool>(json['locked']),
      noteDenomination: serializer.fromJson<int>(json['noteDenomination']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'targetMinor': serializer.toJson<int>(targetMinor),
      'monthlyMinor': serializer.toJson<int>(monthlyMinor),
      'locked': serializer.toJson<bool>(locked),
      'noteDenomination': serializer.toJson<int>(noteDenomination),
      'memberId': serializer.toJson<String?>(memberId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Envelope copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? name,
    String? kind,
    int? targetMinor,
    int? monthlyMinor,
    bool? locked,
    int? noteDenomination,
    Value<String?> memberId = const Value.absent(),
    int? sortOrder,
  }) => Envelope(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    targetMinor: targetMinor ?? this.targetMinor,
    monthlyMinor: monthlyMinor ?? this.monthlyMinor,
    locked: locked ?? this.locked,
    noteDenomination: noteDenomination ?? this.noteDenomination,
    memberId: memberId.present ? memberId.value : this.memberId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Envelope copyWithCompanion(EnvelopesCompanion data) {
    return Envelope(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      targetMinor: data.targetMinor.present
          ? data.targetMinor.value
          : this.targetMinor,
      monthlyMinor: data.monthlyMinor.present
          ? data.monthlyMinor.value
          : this.monthlyMinor,
      locked: data.locked.present ? data.locked.value : this.locked,
      noteDenomination: data.noteDenomination.present
          ? data.noteDenomination.value
          : this.noteDenomination,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Envelope(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('targetMinor: $targetMinor, ')
          ..write('monthlyMinor: $monthlyMinor, ')
          ..write('locked: $locked, ')
          ..write('noteDenomination: $noteDenomination, ')
          ..write('memberId: $memberId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    kind,
    targetMinor,
    monthlyMinor,
    locked,
    noteDenomination,
    memberId,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Envelope &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.targetMinor == this.targetMinor &&
          other.monthlyMinor == this.monthlyMinor &&
          other.locked == this.locked &&
          other.noteDenomination == this.noteDenomination &&
          other.memberId == this.memberId &&
          other.sortOrder == this.sortOrder);
}

class EnvelopesCompanion extends UpdateCompanion<Envelope> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<String> kind;
  final Value<int> targetMinor;
  final Value<int> monthlyMinor;
  final Value<bool> locked;
  final Value<int> noteDenomination;
  final Value<String?> memberId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const EnvelopesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.targetMinor = const Value.absent(),
    this.monthlyMinor = const Value.absent(),
    this.locked = const Value.absent(),
    this.noteDenomination = const Value.absent(),
    this.memberId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EnvelopesCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    required String kind,
    this.targetMinor = const Value.absent(),
    this.monthlyMinor = const Value.absent(),
    this.locked = const Value.absent(),
    this.noteDenomination = const Value.absent(),
    this.memberId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name),
       kind = Value(kind);
  static Insertable<Envelope> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? targetMinor,
    Expression<int>? monthlyMinor,
    Expression<bool>? locked,
    Expression<int>? noteDenomination,
    Expression<String>? memberId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (targetMinor != null) 'target_minor': targetMinor,
      if (monthlyMinor != null) 'monthly_minor': monthlyMinor,
      if (locked != null) 'locked': locked,
      if (noteDenomination != null) 'note_denomination': noteDenomination,
      if (memberId != null) 'member_id': memberId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EnvelopesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? name,
    Value<String>? kind,
    Value<int>? targetMinor,
    Value<int>? monthlyMinor,
    Value<bool>? locked,
    Value<int>? noteDenomination,
    Value<String?>? memberId,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return EnvelopesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      targetMinor: targetMinor ?? this.targetMinor,
      monthlyMinor: monthlyMinor ?? this.monthlyMinor,
      locked: locked ?? this.locked,
      noteDenomination: noteDenomination ?? this.noteDenomination,
      memberId: memberId ?? this.memberId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (targetMinor.present) {
      map['target_minor'] = Variable<int>(targetMinor.value);
    }
    if (monthlyMinor.present) {
      map['monthly_minor'] = Variable<int>(monthlyMinor.value);
    }
    if (locked.present) {
      map['locked'] = Variable<bool>(locked.value);
    }
    if (noteDenomination.present) {
      map['note_denomination'] = Variable<int>(noteDenomination.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnvelopesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('targetMinor: $targetMinor, ')
          ..write('monthlyMinor: $monthlyMinor, ')
          ..write('locked: $locked, ')
          ..write('noteDenomination: $noteDenomination, ')
          ..write('memberId: $memberId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxnsTable extends Txns with TableInfo<$TxnsTable, Txn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IQD'),
  );
  static const VerificationMeta _fxRateMeta = const VerificationMeta('fxRate');
  @override
  late final GeneratedColumn<int> fxRate = GeneratedColumn<int>(
    'fx_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _amountBaseMeta = const VerificationMeta(
    'amountBase',
  );
  @override
  late final GeneratedColumn<int> amountBase = GeneratedColumn<int>(
    'amount_base',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toWalletIdMeta = const VerificationMeta(
    'toWalletId',
  );
  @override
  late final GeneratedColumn<String> toWalletId = GeneratedColumn<String>(
    'to_wallet_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryKeyMeta = const VerificationMeta(
    'categoryKey',
  );
  @override
  late final GeneratedColumn<String> categoryKey = GeneratedColumn<String>(
    'category_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _envelopeIdMeta = const VerificationMeta(
    'envelopeId',
  );
  @override
  late final GeneratedColumn<String> envelopeId = GeneratedColumn<String>(
    'envelope_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _countsInWeekMeta = const VerificationMeta(
    'countsInWeek',
  );
  @override
  late final GeneratedColumn<bool> countsInWeek = GeneratedColumn<bool>(
    'counts_in_week',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("counts_in_week" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    kind,
    amountMinor,
    currency,
    fxRate,
    amountBase,
    walletId,
    toWalletId,
    categoryKey,
    envelopeId,
    memberId,
    occurredAt,
    label,
    note,
    source,
    countsInWeek,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Txn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('fx_rate')) {
      context.handle(
        _fxRateMeta,
        fxRate.isAcceptableOrUnknown(data['fx_rate']!, _fxRateMeta),
      );
    }
    if (data.containsKey('amount_base')) {
      context.handle(
        _amountBaseMeta,
        amountBase.isAcceptableOrUnknown(data['amount_base']!, _amountBaseMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBaseMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    }
    if (data.containsKey('to_wallet_id')) {
      context.handle(
        _toWalletIdMeta,
        toWalletId.isAcceptableOrUnknown(
          data['to_wallet_id']!,
          _toWalletIdMeta,
        ),
      );
    }
    if (data.containsKey('category_key')) {
      context.handle(
        _categoryKeyMeta,
        categoryKey.isAcceptableOrUnknown(
          data['category_key']!,
          _categoryKeyMeta,
        ),
      );
    }
    if (data.containsKey('envelope_id')) {
      context.handle(
        _envelopeIdMeta,
        envelopeId.isAcceptableOrUnknown(data['envelope_id']!, _envelopeIdMeta),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('counts_in_week')) {
      context.handle(
        _countsInWeekMeta,
        countsInWeek.isAcceptableOrUnknown(
          data['counts_in_week']!,
          _countsInWeekMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Txn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Txn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      fxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fx_rate'],
      )!,
      amountBase: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_base'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      ),
      toWalletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_wallet_id'],
      ),
      categoryKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_key'],
      ),
      envelopeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}envelope_id'],
      ),
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      countsInWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}counts_in_week'],
      )!,
    );
  }

  @override
  $TxnsTable createAlias(String alias) {
    return $TxnsTable(attachedDatabase, alias);
  }
}

class Txn extends DataClass implements Insertable<Txn> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String kind;
  final int amountMinor;
  final String currency;

  /// Dinars per dollar at the moment of the transaction.
  final int fxRate;

  /// Amount in dinars, frozen at entry so old reports never change.
  final int amountBase;
  final String? walletId;
  final String? toWalletId;
  final String? categoryKey;
  final String? envelopeId;
  final String? memberId;
  final DateTime occurredAt;

  /// What people called it ("صمون"), shown in lists.
  final String label;
  final String note;

  /// manual | text | voice | quick | sms | notification | pocket | recurring | payday | friday
  final String source;

  /// True for everyday spending that comes out of the weekly allowance.
  final bool countsInWeek;
  const Txn({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    required this.fxRate,
    required this.amountBase,
    this.walletId,
    this.toWalletId,
    this.categoryKey,
    this.envelopeId,
    this.memberId,
    required this.occurredAt,
    required this.label,
    required this.note,
    required this.source,
    required this.countsInWeek,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['kind'] = Variable<String>(kind);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency'] = Variable<String>(currency);
    map['fx_rate'] = Variable<int>(fxRate);
    map['amount_base'] = Variable<int>(amountBase);
    if (!nullToAbsent || walletId != null) {
      map['wallet_id'] = Variable<String>(walletId);
    }
    if (!nullToAbsent || toWalletId != null) {
      map['to_wallet_id'] = Variable<String>(toWalletId);
    }
    if (!nullToAbsent || categoryKey != null) {
      map['category_key'] = Variable<String>(categoryKey);
    }
    if (!nullToAbsent || envelopeId != null) {
      map['envelope_id'] = Variable<String>(envelopeId);
    }
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['label'] = Variable<String>(label);
    map['note'] = Variable<String>(note);
    map['source'] = Variable<String>(source);
    map['counts_in_week'] = Variable<bool>(countsInWeek);
    return map;
  }

  TxnsCompanion toCompanion(bool nullToAbsent) {
    return TxnsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      kind: Value(kind),
      amountMinor: Value(amountMinor),
      currency: Value(currency),
      fxRate: Value(fxRate),
      amountBase: Value(amountBase),
      walletId: walletId == null && nullToAbsent
          ? const Value.absent()
          : Value(walletId),
      toWalletId: toWalletId == null && nullToAbsent
          ? const Value.absent()
          : Value(toWalletId),
      categoryKey: categoryKey == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryKey),
      envelopeId: envelopeId == null && nullToAbsent
          ? const Value.absent()
          : Value(envelopeId),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      occurredAt: Value(occurredAt),
      label: Value(label),
      note: Value(note),
      source: Value(source),
      countsInWeek: Value(countsInWeek),
    );
  }

  factory Txn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Txn(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      kind: serializer.fromJson<String>(json['kind']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      fxRate: serializer.fromJson<int>(json['fxRate']),
      amountBase: serializer.fromJson<int>(json['amountBase']),
      walletId: serializer.fromJson<String?>(json['walletId']),
      toWalletId: serializer.fromJson<String?>(json['toWalletId']),
      categoryKey: serializer.fromJson<String?>(json['categoryKey']),
      envelopeId: serializer.fromJson<String?>(json['envelopeId']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      label: serializer.fromJson<String>(json['label']),
      note: serializer.fromJson<String>(json['note']),
      source: serializer.fromJson<String>(json['source']),
      countsInWeek: serializer.fromJson<bool>(json['countsInWeek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'kind': serializer.toJson<String>(kind),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currency': serializer.toJson<String>(currency),
      'fxRate': serializer.toJson<int>(fxRate),
      'amountBase': serializer.toJson<int>(amountBase),
      'walletId': serializer.toJson<String?>(walletId),
      'toWalletId': serializer.toJson<String?>(toWalletId),
      'categoryKey': serializer.toJson<String?>(categoryKey),
      'envelopeId': serializer.toJson<String?>(envelopeId),
      'memberId': serializer.toJson<String?>(memberId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'label': serializer.toJson<String>(label),
      'note': serializer.toJson<String>(note),
      'source': serializer.toJson<String>(source),
      'countsInWeek': serializer.toJson<bool>(countsInWeek),
    };
  }

  Txn copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? kind,
    int? amountMinor,
    String? currency,
    int? fxRate,
    int? amountBase,
    Value<String?> walletId = const Value.absent(),
    Value<String?> toWalletId = const Value.absent(),
    Value<String?> categoryKey = const Value.absent(),
    Value<String?> envelopeId = const Value.absent(),
    Value<String?> memberId = const Value.absent(),
    DateTime? occurredAt,
    String? label,
    String? note,
    String? source,
    bool? countsInWeek,
  }) => Txn(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    kind: kind ?? this.kind,
    amountMinor: amountMinor ?? this.amountMinor,
    currency: currency ?? this.currency,
    fxRate: fxRate ?? this.fxRate,
    amountBase: amountBase ?? this.amountBase,
    walletId: walletId.present ? walletId.value : this.walletId,
    toWalletId: toWalletId.present ? toWalletId.value : this.toWalletId,
    categoryKey: categoryKey.present ? categoryKey.value : this.categoryKey,
    envelopeId: envelopeId.present ? envelopeId.value : this.envelopeId,
    memberId: memberId.present ? memberId.value : this.memberId,
    occurredAt: occurredAt ?? this.occurredAt,
    label: label ?? this.label,
    note: note ?? this.note,
    source: source ?? this.source,
    countsInWeek: countsInWeek ?? this.countsInWeek,
  );
  Txn copyWithCompanion(TxnsCompanion data) {
    return Txn(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      kind: data.kind.present ? data.kind.value : this.kind,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      fxRate: data.fxRate.present ? data.fxRate.value : this.fxRate,
      amountBase: data.amountBase.present
          ? data.amountBase.value
          : this.amountBase,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      toWalletId: data.toWalletId.present
          ? data.toWalletId.value
          : this.toWalletId,
      categoryKey: data.categoryKey.present
          ? data.categoryKey.value
          : this.categoryKey,
      envelopeId: data.envelopeId.present
          ? data.envelopeId.value
          : this.envelopeId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      label: data.label.present ? data.label.value : this.label,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      countsInWeek: data.countsInWeek.present
          ? data.countsInWeek.value
          : this.countsInWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Txn(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('fxRate: $fxRate, ')
          ..write('amountBase: $amountBase, ')
          ..write('walletId: $walletId, ')
          ..write('toWalletId: $toWalletId, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('envelopeId: $envelopeId, ')
          ..write('memberId: $memberId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('label: $label, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('countsInWeek: $countsInWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    kind,
    amountMinor,
    currency,
    fxRate,
    amountBase,
    walletId,
    toWalletId,
    categoryKey,
    envelopeId,
    memberId,
    occurredAt,
    label,
    note,
    source,
    countsInWeek,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Txn &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.kind == this.kind &&
          other.amountMinor == this.amountMinor &&
          other.currency == this.currency &&
          other.fxRate == this.fxRate &&
          other.amountBase == this.amountBase &&
          other.walletId == this.walletId &&
          other.toWalletId == this.toWalletId &&
          other.categoryKey == this.categoryKey &&
          other.envelopeId == this.envelopeId &&
          other.memberId == this.memberId &&
          other.occurredAt == this.occurredAt &&
          other.label == this.label &&
          other.note == this.note &&
          other.source == this.source &&
          other.countsInWeek == this.countsInWeek);
}

class TxnsCompanion extends UpdateCompanion<Txn> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> kind;
  final Value<int> amountMinor;
  final Value<String> currency;
  final Value<int> fxRate;
  final Value<int> amountBase;
  final Value<String?> walletId;
  final Value<String?> toWalletId;
  final Value<String?> categoryKey;
  final Value<String?> envelopeId;
  final Value<String?> memberId;
  final Value<DateTime> occurredAt;
  final Value<String> label;
  final Value<String> note;
  final Value<String> source;
  final Value<bool> countsInWeek;
  final Value<int> rowid;
  const TxnsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.kind = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.fxRate = const Value.absent(),
    this.amountBase = const Value.absent(),
    this.walletId = const Value.absent(),
    this.toWalletId = const Value.absent(),
    this.categoryKey = const Value.absent(),
    this.envelopeId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.label = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.countsInWeek = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TxnsCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String kind,
    required int amountMinor,
    this.currency = const Value.absent(),
    this.fxRate = const Value.absent(),
    required int amountBase,
    this.walletId = const Value.absent(),
    this.toWalletId = const Value.absent(),
    this.categoryKey = const Value.absent(),
    this.envelopeId = const Value.absent(),
    this.memberId = const Value.absent(),
    required DateTime occurredAt,
    this.label = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.countsInWeek = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       kind = Value(kind),
       amountMinor = Value(amountMinor),
       amountBase = Value(amountBase),
       occurredAt = Value(occurredAt);
  static Insertable<Txn> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? kind,
    Expression<int>? amountMinor,
    Expression<String>? currency,
    Expression<int>? fxRate,
    Expression<int>? amountBase,
    Expression<String>? walletId,
    Expression<String>? toWalletId,
    Expression<String>? categoryKey,
    Expression<String>? envelopeId,
    Expression<String>? memberId,
    Expression<DateTime>? occurredAt,
    Expression<String>? label,
    Expression<String>? note,
    Expression<String>? source,
    Expression<bool>? countsInWeek,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (kind != null) 'kind': kind,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currency != null) 'currency': currency,
      if (fxRate != null) 'fx_rate': fxRate,
      if (amountBase != null) 'amount_base': amountBase,
      if (walletId != null) 'wallet_id': walletId,
      if (toWalletId != null) 'to_wallet_id': toWalletId,
      if (categoryKey != null) 'category_key': categoryKey,
      if (envelopeId != null) 'envelope_id': envelopeId,
      if (memberId != null) 'member_id': memberId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (label != null) 'label': label,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (countsInWeek != null) 'counts_in_week': countsInWeek,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TxnsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? kind,
    Value<int>? amountMinor,
    Value<String>? currency,
    Value<int>? fxRate,
    Value<int>? amountBase,
    Value<String?>? walletId,
    Value<String?>? toWalletId,
    Value<String?>? categoryKey,
    Value<String?>? envelopeId,
    Value<String?>? memberId,
    Value<DateTime>? occurredAt,
    Value<String>? label,
    Value<String>? note,
    Value<String>? source,
    Value<bool>? countsInWeek,
    Value<int>? rowid,
  }) {
    return TxnsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      kind: kind ?? this.kind,
      amountMinor: amountMinor ?? this.amountMinor,
      currency: currency ?? this.currency,
      fxRate: fxRate ?? this.fxRate,
      amountBase: amountBase ?? this.amountBase,
      walletId: walletId ?? this.walletId,
      toWalletId: toWalletId ?? this.toWalletId,
      categoryKey: categoryKey ?? this.categoryKey,
      envelopeId: envelopeId ?? this.envelopeId,
      memberId: memberId ?? this.memberId,
      occurredAt: occurredAt ?? this.occurredAt,
      label: label ?? this.label,
      note: note ?? this.note,
      source: source ?? this.source,
      countsInWeek: countsInWeek ?? this.countsInWeek,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (fxRate.present) {
      map['fx_rate'] = Variable<int>(fxRate.value);
    }
    if (amountBase.present) {
      map['amount_base'] = Variable<int>(amountBase.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (toWalletId.present) {
      map['to_wallet_id'] = Variable<String>(toWalletId.value);
    }
    if (categoryKey.present) {
      map['category_key'] = Variable<String>(categoryKey.value);
    }
    if (envelopeId.present) {
      map['envelope_id'] = Variable<String>(envelopeId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (countsInWeek.present) {
      map['counts_in_week'] = Variable<bool>(countsInWeek.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('fxRate: $fxRate, ')
          ..write('amountBase: $amountBase, ')
          ..write('walletId: $walletId, ')
          ..write('toWalletId: $toWalletId, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('envelopeId: $envelopeId, ')
          ..write('memberId: $memberId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('label: $label, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('countsInWeek: $countsInWeek, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<int> salary = GeneratedColumn<int>(
    'salary',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savePercentMeta = const VerificationMeta(
    'savePercent',
  );
  @override
  late final GeneratedColumn<int> savePercent = GeneratedColumn<int>(
    'save_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _payDayMeta = const VerificationMeta('payDay');
  @override
  late final GeneratedColumn<int> payDay = GeneratedColumn<int>(
    'pay_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _minPerDayMeta = const VerificationMeta(
    'minPerDay',
  );
  @override
  late final GeneratedColumn<int> minPerDay = GeneratedColumn<int>(
    'min_per_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15000),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    salary,
    savePercent,
    payDay,
    minPerDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('salary')) {
      context.handle(
        _salaryMeta,
        salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta),
      );
    } else if (isInserting) {
      context.missing(_salaryMeta);
    }
    if (data.containsKey('save_percent')) {
      context.handle(
        _savePercentMeta,
        savePercent.isAcceptableOrUnknown(
          data['save_percent']!,
          _savePercentMeta,
        ),
      );
    }
    if (data.containsKey('pay_day')) {
      context.handle(
        _payDayMeta,
        payDay.isAcceptableOrUnknown(data['pay_day']!, _payDayMeta),
      );
    }
    if (data.containsKey('min_per_day')) {
      context.handle(
        _minPerDayMeta,
        minPerDay.isAcceptableOrUnknown(data['min_per_day']!, _minPerDayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      salary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary'],
      )!,
      savePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}save_percent'],
      )!,
      payDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_day'],
      )!,
      minPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_per_day'],
      )!,
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final int salary;
  final int savePercent;
  final int payDay;
  final int minPerDay;
  const Plan({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.salary,
    required this.savePercent,
    required this.payDay,
    required this.minPerDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['salary'] = Variable<int>(salary);
    map['save_percent'] = Variable<int>(savePercent);
    map['pay_day'] = Variable<int>(payDay);
    map['min_per_day'] = Variable<int>(minPerDay);
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      salary: Value(salary),
      savePercent: Value(savePercent),
      payDay: Value(payDay),
      minPerDay: Value(minPerDay),
    );
  }

  factory Plan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      salary: serializer.fromJson<int>(json['salary']),
      savePercent: serializer.fromJson<int>(json['savePercent']),
      payDay: serializer.fromJson<int>(json['payDay']),
      minPerDay: serializer.fromJson<int>(json['minPerDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'salary': serializer.toJson<int>(salary),
      'savePercent': serializer.toJson<int>(savePercent),
      'payDay': serializer.toJson<int>(payDay),
      'minPerDay': serializer.toJson<int>(minPerDay),
    };
  }

  Plan copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    int? salary,
    int? savePercent,
    int? payDay,
    int? minPerDay,
  }) => Plan(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    salary: salary ?? this.salary,
    savePercent: savePercent ?? this.savePercent,
    payDay: payDay ?? this.payDay,
    minPerDay: minPerDay ?? this.minPerDay,
  );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      salary: data.salary.present ? data.salary.value : this.salary,
      savePercent: data.savePercent.present
          ? data.savePercent.value
          : this.savePercent,
      payDay: data.payDay.present ? data.payDay.value : this.payDay,
      minPerDay: data.minPerDay.present ? data.minPerDay.value : this.minPerDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plan(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('salary: $salary, ')
          ..write('savePercent: $savePercent, ')
          ..write('payDay: $payDay, ')
          ..write('minPerDay: $minPerDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    salary,
    savePercent,
    payDay,
    minPerDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plan &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.salary == this.salary &&
          other.savePercent == this.savePercent &&
          other.payDay == this.payDay &&
          other.minPerDay == this.minPerDay);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<int> salary;
  final Value<int> savePercent;
  final Value<int> payDay;
  final Value<int> minPerDay;
  final Value<int> rowid;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.salary = const Value.absent(),
    this.savePercent = const Value.absent(),
    this.payDay = const Value.absent(),
    this.minPerDay = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlansCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required int salary,
    this.savePercent = const Value.absent(),
    this.payDay = const Value.absent(),
    this.minPerDay = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       salary = Value(salary);
  static Insertable<Plan> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<int>? salary,
    Expression<int>? savePercent,
    Expression<int>? payDay,
    Expression<int>? minPerDay,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (salary != null) 'salary': salary,
      if (savePercent != null) 'save_percent': savePercent,
      if (payDay != null) 'pay_day': payDay,
      if (minPerDay != null) 'min_per_day': minPerDay,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlansCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<int>? salary,
    Value<int>? savePercent,
    Value<int>? payDay,
    Value<int>? minPerDay,
    Value<int>? rowid,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      salary: salary ?? this.salary,
      savePercent: savePercent ?? this.savePercent,
      payDay: payDay ?? this.payDay,
      minPerDay: minPerDay ?? this.minPerDay,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (salary.present) {
      map['salary'] = Variable<int>(salary.value);
    }
    if (savePercent.present) {
      map['save_percent'] = Variable<int>(savePercent.value);
    }
    if (payDay.present) {
      map['pay_day'] = Variable<int>(payDay.value);
    }
    if (minPerDay.present) {
      map['min_per_day'] = Variable<int>(minPerDay.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('salary: $salary, ')
          ..write('savePercent: $savePercent, ')
          ..write('payDay: $payDay, ')
          ..write('minPerDay: $minPerDay, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, Bill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfMonthMeta = const VerificationMeta(
    'dayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
    'day_of_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryKeyMeta = const VerificationMeta(
    'categoryKey',
  );
  @override
  late final GeneratedColumn<String> categoryKey = GeneratedColumn<String>(
    'category_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ampsMeta = const VerificationMeta('amps');
  @override
  late final GeneratedColumn<int> amps = GeneratedColumn<int>(
    'amps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricePerAmpMeta = const VerificationMeta(
    'pricePerAmp',
  );
  @override
  late final GeneratedColumn<int> pricePerAmp = GeneratedColumn<int>(
    'price_per_amp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastPostedMeta = const VerificationMeta(
    'lastPosted',
  );
  @override
  late final GeneratedColumn<String> lastPosted = GeneratedColumn<String>(
    'last_posted',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    icon,
    amountMinor,
    dayOfMonth,
    categoryKey,
    amps,
    pricePerAmp,
    active,
    lastPosted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
        _dayOfMonthMeta,
        dayOfMonth.isAcceptableOrUnknown(
          data['day_of_month']!,
          _dayOfMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dayOfMonthMeta);
    }
    if (data.containsKey('category_key')) {
      context.handle(
        _categoryKeyMeta,
        categoryKey.isAcceptableOrUnknown(
          data['category_key']!,
          _categoryKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryKeyMeta);
    }
    if (data.containsKey('amps')) {
      context.handle(
        _ampsMeta,
        amps.isAcceptableOrUnknown(data['amps']!, _ampsMeta),
      );
    }
    if (data.containsKey('price_per_amp')) {
      context.handle(
        _pricePerAmpMeta,
        pricePerAmp.isAcceptableOrUnknown(
          data['price_per_amp']!,
          _pricePerAmpMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('last_posted')) {
      context.handle(
        _lastPostedMeta,
        lastPosted.isAcceptableOrUnknown(data['last_posted']!, _lastPostedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      dayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_month'],
      )!,
      categoryKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_key'],
      )!,
      amps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amps'],
      ),
      pricePerAmp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_amp'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      lastPosted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_posted'],
      ),
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String name;

  /// bolt | wifi | phone | bus | home | other
  final String icon;
  final int amountMinor;
  final int dayOfMonth;
  final String categoryKey;

  /// Generator bills are amps × price per amp; both editable.
  final int? amps;
  final int? pricePerAmp;
  final bool active;

  /// "2026-10" once this month's bill has been posted.
  final String? lastPosted;
  const Bill({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.name,
    required this.icon,
    required this.amountMinor,
    required this.dayOfMonth,
    required this.categoryKey,
    this.amps,
    this.pricePerAmp,
    required this.active,
    this.lastPosted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['day_of_month'] = Variable<int>(dayOfMonth);
    map['category_key'] = Variable<String>(categoryKey);
    if (!nullToAbsent || amps != null) {
      map['amps'] = Variable<int>(amps);
    }
    if (!nullToAbsent || pricePerAmp != null) {
      map['price_per_amp'] = Variable<int>(pricePerAmp);
    }
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || lastPosted != null) {
      map['last_posted'] = Variable<String>(lastPosted);
    }
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      name: Value(name),
      icon: Value(icon),
      amountMinor: Value(amountMinor),
      dayOfMonth: Value(dayOfMonth),
      categoryKey: Value(categoryKey),
      amps: amps == null && nullToAbsent ? const Value.absent() : Value(amps),
      pricePerAmp: pricePerAmp == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerAmp),
      active: Value(active),
      lastPosted: lastPosted == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPosted),
    );
  }

  factory Bill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      dayOfMonth: serializer.fromJson<int>(json['dayOfMonth']),
      categoryKey: serializer.fromJson<String>(json['categoryKey']),
      amps: serializer.fromJson<int?>(json['amps']),
      pricePerAmp: serializer.fromJson<int?>(json['pricePerAmp']),
      active: serializer.fromJson<bool>(json['active']),
      lastPosted: serializer.fromJson<String?>(json['lastPosted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'dayOfMonth': serializer.toJson<int>(dayOfMonth),
      'categoryKey': serializer.toJson<String>(categoryKey),
      'amps': serializer.toJson<int?>(amps),
      'pricePerAmp': serializer.toJson<int?>(pricePerAmp),
      'active': serializer.toJson<bool>(active),
      'lastPosted': serializer.toJson<String?>(lastPosted),
    };
  }

  Bill copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? name,
    String? icon,
    int? amountMinor,
    int? dayOfMonth,
    String? categoryKey,
    Value<int?> amps = const Value.absent(),
    Value<int?> pricePerAmp = const Value.absent(),
    bool? active,
    Value<String?> lastPosted = const Value.absent(),
  }) => Bill(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    amountMinor: amountMinor ?? this.amountMinor,
    dayOfMonth: dayOfMonth ?? this.dayOfMonth,
    categoryKey: categoryKey ?? this.categoryKey,
    amps: amps.present ? amps.value : this.amps,
    pricePerAmp: pricePerAmp.present ? pricePerAmp.value : this.pricePerAmp,
    active: active ?? this.active,
    lastPosted: lastPosted.present ? lastPosted.value : this.lastPosted,
  );
  Bill copyWithCompanion(BillsCompanion data) {
    return Bill(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      dayOfMonth: data.dayOfMonth.present
          ? data.dayOfMonth.value
          : this.dayOfMonth,
      categoryKey: data.categoryKey.present
          ? data.categoryKey.value
          : this.categoryKey,
      amps: data.amps.present ? data.amps.value : this.amps,
      pricePerAmp: data.pricePerAmp.present
          ? data.pricePerAmp.value
          : this.pricePerAmp,
      active: data.active.present ? data.active.value : this.active,
      lastPosted: data.lastPosted.present
          ? data.lastPosted.value
          : this.lastPosted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('amps: $amps, ')
          ..write('pricePerAmp: $pricePerAmp, ')
          ..write('active: $active, ')
          ..write('lastPosted: $lastPosted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    icon,
    amountMinor,
    dayOfMonth,
    categoryKey,
    amps,
    pricePerAmp,
    active,
    lastPosted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.amountMinor == this.amountMinor &&
          other.dayOfMonth == this.dayOfMonth &&
          other.categoryKey == this.categoryKey &&
          other.amps == this.amps &&
          other.pricePerAmp == this.pricePerAmp &&
          other.active == this.active &&
          other.lastPosted == this.lastPosted);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> amountMinor;
  final Value<int> dayOfMonth;
  final Value<String> categoryKey;
  final Value<int?> amps;
  final Value<int?> pricePerAmp;
  final Value<bool> active;
  final Value<String?> lastPosted;
  final Value<int> rowid;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.categoryKey = const Value.absent(),
    this.amps = const Value.absent(),
    this.pricePerAmp = const Value.absent(),
    this.active = const Value.absent(),
    this.lastPosted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillsCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    required String icon,
    required int amountMinor,
    required int dayOfMonth,
    required String categoryKey,
    this.amps = const Value.absent(),
    this.pricePerAmp = const Value.absent(),
    this.active = const Value.absent(),
    this.lastPosted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name),
       icon = Value(icon),
       amountMinor = Value(amountMinor),
       dayOfMonth = Value(dayOfMonth),
       categoryKey = Value(categoryKey);
  static Insertable<Bill> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? amountMinor,
    Expression<int>? dayOfMonth,
    Expression<String>? categoryKey,
    Expression<int>? amps,
    Expression<int>? pricePerAmp,
    Expression<bool>? active,
    Expression<String>? lastPosted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (categoryKey != null) 'category_key': categoryKey,
      if (amps != null) 'amps': amps,
      if (pricePerAmp != null) 'price_per_amp': pricePerAmp,
      if (active != null) 'active': active,
      if (lastPosted != null) 'last_posted': lastPosted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? amountMinor,
    Value<int>? dayOfMonth,
    Value<String>? categoryKey,
    Value<int?>? amps,
    Value<int?>? pricePerAmp,
    Value<bool>? active,
    Value<String?>? lastPosted,
    Value<int>? rowid,
  }) {
    return BillsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      amountMinor: amountMinor ?? this.amountMinor,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      categoryKey: categoryKey ?? this.categoryKey,
      amps: amps ?? this.amps,
      pricePerAmp: pricePerAmp ?? this.pricePerAmp,
      active: active ?? this.active,
      lastPosted: lastPosted ?? this.lastPosted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (categoryKey.present) {
      map['category_key'] = Variable<String>(categoryKey.value);
    }
    if (amps.present) {
      map['amps'] = Variable<int>(amps.value);
    }
    if (pricePerAmp.present) {
      map['price_per_amp'] = Variable<int>(pricePerAmp.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (lastPosted.present) {
      map['last_posted'] = Variable<String>(lastPosted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('categoryKey: $categoryKey, ')
          ..write('amps: $amps, ')
          ..write('pricePerAmp: $pricePerAmp, ')
          ..write('active: $active, ')
          ..write('lastPosted: $lastPosted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _personNameMeta = const VerificationMeta(
    'personName',
  );
  @override
  late final GeneratedColumn<String> personName = GeneratedColumn<String>(
    'person_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidMinorMeta = const VerificationMeta(
    'paidMinor',
  );
  @override
  late final GeneratedColumn<int> paidMinor = GeneratedColumn<int>(
    'paid_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _forgivenMeta = const VerificationMeta(
    'forgiven',
  );
  @override
  late final GeneratedColumn<bool> forgiven = GeneratedColumn<bool>(
    'forgiven',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("forgiven" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    personName,
    direction,
    amountMinor,
    paidMinor,
    note,
    forgiven,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Debt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('person_name')) {
      context.handle(
        _personNameMeta,
        personName.isAcceptableOrUnknown(data['person_name']!, _personNameMeta),
      );
    } else if (isInserting) {
      context.missing(_personNameMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('paid_minor')) {
      context.handle(
        _paidMinorMeta,
        paidMinor.isAcceptableOrUnknown(data['paid_minor']!, _paidMinorMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('forgiven')) {
      context.handle(
        _forgivenMeta,
        forgiven.isAcceptableOrUnknown(data['forgiven']!, _forgivenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      personName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_name'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      paidMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_minor'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      forgiven: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}forgiven'],
      )!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class Debt extends DataClass implements Insertable<Debt> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String personName;

  /// in = they owe us, out = we owe them
  final String direction;
  final int amountMinor;
  final int paidMinor;
  final String note;
  final bool forgiven;
  const Debt({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.personName,
    required this.direction,
    required this.amountMinor,
    required this.paidMinor,
    required this.note,
    required this.forgiven,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['person_name'] = Variable<String>(personName);
    map['direction'] = Variable<String>(direction);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['paid_minor'] = Variable<int>(paidMinor);
    map['note'] = Variable<String>(note);
    map['forgiven'] = Variable<bool>(forgiven);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      personName: Value(personName),
      direction: Value(direction),
      amountMinor: Value(amountMinor),
      paidMinor: Value(paidMinor),
      note: Value(note),
      forgiven: Value(forgiven),
    );
  }

  factory Debt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      personName: serializer.fromJson<String>(json['personName']),
      direction: serializer.fromJson<String>(json['direction']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      paidMinor: serializer.fromJson<int>(json['paidMinor']),
      note: serializer.fromJson<String>(json['note']),
      forgiven: serializer.fromJson<bool>(json['forgiven']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'personName': serializer.toJson<String>(personName),
      'direction': serializer.toJson<String>(direction),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'paidMinor': serializer.toJson<int>(paidMinor),
      'note': serializer.toJson<String>(note),
      'forgiven': serializer.toJson<bool>(forgiven),
    };
  }

  Debt copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? personName,
    String? direction,
    int? amountMinor,
    int? paidMinor,
    String? note,
    bool? forgiven,
  }) => Debt(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    personName: personName ?? this.personName,
    direction: direction ?? this.direction,
    amountMinor: amountMinor ?? this.amountMinor,
    paidMinor: paidMinor ?? this.paidMinor,
    note: note ?? this.note,
    forgiven: forgiven ?? this.forgiven,
  );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      personName: data.personName.present
          ? data.personName.value
          : this.personName,
      direction: data.direction.present ? data.direction.value : this.direction,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      paidMinor: data.paidMinor.present ? data.paidMinor.value : this.paidMinor,
      note: data.note.present ? data.note.value : this.note,
      forgiven: data.forgiven.present ? data.forgiven.value : this.forgiven,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('personName: $personName, ')
          ..write('direction: $direction, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidMinor: $paidMinor, ')
          ..write('note: $note, ')
          ..write('forgiven: $forgiven')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    personName,
    direction,
    amountMinor,
    paidMinor,
    note,
    forgiven,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.personName == this.personName &&
          other.direction == this.direction &&
          other.amountMinor == this.amountMinor &&
          other.paidMinor == this.paidMinor &&
          other.note == this.note &&
          other.forgiven == this.forgiven);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> personName;
  final Value<String> direction;
  final Value<int> amountMinor;
  final Value<int> paidMinor;
  final Value<String> note;
  final Value<bool> forgiven;
  final Value<int> rowid;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.personName = const Value.absent(),
    this.direction = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.paidMinor = const Value.absent(),
    this.note = const Value.absent(),
    this.forgiven = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtsCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String personName,
    required String direction,
    required int amountMinor,
    this.paidMinor = const Value.absent(),
    this.note = const Value.absent(),
    this.forgiven = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       personName = Value(personName),
       direction = Value(direction),
       amountMinor = Value(amountMinor);
  static Insertable<Debt> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? personName,
    Expression<String>? direction,
    Expression<int>? amountMinor,
    Expression<int>? paidMinor,
    Expression<String>? note,
    Expression<bool>? forgiven,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (personName != null) 'person_name': personName,
      if (direction != null) 'direction': direction,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (paidMinor != null) 'paid_minor': paidMinor,
      if (note != null) 'note': note,
      if (forgiven != null) 'forgiven': forgiven,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtsCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? personName,
    Value<String>? direction,
    Value<int>? amountMinor,
    Value<int>? paidMinor,
    Value<String>? note,
    Value<bool>? forgiven,
    Value<int>? rowid,
  }) {
    return DebtsCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      personName: personName ?? this.personName,
      direction: direction ?? this.direction,
      amountMinor: amountMinor ?? this.amountMinor,
      paidMinor: paidMinor ?? this.paidMinor,
      note: note ?? this.note,
      forgiven: forgiven ?? this.forgiven,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (personName.present) {
      map['person_name'] = Variable<String>(personName.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (paidMinor.present) {
      map['paid_minor'] = Variable<int>(paidMinor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (forgiven.present) {
      map['forgiven'] = Variable<bool>(forgiven.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('personName: $personName, ')
          ..write('direction: $direction, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidMinor: $paidMinor, ')
          ..write('note: $note, ')
          ..write('forgiven: $forgiven, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoscasTable extends Roscas with TableInfo<$RoscasTable, Rosca> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoscasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizerMeta = const VerificationMeta(
    'organizer',
  );
  @override
  late final GeneratedColumn<String> organizer = GeneratedColumn<String>(
    'organizer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _membersCountMeta = const VerificationMeta(
    'membersCount',
  );
  @override
  late final GeneratedColumn<int> membersCount = GeneratedColumn<int>(
    'members_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contributionMeta = const VerificationMeta(
    'contribution',
  );
  @override
  late final GeneratedColumn<int> contribution = GeneratedColumn<int>(
    'contribution',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startYearMeta = const VerificationMeta(
    'startYear',
  );
  @override
  late final GeneratedColumn<int> startYear = GeneratedColumn<int>(
    'start_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMonthMeta = const VerificationMeta(
    'startMonth',
  );
  @override
  late final GeneratedColumn<int> startMonth = GeneratedColumn<int>(
    'start_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _myTurnMeta = const VerificationMeta('myTurn');
  @override
  late final GeneratedColumn<int> myTurn = GeneratedColumn<int>(
    'my_turn',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidRoundsMeta = const VerificationMeta(
    'paidRounds',
  );
  @override
  late final GeneratedColumn<int> paidRounds = GeneratedColumn<int>(
    'paid_rounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warningMeta = const VerificationMeta(
    'warning',
  );
  @override
  late final GeneratedColumn<String> warning = GeneratedColumn<String>(
    'warning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    organizer,
    membersCount,
    contribution,
    startYear,
    startMonth,
    myTurn,
    paidRounds,
    warning,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roscas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Rosca> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('organizer')) {
      context.handle(
        _organizerMeta,
        organizer.isAcceptableOrUnknown(data['organizer']!, _organizerMeta),
      );
    }
    if (data.containsKey('members_count')) {
      context.handle(
        _membersCountMeta,
        membersCount.isAcceptableOrUnknown(
          data['members_count']!,
          _membersCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_membersCountMeta);
    }
    if (data.containsKey('contribution')) {
      context.handle(
        _contributionMeta,
        contribution.isAcceptableOrUnknown(
          data['contribution']!,
          _contributionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contributionMeta);
    }
    if (data.containsKey('start_year')) {
      context.handle(
        _startYearMeta,
        startYear.isAcceptableOrUnknown(data['start_year']!, _startYearMeta),
      );
    } else if (isInserting) {
      context.missing(_startYearMeta);
    }
    if (data.containsKey('start_month')) {
      context.handle(
        _startMonthMeta,
        startMonth.isAcceptableOrUnknown(data['start_month']!, _startMonthMeta),
      );
    } else if (isInserting) {
      context.missing(_startMonthMeta);
    }
    if (data.containsKey('my_turn')) {
      context.handle(
        _myTurnMeta,
        myTurn.isAcceptableOrUnknown(data['my_turn']!, _myTurnMeta),
      );
    } else if (isInserting) {
      context.missing(_myTurnMeta);
    }
    if (data.containsKey('paid_rounds')) {
      context.handle(
        _paidRoundsMeta,
        paidRounds.isAcceptableOrUnknown(data['paid_rounds']!, _paidRoundsMeta),
      );
    }
    if (data.containsKey('warning')) {
      context.handle(
        _warningMeta,
        warning.isAcceptableOrUnknown(data['warning']!, _warningMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rosca map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rosca(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      organizer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organizer'],
      )!,
      membersCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}members_count'],
      )!,
      contribution: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contribution'],
      )!,
      startYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_year'],
      )!,
      startMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_month'],
      )!,
      myTurn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}my_turn'],
      )!,
      paidRounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_rounds'],
      )!,
      warning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warning'],
      )!,
    );
  }

  @override
  $RoscasTable createAlias(String alias) {
    return $RoscasTable(attachedDatabase, alias);
  }
}

class Rosca extends DataClass implements Insertable<Rosca> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String name;
  final String organizer;
  final int membersCount;
  final int contribution;
  final int startYear;
  final int startMonth;
  final int myTurn;
  final int paidRounds;

  /// Free text warning, e.g. someone collected and then paid late.
  final String warning;
  const Rosca({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.name,
    required this.organizer,
    required this.membersCount,
    required this.contribution,
    required this.startYear,
    required this.startMonth,
    required this.myTurn,
    required this.paidRounds,
    required this.warning,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['name'] = Variable<String>(name);
    map['organizer'] = Variable<String>(organizer);
    map['members_count'] = Variable<int>(membersCount);
    map['contribution'] = Variable<int>(contribution);
    map['start_year'] = Variable<int>(startYear);
    map['start_month'] = Variable<int>(startMonth);
    map['my_turn'] = Variable<int>(myTurn);
    map['paid_rounds'] = Variable<int>(paidRounds);
    map['warning'] = Variable<String>(warning);
    return map;
  }

  RoscasCompanion toCompanion(bool nullToAbsent) {
    return RoscasCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      name: Value(name),
      organizer: Value(organizer),
      membersCount: Value(membersCount),
      contribution: Value(contribution),
      startYear: Value(startYear),
      startMonth: Value(startMonth),
      myTurn: Value(myTurn),
      paidRounds: Value(paidRounds),
      warning: Value(warning),
    );
  }

  factory Rosca.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rosca(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      name: serializer.fromJson<String>(json['name']),
      organizer: serializer.fromJson<String>(json['organizer']),
      membersCount: serializer.fromJson<int>(json['membersCount']),
      contribution: serializer.fromJson<int>(json['contribution']),
      startYear: serializer.fromJson<int>(json['startYear']),
      startMonth: serializer.fromJson<int>(json['startMonth']),
      myTurn: serializer.fromJson<int>(json['myTurn']),
      paidRounds: serializer.fromJson<int>(json['paidRounds']),
      warning: serializer.fromJson<String>(json['warning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'name': serializer.toJson<String>(name),
      'organizer': serializer.toJson<String>(organizer),
      'membersCount': serializer.toJson<int>(membersCount),
      'contribution': serializer.toJson<int>(contribution),
      'startYear': serializer.toJson<int>(startYear),
      'startMonth': serializer.toJson<int>(startMonth),
      'myTurn': serializer.toJson<int>(myTurn),
      'paidRounds': serializer.toJson<int>(paidRounds),
      'warning': serializer.toJson<String>(warning),
    };
  }

  Rosca copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? name,
    String? organizer,
    int? membersCount,
    int? contribution,
    int? startYear,
    int? startMonth,
    int? myTurn,
    int? paidRounds,
    String? warning,
  }) => Rosca(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    name: name ?? this.name,
    organizer: organizer ?? this.organizer,
    membersCount: membersCount ?? this.membersCount,
    contribution: contribution ?? this.contribution,
    startYear: startYear ?? this.startYear,
    startMonth: startMonth ?? this.startMonth,
    myTurn: myTurn ?? this.myTurn,
    paidRounds: paidRounds ?? this.paidRounds,
    warning: warning ?? this.warning,
  );
  Rosca copyWithCompanion(RoscasCompanion data) {
    return Rosca(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      name: data.name.present ? data.name.value : this.name,
      organizer: data.organizer.present ? data.organizer.value : this.organizer,
      membersCount: data.membersCount.present
          ? data.membersCount.value
          : this.membersCount,
      contribution: data.contribution.present
          ? data.contribution.value
          : this.contribution,
      startYear: data.startYear.present ? data.startYear.value : this.startYear,
      startMonth: data.startMonth.present
          ? data.startMonth.value
          : this.startMonth,
      myTurn: data.myTurn.present ? data.myTurn.value : this.myTurn,
      paidRounds: data.paidRounds.present
          ? data.paidRounds.value
          : this.paidRounds,
      warning: data.warning.present ? data.warning.value : this.warning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rosca(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('organizer: $organizer, ')
          ..write('membersCount: $membersCount, ')
          ..write('contribution: $contribution, ')
          ..write('startYear: $startYear, ')
          ..write('startMonth: $startMonth, ')
          ..write('myTurn: $myTurn, ')
          ..write('paidRounds: $paidRounds, ')
          ..write('warning: $warning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    name,
    organizer,
    membersCount,
    contribution,
    startYear,
    startMonth,
    myTurn,
    paidRounds,
    warning,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rosca &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.name == this.name &&
          other.organizer == this.organizer &&
          other.membersCount == this.membersCount &&
          other.contribution == this.contribution &&
          other.startYear == this.startYear &&
          other.startMonth == this.startMonth &&
          other.myTurn == this.myTurn &&
          other.paidRounds == this.paidRounds &&
          other.warning == this.warning);
}

class RoscasCompanion extends UpdateCompanion<Rosca> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> name;
  final Value<String> organizer;
  final Value<int> membersCount;
  final Value<int> contribution;
  final Value<int> startYear;
  final Value<int> startMonth;
  final Value<int> myTurn;
  final Value<int> paidRounds;
  final Value<String> warning;
  final Value<int> rowid;
  const RoscasCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.name = const Value.absent(),
    this.organizer = const Value.absent(),
    this.membersCount = const Value.absent(),
    this.contribution = const Value.absent(),
    this.startYear = const Value.absent(),
    this.startMonth = const Value.absent(),
    this.myTurn = const Value.absent(),
    this.paidRounds = const Value.absent(),
    this.warning = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoscasCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String name,
    this.organizer = const Value.absent(),
    required int membersCount,
    required int contribution,
    required int startYear,
    required int startMonth,
    required int myTurn,
    this.paidRounds = const Value.absent(),
    this.warning = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name),
       membersCount = Value(membersCount),
       contribution = Value(contribution),
       startYear = Value(startYear),
       startMonth = Value(startMonth),
       myTurn = Value(myTurn);
  static Insertable<Rosca> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? name,
    Expression<String>? organizer,
    Expression<int>? membersCount,
    Expression<int>? contribution,
    Expression<int>? startYear,
    Expression<int>? startMonth,
    Expression<int>? myTurn,
    Expression<int>? paidRounds,
    Expression<String>? warning,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (name != null) 'name': name,
      if (organizer != null) 'organizer': organizer,
      if (membersCount != null) 'members_count': membersCount,
      if (contribution != null) 'contribution': contribution,
      if (startYear != null) 'start_year': startYear,
      if (startMonth != null) 'start_month': startMonth,
      if (myTurn != null) 'my_turn': myTurn,
      if (paidRounds != null) 'paid_rounds': paidRounds,
      if (warning != null) 'warning': warning,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoscasCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? name,
    Value<String>? organizer,
    Value<int>? membersCount,
    Value<int>? contribution,
    Value<int>? startYear,
    Value<int>? startMonth,
    Value<int>? myTurn,
    Value<int>? paidRounds,
    Value<String>? warning,
    Value<int>? rowid,
  }) {
    return RoscasCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      membersCount: membersCount ?? this.membersCount,
      contribution: contribution ?? this.contribution,
      startYear: startYear ?? this.startYear,
      startMonth: startMonth ?? this.startMonth,
      myTurn: myTurn ?? this.myTurn,
      paidRounds: paidRounds ?? this.paidRounds,
      warning: warning ?? this.warning,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (organizer.present) {
      map['organizer'] = Variable<String>(organizer.value);
    }
    if (membersCount.present) {
      map['members_count'] = Variable<int>(membersCount.value);
    }
    if (contribution.present) {
      map['contribution'] = Variable<int>(contribution.value);
    }
    if (startYear.present) {
      map['start_year'] = Variable<int>(startYear.value);
    }
    if (startMonth.present) {
      map['start_month'] = Variable<int>(startMonth.value);
    }
    if (myTurn.present) {
      map['my_turn'] = Variable<int>(myTurn.value);
    }
    if (paidRounds.present) {
      map['paid_rounds'] = Variable<int>(paidRounds.value);
    }
    if (warning.present) {
      map['warning'] = Variable<String>(warning.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoscasCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('name: $name, ')
          ..write('organizer: $organizer, ')
          ..write('membersCount: $membersCount, ')
          ..write('contribution: $contribution, ')
          ..write('startYear: $startYear, ')
          ..write('startMonth: $startMonth, ')
          ..write('myTurn: $myTurn, ')
          ..write('paidRounds: $paidRounds, ')
          ..write('warning: $warning, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KidProfilesTable extends KidProfiles
    with TableInfo<$KidProfilesTable, KidProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KidProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalNameMeta = const VerificationMeta(
    'goalName',
  );
  @override
  late final GeneratedColumn<String> goalName = GeneratedColumn<String>(
    'goal_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('الهدف'),
  );
  static const VerificationMeta _goalMinorMeta = const VerificationMeta(
    'goalMinor',
  );
  @override
  late final GeneratedColumn<int> goalMinor = GeneratedColumn<int>(
    'goal_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _matchPercentMeta = const VerificationMeta(
    'matchPercent',
  );
  @override
  late final GeneratedColumn<int> matchPercent = GeneratedColumn<int>(
    'match_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _weeklyAllowanceMeta = const VerificationMeta(
    'weeklyAllowance',
  );
  @override
  late final GeneratedColumn<int> weeklyAllowance = GeneratedColumn<int>(
    'weekly_allowance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5000),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    memberId,
    goalName,
    goalMinor,
    matchPercent,
    weeklyAllowance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kid_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<KidProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('goal_name')) {
      context.handle(
        _goalNameMeta,
        goalName.isAcceptableOrUnknown(data['goal_name']!, _goalNameMeta),
      );
    }
    if (data.containsKey('goal_minor')) {
      context.handle(
        _goalMinorMeta,
        goalMinor.isAcceptableOrUnknown(data['goal_minor']!, _goalMinorMeta),
      );
    }
    if (data.containsKey('match_percent')) {
      context.handle(
        _matchPercentMeta,
        matchPercent.isAcceptableOrUnknown(
          data['match_percent']!,
          _matchPercentMeta,
        ),
      );
    }
    if (data.containsKey('weekly_allowance')) {
      context.handle(
        _weeklyAllowanceMeta,
        weeklyAllowance.isAcceptableOrUnknown(
          data['weekly_allowance']!,
          _weeklyAllowanceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KidProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KidProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      goalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_name'],
      )!,
      goalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_minor'],
      )!,
      matchPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_percent'],
      )!,
      weeklyAllowance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_allowance'],
      )!,
    );
  }

  @override
  $KidProfilesTable createAlias(String alias) {
    return $KidProfilesTable(attachedDatabase, alias);
  }
}

class KidProfile extends DataClass implements Insertable<KidProfile> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String memberId;
  final String goalName;
  final int goalMinor;

  /// Parent adds this percent of every save deposit (50 = 500 per 1,000).
  final int matchPercent;
  final int weeklyAllowance;
  const KidProfile({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.memberId,
    required this.goalName,
    required this.goalMinor,
    required this.matchPercent,
    required this.weeklyAllowance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['member_id'] = Variable<String>(memberId);
    map['goal_name'] = Variable<String>(goalName);
    map['goal_minor'] = Variable<int>(goalMinor);
    map['match_percent'] = Variable<int>(matchPercent);
    map['weekly_allowance'] = Variable<int>(weeklyAllowance);
    return map;
  }

  KidProfilesCompanion toCompanion(bool nullToAbsent) {
    return KidProfilesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      memberId: Value(memberId),
      goalName: Value(goalName),
      goalMinor: Value(goalMinor),
      matchPercent: Value(matchPercent),
      weeklyAllowance: Value(weeklyAllowance),
    );
  }

  factory KidProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KidProfile(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      memberId: serializer.fromJson<String>(json['memberId']),
      goalName: serializer.fromJson<String>(json['goalName']),
      goalMinor: serializer.fromJson<int>(json['goalMinor']),
      matchPercent: serializer.fromJson<int>(json['matchPercent']),
      weeklyAllowance: serializer.fromJson<int>(json['weeklyAllowance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'memberId': serializer.toJson<String>(memberId),
      'goalName': serializer.toJson<String>(goalName),
      'goalMinor': serializer.toJson<int>(goalMinor),
      'matchPercent': serializer.toJson<int>(matchPercent),
      'weeklyAllowance': serializer.toJson<int>(weeklyAllowance),
    };
  }

  KidProfile copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? memberId,
    String? goalName,
    int? goalMinor,
    int? matchPercent,
    int? weeklyAllowance,
  }) => KidProfile(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    memberId: memberId ?? this.memberId,
    goalName: goalName ?? this.goalName,
    goalMinor: goalMinor ?? this.goalMinor,
    matchPercent: matchPercent ?? this.matchPercent,
    weeklyAllowance: weeklyAllowance ?? this.weeklyAllowance,
  );
  KidProfile copyWithCompanion(KidProfilesCompanion data) {
    return KidProfile(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      goalName: data.goalName.present ? data.goalName.value : this.goalName,
      goalMinor: data.goalMinor.present ? data.goalMinor.value : this.goalMinor,
      matchPercent: data.matchPercent.present
          ? data.matchPercent.value
          : this.matchPercent,
      weeklyAllowance: data.weeklyAllowance.present
          ? data.weeklyAllowance.value
          : this.weeklyAllowance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KidProfile(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('memberId: $memberId, ')
          ..write('goalName: $goalName, ')
          ..write('goalMinor: $goalMinor, ')
          ..write('matchPercent: $matchPercent, ')
          ..write('weeklyAllowance: $weeklyAllowance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    memberId,
    goalName,
    goalMinor,
    matchPercent,
    weeklyAllowance,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KidProfile &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.memberId == this.memberId &&
          other.goalName == this.goalName &&
          other.goalMinor == this.goalMinor &&
          other.matchPercent == this.matchPercent &&
          other.weeklyAllowance == this.weeklyAllowance);
}

class KidProfilesCompanion extends UpdateCompanion<KidProfile> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> memberId;
  final Value<String> goalName;
  final Value<int> goalMinor;
  final Value<int> matchPercent;
  final Value<int> weeklyAllowance;
  final Value<int> rowid;
  const KidProfilesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.memberId = const Value.absent(),
    this.goalName = const Value.absent(),
    this.goalMinor = const Value.absent(),
    this.matchPercent = const Value.absent(),
    this.weeklyAllowance = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KidProfilesCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String memberId,
    this.goalName = const Value.absent(),
    this.goalMinor = const Value.absent(),
    this.matchPercent = const Value.absent(),
    this.weeklyAllowance = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       memberId = Value(memberId);
  static Insertable<KidProfile> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? memberId,
    Expression<String>? goalName,
    Expression<int>? goalMinor,
    Expression<int>? matchPercent,
    Expression<int>? weeklyAllowance,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (memberId != null) 'member_id': memberId,
      if (goalName != null) 'goal_name': goalName,
      if (goalMinor != null) 'goal_minor': goalMinor,
      if (matchPercent != null) 'match_percent': matchPercent,
      if (weeklyAllowance != null) 'weekly_allowance': weeklyAllowance,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KidProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? memberId,
    Value<String>? goalName,
    Value<int>? goalMinor,
    Value<int>? matchPercent,
    Value<int>? weeklyAllowance,
    Value<int>? rowid,
  }) {
    return KidProfilesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      memberId: memberId ?? this.memberId,
      goalName: goalName ?? this.goalName,
      goalMinor: goalMinor ?? this.goalMinor,
      matchPercent: matchPercent ?? this.matchPercent,
      weeklyAllowance: weeklyAllowance ?? this.weeklyAllowance,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (goalName.present) {
      map['goal_name'] = Variable<String>(goalName.value);
    }
    if (goalMinor.present) {
      map['goal_minor'] = Variable<int>(goalMinor.value);
    }
    if (matchPercent.present) {
      map['match_percent'] = Variable<int>(matchPercent.value);
    }
    if (weeklyAllowance.present) {
      map['weekly_allowance'] = Variable<int>(weeklyAllowance.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KidProfilesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('memberId: $memberId, ')
          ..write('goalName: $goalName, ')
          ..write('goalMinor: $goalMinor, ')
          ..write('matchPercent: $matchPercent, ')
          ..write('weeklyAllowance: $weeklyAllowance, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KidEntriesTable extends KidEntries
    with TableInfo<$KidEntriesTable, KidEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KidEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jarMeta = const VerificationMeta('jar');
  @override
  late final GeneratedColumn<String> jar = GeneratedColumn<String>(
    'jar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    memberId,
    jar,
    kind,
    amountMinor,
    label,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kid_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<KidEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('jar')) {
      context.handle(
        _jarMeta,
        jar.isAcceptableOrUnknown(data['jar']!, _jarMeta),
      );
    } else if (isInserting) {
      context.missing(_jarMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KidEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KidEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      jar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jar'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $KidEntriesTable createAlias(String alias) {
    return $KidEntriesTable(attachedDatabase, alias);
  }
}

class KidEntry extends DataClass implements Insertable<KidEntry> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final String memberId;
  final String jar;
  final String kind;
  final int amountMinor;
  final String label;
  final DateTime occurredAt;
  const KidEntry({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.memberId,
    required this.jar,
    required this.kind,
    required this.amountMinor,
    required this.label,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['member_id'] = Variable<String>(memberId);
    map['jar'] = Variable<String>(jar);
    map['kind'] = Variable<String>(kind);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['label'] = Variable<String>(label);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  KidEntriesCompanion toCompanion(bool nullToAbsent) {
    return KidEntriesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      memberId: Value(memberId),
      jar: Value(jar),
      kind: Value(kind),
      amountMinor: Value(amountMinor),
      label: Value(label),
      occurredAt: Value(occurredAt),
    );
  }

  factory KidEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KidEntry(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      memberId: serializer.fromJson<String>(json['memberId']),
      jar: serializer.fromJson<String>(json['jar']),
      kind: serializer.fromJson<String>(json['kind']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      label: serializer.fromJson<String>(json['label']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'memberId': serializer.toJson<String>(memberId),
      'jar': serializer.toJson<String>(jar),
      'kind': serializer.toJson<String>(kind),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'label': serializer.toJson<String>(label),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  KidEntry copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    String? memberId,
    String? jar,
    String? kind,
    int? amountMinor,
    String? label,
    DateTime? occurredAt,
  }) => KidEntry(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    memberId: memberId ?? this.memberId,
    jar: jar ?? this.jar,
    kind: kind ?? this.kind,
    amountMinor: amountMinor ?? this.amountMinor,
    label: label ?? this.label,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  KidEntry copyWithCompanion(KidEntriesCompanion data) {
    return KidEntry(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      jar: data.jar.present ? data.jar.value : this.jar,
      kind: data.kind.present ? data.kind.value : this.kind,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      label: data.label.present ? data.label.value : this.label,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KidEntry(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('memberId: $memberId, ')
          ..write('jar: $jar, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('label: $label, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    memberId,
    jar,
    kind,
    amountMinor,
    label,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KidEntry &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.memberId == this.memberId &&
          other.jar == this.jar &&
          other.kind == this.kind &&
          other.amountMinor == this.amountMinor &&
          other.label == this.label &&
          other.occurredAt == this.occurredAt);
}

class KidEntriesCompanion extends UpdateCompanion<KidEntry> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<String> memberId;
  final Value<String> jar;
  final Value<String> kind;
  final Value<int> amountMinor;
  final Value<String> label;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const KidEntriesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.memberId = const Value.absent(),
    this.jar = const Value.absent(),
    this.kind = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.label = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KidEntriesCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required String memberId,
    required String jar,
    required String kind,
    required int amountMinor,
    this.label = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       memberId = Value(memberId),
       jar = Value(jar),
       kind = Value(kind),
       amountMinor = Value(amountMinor),
       occurredAt = Value(occurredAt);
  static Insertable<KidEntry> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<String>? memberId,
    Expression<String>? jar,
    Expression<String>? kind,
    Expression<int>? amountMinor,
    Expression<String>? label,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (memberId != null) 'member_id': memberId,
      if (jar != null) 'jar': jar,
      if (kind != null) 'kind': kind,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (label != null) 'label': label,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KidEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<String>? memberId,
    Value<String>? jar,
    Value<String>? kind,
    Value<int>? amountMinor,
    Value<String>? label,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return KidEntriesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      memberId: memberId ?? this.memberId,
      jar: jar ?? this.jar,
      kind: kind ?? this.kind,
      amountMinor: amountMinor ?? this.amountMinor,
      label: label ?? this.label,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (jar.present) {
      map['jar'] = Variable<String>(jar.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KidEntriesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('memberId: $memberId, ')
          ..write('jar: $jar, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('label: $label, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeekClosesTable extends WeekCloses
    with TableInfo<$WeekClosesTable, WeekClose> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeekClosesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _householdIdMeta = const VerificationMeta(
    'householdId',
  );
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
    'household_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leftoverMeta = const VerificationMeta(
    'leftover',
  );
  @override
  late final GeneratedColumn<int> leftover = GeneratedColumn<int>(
    'leftover',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toVaultMeta = const VerificationMeta(
    'toVault',
  );
  @override
  late final GeneratedColumn<int> toVault = GeneratedColumn<int>(
    'to_vault',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carriedMeta = const VerificationMeta(
    'carried',
  );
  @override
  late final GeneratedColumn<int> carried = GeneratedColumn<int>(
    'carried',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    weekStart,
    leftover,
    toVault,
    carried,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'week_closes';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeekClose> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('household_id')) {
      context.handle(
        _householdIdMeta,
        householdId.isAcceptableOrUnknown(
          data['household_id']!,
          _householdIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_householdIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('leftover')) {
      context.handle(
        _leftoverMeta,
        leftover.isAcceptableOrUnknown(data['leftover']!, _leftoverMeta),
      );
    } else if (isInserting) {
      context.missing(_leftoverMeta);
    }
    if (data.containsKey('to_vault')) {
      context.handle(
        _toVaultMeta,
        toVault.isAcceptableOrUnknown(data['to_vault']!, _toVaultMeta),
      );
    } else if (isInserting) {
      context.missing(_toVaultMeta);
    }
    if (data.containsKey('carried')) {
      context.handle(
        _carriedMeta,
        carried.isAcceptableOrUnknown(data['carried']!, _carriedMeta),
      );
    } else if (isInserting) {
      context.missing(_carriedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeekClose map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeekClose(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      householdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}household_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start'],
      )!,
      leftover: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}leftover'],
      )!,
      toVault: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_vault'],
      )!,
      carried: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}carried'],
      )!,
    );
  }

  @override
  $WeekClosesTable createAlias(String alias) {
    return $WeekClosesTable(attachedDatabase, alias);
  }
}

class WeekClose extends DataClass implements Insertable<WeekClose> {
  final String id;
  final String householdId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool dirty;
  final DateTime weekStart;
  final int leftover;
  final int toVault;
  final int carried;
  const WeekClose({
    required this.id,
    required this.householdId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.dirty,
    required this.weekStart,
    required this.leftover,
    required this.toVault,
    required this.carried,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['household_id'] = Variable<String>(householdId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['leftover'] = Variable<int>(leftover);
    map['to_vault'] = Variable<int>(toVault);
    map['carried'] = Variable<int>(carried);
    return map;
  }

  WeekClosesCompanion toCompanion(bool nullToAbsent) {
    return WeekClosesCompanion(
      id: Value(id),
      householdId: Value(householdId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      dirty: Value(dirty),
      weekStart: Value(weekStart),
      leftover: Value(leftover),
      toVault: Value(toVault),
      carried: Value(carried),
    );
  }

  factory WeekClose.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeekClose(
      id: serializer.fromJson<String>(json['id']),
      householdId: serializer.fromJson<String>(json['householdId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      leftover: serializer.fromJson<int>(json['leftover']),
      toVault: serializer.fromJson<int>(json['toVault']),
      carried: serializer.fromJson<int>(json['carried']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'householdId': serializer.toJson<String>(householdId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'dirty': serializer.toJson<bool>(dirty),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'leftover': serializer.toJson<int>(leftover),
      'toVault': serializer.toJson<int>(toVault),
      'carried': serializer.toJson<int>(carried),
    };
  }

  WeekClose copyWith({
    String? id,
    String? householdId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? dirty,
    DateTime? weekStart,
    int? leftover,
    int? toVault,
    int? carried,
  }) => WeekClose(
    id: id ?? this.id,
    householdId: householdId ?? this.householdId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    dirty: dirty ?? this.dirty,
    weekStart: weekStart ?? this.weekStart,
    leftover: leftover ?? this.leftover,
    toVault: toVault ?? this.toVault,
    carried: carried ?? this.carried,
  );
  WeekClose copyWithCompanion(WeekClosesCompanion data) {
    return WeekClose(
      id: data.id.present ? data.id.value : this.id,
      householdId: data.householdId.present
          ? data.householdId.value
          : this.householdId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      leftover: data.leftover.present ? data.leftover.value : this.leftover,
      toVault: data.toVault.present ? data.toVault.value : this.toVault,
      carried: data.carried.present ? data.carried.value : this.carried,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeekClose(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('weekStart: $weekStart, ')
          ..write('leftover: $leftover, ')
          ..write('toVault: $toVault, ')
          ..write('carried: $carried')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    householdId,
    createdAt,
    updatedAt,
    deletedAt,
    dirty,
    weekStart,
    leftover,
    toVault,
    carried,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeekClose &&
          other.id == this.id &&
          other.householdId == this.householdId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.dirty == this.dirty &&
          other.weekStart == this.weekStart &&
          other.leftover == this.leftover &&
          other.toVault == this.toVault &&
          other.carried == this.carried);
}

class WeekClosesCompanion extends UpdateCompanion<WeekClose> {
  final Value<String> id;
  final Value<String> householdId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> dirty;
  final Value<DateTime> weekStart;
  final Value<int> leftover;
  final Value<int> toVault;
  final Value<int> carried;
  final Value<int> rowid;
  const WeekClosesCompanion({
    this.id = const Value.absent(),
    this.householdId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.leftover = const Value.absent(),
    this.toVault = const Value.absent(),
    this.carried = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeekClosesCompanion.insert({
    required String id,
    required String householdId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    required DateTime weekStart,
    required int leftover,
    required int toVault,
    required int carried,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       householdId = Value(householdId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       weekStart = Value(weekStart),
       leftover = Value(leftover),
       toVault = Value(toVault),
       carried = Value(carried);
  static Insertable<WeekClose> custom({
    Expression<String>? id,
    Expression<String>? householdId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? dirty,
    Expression<DateTime>? weekStart,
    Expression<int>? leftover,
    Expression<int>? toVault,
    Expression<int>? carried,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (householdId != null) 'household_id': householdId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (dirty != null) 'dirty': dirty,
      if (weekStart != null) 'week_start': weekStart,
      if (leftover != null) 'leftover': leftover,
      if (toVault != null) 'to_vault': toVault,
      if (carried != null) 'carried': carried,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeekClosesCompanion copyWith({
    Value<String>? id,
    Value<String>? householdId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? dirty,
    Value<DateTime>? weekStart,
    Value<int>? leftover,
    Value<int>? toVault,
    Value<int>? carried,
    Value<int>? rowid,
  }) {
    return WeekClosesCompanion(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dirty: dirty ?? this.dirty,
      weekStart: weekStart ?? this.weekStart,
      leftover: leftover ?? this.leftover,
      toVault: toVault ?? this.toVault,
      carried: carried ?? this.carried,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (leftover.present) {
      map['leftover'] = Variable<int>(leftover.value);
    }
    if (toVault.present) {
      map['to_vault'] = Variable<int>(toVault.value);
    }
    if (carried.present) {
      map['carried'] = Variable<int>(carried.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekClosesCompanion(')
          ..write('id: $id, ')
          ..write('householdId: $householdId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('dirty: $dirty, ')
          ..write('weekStart: $weekStart, ')
          ..write('leftover: $leftover, ')
          ..write('toVault: $toVault, ')
          ..write('carried: $carried, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InboxItemsTable extends InboxItems
    with TableInfo<$InboxItemsTable, InboxItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InboxItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _smsKeyMeta = const VerificationMeta('smsKey');
  @override
  late final GeneratedColumn<String> smsKey = GeneratedColumn<String>(
    'sms_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _suggestedCategoryMeta = const VerificationMeta(
    'suggestedCategory',
  );
  @override
  late final GeneratedColumn<String> suggestedCategory =
      GeneratedColumn<String>(
        'suggested_category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _txnIdMeta = const VerificationMeta('txnId');
  @override
  late final GeneratedColumn<String> txnId = GeneratedColumn<String>(
    'txn_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    smsKey,
    sender,
    body,
    receivedAt,
    kind,
    amountMinor,
    currency,
    merchant,
    suggestedCategory,
    status,
    txnId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inbox_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InboxItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sms_key')) {
      context.handle(
        _smsKeyMeta,
        smsKey.isAcceptableOrUnknown(data['sms_key']!, _smsKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_smsKeyMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    }
    if (data.containsKey('suggested_category')) {
      context.handle(
        _suggestedCategoryMeta,
        suggestedCategory.isAcceptableOrUnknown(
          data['suggested_category']!,
          _suggestedCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_suggestedCategoryMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('txn_id')) {
      context.handle(
        _txnIdMeta,
        txnId.isAcceptableOrUnknown(data['txn_id']!, _txnIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InboxItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InboxItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      smsKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_key'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      ),
      suggestedCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_category'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      txnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_id'],
      ),
    );
  }

  @override
  $InboxItemsTable createAlias(String alias) {
    return $InboxItemsTable(attachedDatabase, alias);
  }
}

class InboxItem extends DataClass implements Insertable<InboxItem> {
  final String id;
  final String smsKey;
  final String sender;
  final String body;
  final DateTime receivedAt;

  /// purchase | withdrawal | credit
  final String kind;
  final int amountMinor;
  final String currency;
  final String? merchant;
  final String suggestedCategory;

  /// pending | accepted | dismissed
  final String status;
  final String? txnId;
  const InboxItem({
    required this.id,
    required this.smsKey,
    required this.sender,
    required this.body,
    required this.receivedAt,
    required this.kind,
    required this.amountMinor,
    required this.currency,
    this.merchant,
    required this.suggestedCategory,
    required this.status,
    this.txnId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sms_key'] = Variable<String>(smsKey);
    map['sender'] = Variable<String>(sender);
    map['body'] = Variable<String>(body);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['kind'] = Variable<String>(kind);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant);
    }
    map['suggested_category'] = Variable<String>(suggestedCategory);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || txnId != null) {
      map['txn_id'] = Variable<String>(txnId);
    }
    return map;
  }

  InboxItemsCompanion toCompanion(bool nullToAbsent) {
    return InboxItemsCompanion(
      id: Value(id),
      smsKey: Value(smsKey),
      sender: Value(sender),
      body: Value(body),
      receivedAt: Value(receivedAt),
      kind: Value(kind),
      amountMinor: Value(amountMinor),
      currency: Value(currency),
      merchant: merchant == null && nullToAbsent
          ? const Value.absent()
          : Value(merchant),
      suggestedCategory: Value(suggestedCategory),
      status: Value(status),
      txnId: txnId == null && nullToAbsent
          ? const Value.absent()
          : Value(txnId),
    );
  }

  factory InboxItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InboxItem(
      id: serializer.fromJson<String>(json['id']),
      smsKey: serializer.fromJson<String>(json['smsKey']),
      sender: serializer.fromJson<String>(json['sender']),
      body: serializer.fromJson<String>(json['body']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      kind: serializer.fromJson<String>(json['kind']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      merchant: serializer.fromJson<String?>(json['merchant']),
      suggestedCategory: serializer.fromJson<String>(json['suggestedCategory']),
      status: serializer.fromJson<String>(json['status']),
      txnId: serializer.fromJson<String?>(json['txnId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'smsKey': serializer.toJson<String>(smsKey),
      'sender': serializer.toJson<String>(sender),
      'body': serializer.toJson<String>(body),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'kind': serializer.toJson<String>(kind),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currency': serializer.toJson<String>(currency),
      'merchant': serializer.toJson<String?>(merchant),
      'suggestedCategory': serializer.toJson<String>(suggestedCategory),
      'status': serializer.toJson<String>(status),
      'txnId': serializer.toJson<String?>(txnId),
    };
  }

  InboxItem copyWith({
    String? id,
    String? smsKey,
    String? sender,
    String? body,
    DateTime? receivedAt,
    String? kind,
    int? amountMinor,
    String? currency,
    Value<String?> merchant = const Value.absent(),
    String? suggestedCategory,
    String? status,
    Value<String?> txnId = const Value.absent(),
  }) => InboxItem(
    id: id ?? this.id,
    smsKey: smsKey ?? this.smsKey,
    sender: sender ?? this.sender,
    body: body ?? this.body,
    receivedAt: receivedAt ?? this.receivedAt,
    kind: kind ?? this.kind,
    amountMinor: amountMinor ?? this.amountMinor,
    currency: currency ?? this.currency,
    merchant: merchant.present ? merchant.value : this.merchant,
    suggestedCategory: suggestedCategory ?? this.suggestedCategory,
    status: status ?? this.status,
    txnId: txnId.present ? txnId.value : this.txnId,
  );
  InboxItem copyWithCompanion(InboxItemsCompanion data) {
    return InboxItem(
      id: data.id.present ? data.id.value : this.id,
      smsKey: data.smsKey.present ? data.smsKey.value : this.smsKey,
      sender: data.sender.present ? data.sender.value : this.sender,
      body: data.body.present ? data.body.value : this.body,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      suggestedCategory: data.suggestedCategory.present
          ? data.suggestedCategory.value
          : this.suggestedCategory,
      status: data.status.present ? data.status.value : this.status,
      txnId: data.txnId.present ? data.txnId.value : this.txnId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InboxItem(')
          ..write('id: $id, ')
          ..write('smsKey: $smsKey, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('merchant: $merchant, ')
          ..write('suggestedCategory: $suggestedCategory, ')
          ..write('status: $status, ')
          ..write('txnId: $txnId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    smsKey,
    sender,
    body,
    receivedAt,
    kind,
    amountMinor,
    currency,
    merchant,
    suggestedCategory,
    status,
    txnId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InboxItem &&
          other.id == this.id &&
          other.smsKey == this.smsKey &&
          other.sender == this.sender &&
          other.body == this.body &&
          other.receivedAt == this.receivedAt &&
          other.kind == this.kind &&
          other.amountMinor == this.amountMinor &&
          other.currency == this.currency &&
          other.merchant == this.merchant &&
          other.suggestedCategory == this.suggestedCategory &&
          other.status == this.status &&
          other.txnId == this.txnId);
}

class InboxItemsCompanion extends UpdateCompanion<InboxItem> {
  final Value<String> id;
  final Value<String> smsKey;
  final Value<String> sender;
  final Value<String> body;
  final Value<DateTime> receivedAt;
  final Value<String> kind;
  final Value<int> amountMinor;
  final Value<String> currency;
  final Value<String?> merchant;
  final Value<String> suggestedCategory;
  final Value<String> status;
  final Value<String?> txnId;
  final Value<int> rowid;
  const InboxItemsCompanion({
    this.id = const Value.absent(),
    this.smsKey = const Value.absent(),
    this.sender = const Value.absent(),
    this.body = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.merchant = const Value.absent(),
    this.suggestedCategory = const Value.absent(),
    this.status = const Value.absent(),
    this.txnId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InboxItemsCompanion.insert({
    required String id,
    required String smsKey,
    required String sender,
    required String body,
    required DateTime receivedAt,
    required String kind,
    required int amountMinor,
    required String currency,
    this.merchant = const Value.absent(),
    required String suggestedCategory,
    this.status = const Value.absent(),
    this.txnId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       smsKey = Value(smsKey),
       sender = Value(sender),
       body = Value(body),
       receivedAt = Value(receivedAt),
       kind = Value(kind),
       amountMinor = Value(amountMinor),
       currency = Value(currency),
       suggestedCategory = Value(suggestedCategory);
  static Insertable<InboxItem> custom({
    Expression<String>? id,
    Expression<String>? smsKey,
    Expression<String>? sender,
    Expression<String>? body,
    Expression<DateTime>? receivedAt,
    Expression<String>? kind,
    Expression<int>? amountMinor,
    Expression<String>? currency,
    Expression<String>? merchant,
    Expression<String>? suggestedCategory,
    Expression<String>? status,
    Expression<String>? txnId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (smsKey != null) 'sms_key': smsKey,
      if (sender != null) 'sender': sender,
      if (body != null) 'body': body,
      if (receivedAt != null) 'received_at': receivedAt,
      if (kind != null) 'kind': kind,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currency != null) 'currency': currency,
      if (merchant != null) 'merchant': merchant,
      if (suggestedCategory != null) 'suggested_category': suggestedCategory,
      if (status != null) 'status': status,
      if (txnId != null) 'txn_id': txnId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InboxItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? smsKey,
    Value<String>? sender,
    Value<String>? body,
    Value<DateTime>? receivedAt,
    Value<String>? kind,
    Value<int>? amountMinor,
    Value<String>? currency,
    Value<String?>? merchant,
    Value<String>? suggestedCategory,
    Value<String>? status,
    Value<String?>? txnId,
    Value<int>? rowid,
  }) {
    return InboxItemsCompanion(
      id: id ?? this.id,
      smsKey: smsKey ?? this.smsKey,
      sender: sender ?? this.sender,
      body: body ?? this.body,
      receivedAt: receivedAt ?? this.receivedAt,
      kind: kind ?? this.kind,
      amountMinor: amountMinor ?? this.amountMinor,
      currency: currency ?? this.currency,
      merchant: merchant ?? this.merchant,
      suggestedCategory: suggestedCategory ?? this.suggestedCategory,
      status: status ?? this.status,
      txnId: txnId ?? this.txnId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (smsKey.present) {
      map['sms_key'] = Variable<String>(smsKey.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (suggestedCategory.present) {
      map['suggested_category'] = Variable<String>(suggestedCategory.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (txnId.present) {
      map['txn_id'] = Variable<String>(txnId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InboxItemsCompanion(')
          ..write('id: $id, ')
          ..write('smsKey: $smsKey, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('kind: $kind, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('merchant: $merchant, ')
          ..write('suggestedCategory: $suggestedCategory, ')
          ..write('status: $status, ')
          ..write('txnId: $txnId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KeyValuesTable extends KeyValues
    with TableInfo<$KeyValuesTable, KeyValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValue(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KeyValuesTable createAlias(String alias) {
    return $KeyValuesTable(attachedDatabase, alias);
  }
}

class KeyValue extends DataClass implements Insertable<KeyValue> {
  final String key;
  final String value;
  const KeyValue({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValuesCompanion toCompanion(bool nullToAbsent) {
    return KeyValuesCompanion(key: Value(key), value: Value(value));
  }

  factory KeyValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValue(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValue copyWith({String? key, String? value}) =>
      KeyValue(key: key ?? this.key, value: value ?? this.value);
  KeyValue copyWithCompanion(KeyValuesCompanion data) {
    return KeyValue(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValue(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValue && other.key == this.key && other.value == this.value);
}

class KeyValuesCompanion extends UpdateCompanion<KeyValue> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValuesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValuesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KeyValue> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValuesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KeyValuesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValuesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HouseholdsTable households = $HouseholdsTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $EnvelopesTable envelopes = $EnvelopesTable(this);
  late final $TxnsTable txns = $TxnsTable(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $RoscasTable roscas = $RoscasTable(this);
  late final $KidProfilesTable kidProfiles = $KidProfilesTable(this);
  late final $KidEntriesTable kidEntries = $KidEntriesTable(this);
  late final $WeekClosesTable weekCloses = $WeekClosesTable(this);
  late final $InboxItemsTable inboxItems = $InboxItemsTable(this);
  late final $KeyValuesTable keyValues = $KeyValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    households,
    members,
    wallets,
    categories,
    envelopes,
    txns,
    plans,
    bills,
    debts,
    roscas,
    kidProfiles,
    kidEntries,
    weekCloses,
    inboxItems,
    keyValues,
  ];
}

typedef $$HouseholdsTableCreateCompanionBuilder = HouseholdsCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String name,
  Value<String> baseCurrency,
  Value<int> usdRate,
  Value<String?> inviteCode,
  Value<int> rowid,
});
typedef $$HouseholdsTableUpdateCompanionBuilder = HouseholdsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> name,
  Value<String> baseCurrency,
  Value<int> usdRate,
  Value<String?> inviteCode,
  Value<int> rowid,
});

class $$HouseholdsTableFilterComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usdRate => $composableBuilder(
    column: $table.usdRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HouseholdsTableOrderingComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usdRate => $composableBuilder(
    column: $table.usdRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HouseholdsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HouseholdsTable> {
  $$HouseholdsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usdRate =>
      $composableBuilder(column: $table.usdRate, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );
}

class $$HouseholdsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HouseholdsTable,
          Household,
          $$HouseholdsTableFilterComposer,
          $$HouseholdsTableOrderingComposer,
          $$HouseholdsTableAnnotationComposer,
          $$HouseholdsTableCreateCompanionBuilder,
          $$HouseholdsTableUpdateCompanionBuilder,
          (
            Household,
            BaseReferences<_$AppDatabase, $HouseholdsTable, Household>,
          ),
          Household,
          PrefetchHooks Function()
        > {
  $$HouseholdsTableTableManager(_$AppDatabase db, $HouseholdsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HouseholdsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HouseholdsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HouseholdsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<int> usdRate = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                baseCurrency: baseCurrency,
                usdRate: usdRate,
                inviteCode: inviteCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                Value<String> baseCurrency = const Value.absent(),
                Value<int> usdRate = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HouseholdsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                baseCurrency: baseCurrency,
                usdRate: usdRate,
                inviteCode: inviteCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HouseholdsTable, Household>(table),
                  BaseReferences<_$AppDatabase, $HouseholdsTable, Household>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HouseholdsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HouseholdsTable,
      Household,
      $$HouseholdsTableFilterComposer,
      $$HouseholdsTableOrderingComposer,
      $$HouseholdsTableAnnotationComposer,
      $$HouseholdsTableCreateCompanionBuilder,
      $$HouseholdsTableUpdateCompanionBuilder,
      (Household, BaseReferences<_$AppDatabase, $HouseholdsTable, Household>),
      Household,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String displayName,
  required String role,
  required String letter,
  Value<int> colorIndex,
  Value<String?> userId,
  Value<int> freeAllowance,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> displayName,
  Value<String> role,
  Value<String> letter,
  Value<int> colorIndex,
  Value<String?> userId,
  Value<int> freeAllowance,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get letter => $composableBuilder(
    column: $table.letter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get freeAllowance => $composableBuilder(
    column: $table.freeAllowance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get letter => $composableBuilder(
    column: $table.letter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get freeAllowance => $composableBuilder(
    column: $table.freeAllowance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get letter =>
      $composableBuilder(column: $table.letter, builder: (column) => column);

  GeneratedColumn<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get freeAllowance => $composableBuilder(
    column: $table.freeAllowance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
          Member,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> letter = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<int> freeAllowance = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                displayName: displayName,
                role: role,
                letter: letter,
                colorIndex: colorIndex,
                userId: userId,
                freeAllowance: freeAllowance,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String displayName,
                required String role,
                required String letter,
                Value<int> colorIndex = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<int> freeAllowance = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                displayName: displayName,
                role: role,
                letter: letter,
                colorIndex: colorIndex,
                userId: userId,
                freeAllowance: freeAllowance,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, Member>(table),
                  BaseReferences<_$AppDatabase, $MembersTable, Member>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
      Member,
      PrefetchHooks Function()
    >;
typedef $$WalletsTableCreateCompanionBuilder = WalletsCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String name,
  required String kind,
  Value<String> currency,
  Value<String?> ownerMemberId,
  Value<int> rowid,
});
typedef $$WalletsTableUpdateCompanionBuilder = WalletsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> name,
  Value<String> kind,
  Value<String> currency,
  Value<String?> ownerMemberId,
  Value<int> rowid,
});

class $$WalletsTableFilterComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerMemberId => $composableBuilder(
    column: $table.ownerMemberId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerMemberId => $composableBuilder(
    column: $table.ownerMemberId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get ownerMemberId => $composableBuilder(
    column: $table.ownerMemberId,
    builder: (column) => column,
  );
}

class $$WalletsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletsTable,
          Wallet,
          $$WalletsTableFilterComposer,
          $$WalletsTableOrderingComposer,
          $$WalletsTableAnnotationComposer,
          $$WalletsTableCreateCompanionBuilder,
          $$WalletsTableUpdateCompanionBuilder,
          (Wallet, BaseReferences<_$AppDatabase, $WalletsTable, Wallet>),
          Wallet,
          PrefetchHooks Function()
        > {
  $$WalletsTableTableManager(_$AppDatabase db, $WalletsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> ownerMemberId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                kind: kind,
                currency: currency,
                ownerMemberId: ownerMemberId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                required String kind,
                Value<String> currency = const Value.absent(),
                Value<String?> ownerMemberId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                kind: kind,
                currency: currency,
                ownerMemberId: ownerMemberId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WalletsTable, Wallet>(table),
                  BaseReferences<_$AppDatabase, $WalletsTable, Wallet>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletsTable,
      Wallet,
      $$WalletsTableFilterComposer,
      $$WalletsTableOrderingComposer,
      $$WalletsTableAnnotationComposer,
      $$WalletsTableCreateCompanionBuilder,
      $$WalletsTableUpdateCompanionBuilder,
      (Wallet, BaseReferences<_$AppDatabase, $WalletsTable, Wallet>),
      Wallet,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String key,
  required String name,
  required String kind,
  required String groupName,
  Value<bool> isFixed,
  Value<String> keywords,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> key,
  Value<String> name,
  Value<String> kind,
  Value<String> groupName,
  Value<bool> isFixed,
  Value<String> keywords,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keywords => $composableBuilder(
    column: $table.keywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keywords => $composableBuilder(
    column: $table.keywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<bool> get isFixed =>
      $composableBuilder(column: $table.isFixed, builder: (column) => column);

  GeneratedColumn<String> get keywords =>
      $composableBuilder(column: $table.keywords, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<bool> isFixed = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                key: key,
                name: name,
                kind: kind,
                groupName: groupName,
                isFixed: isFixed,
                keywords: keywords,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String key,
                required String name,
                required String kind,
                required String groupName,
                Value<bool> isFixed = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                key: key,
                name: name,
                kind: kind,
                groupName: groupName,
                isFixed: isFixed,
                keywords: keywords,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  BaseReferences<_$AppDatabase, $CategoriesTable, Category>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$EnvelopesTableCreateCompanionBuilder = EnvelopesCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String name,
  required String kind,
  Value<int> targetMinor,
  Value<int> monthlyMinor,
  Value<bool> locked,
  Value<int> noteDenomination,
  Value<String?> memberId,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$EnvelopesTableUpdateCompanionBuilder = EnvelopesCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> name,
  Value<String> kind,
  Value<int> targetMinor,
  Value<int> monthlyMinor,
  Value<bool> locked,
  Value<int> noteDenomination,
  Value<String?> memberId,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$EnvelopesTableFilterComposer
    extends Composer<_$AppDatabase, $EnvelopesTable> {
  $$EnvelopesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinor => $composableBuilder(
    column: $table.targetMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyMinor => $composableBuilder(
    column: $table.monthlyMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get noteDenomination => $composableBuilder(
    column: $table.noteDenomination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EnvelopesTableOrderingComposer
    extends Composer<_$AppDatabase, $EnvelopesTable> {
  $$EnvelopesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinor => $composableBuilder(
    column: $table.targetMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyMinor => $composableBuilder(
    column: $table.monthlyMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get locked => $composableBuilder(
    column: $table.locked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get noteDenomination => $composableBuilder(
    column: $table.noteDenomination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EnvelopesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnvelopesTable> {
  $$EnvelopesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get targetMinor => $composableBuilder(
    column: $table.targetMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monthlyMinor => $composableBuilder(
    column: $table.monthlyMinor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get locked =>
      $composableBuilder(column: $table.locked, builder: (column) => column);

  GeneratedColumn<int> get noteDenomination => $composableBuilder(
    column: $table.noteDenomination,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$EnvelopesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnvelopesTable,
          Envelope,
          $$EnvelopesTableFilterComposer,
          $$EnvelopesTableOrderingComposer,
          $$EnvelopesTableAnnotationComposer,
          $$EnvelopesTableCreateCompanionBuilder,
          $$EnvelopesTableUpdateCompanionBuilder,
          (Envelope, BaseReferences<_$AppDatabase, $EnvelopesTable, Envelope>),
          Envelope,
          PrefetchHooks Function()
        > {
  $$EnvelopesTableTableManager(_$AppDatabase db, $EnvelopesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnvelopesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnvelopesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnvelopesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> targetMinor = const Value.absent(),
                Value<int> monthlyMinor = const Value.absent(),
                Value<bool> locked = const Value.absent(),
                Value<int> noteDenomination = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnvelopesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                kind: kind,
                targetMinor: targetMinor,
                monthlyMinor: monthlyMinor,
                locked: locked,
                noteDenomination: noteDenomination,
                memberId: memberId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                required String kind,
                Value<int> targetMinor = const Value.absent(),
                Value<int> monthlyMinor = const Value.absent(),
                Value<bool> locked = const Value.absent(),
                Value<int> noteDenomination = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnvelopesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                kind: kind,
                targetMinor: targetMinor,
                monthlyMinor: monthlyMinor,
                locked: locked,
                noteDenomination: noteDenomination,
                memberId: memberId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EnvelopesTable, Envelope>(table),
                  BaseReferences<_$AppDatabase, $EnvelopesTable, Envelope>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EnvelopesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnvelopesTable,
      Envelope,
      $$EnvelopesTableFilterComposer,
      $$EnvelopesTableOrderingComposer,
      $$EnvelopesTableAnnotationComposer,
      $$EnvelopesTableCreateCompanionBuilder,
      $$EnvelopesTableUpdateCompanionBuilder,
      (Envelope, BaseReferences<_$AppDatabase, $EnvelopesTable, Envelope>),
      Envelope,
      PrefetchHooks Function()
    >;
typedef $$TxnsTableCreateCompanionBuilder = TxnsCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String kind,
  required int amountMinor,
  Value<String> currency,
  Value<int> fxRate,
  required int amountBase,
  Value<String?> walletId,
  Value<String?> toWalletId,
  Value<String?> categoryKey,
  Value<String?> envelopeId,
  Value<String?> memberId,
  required DateTime occurredAt,
  Value<String> label,
  Value<String> note,
  Value<String> source,
  Value<bool> countsInWeek,
  Value<int> rowid,
});
typedef $$TxnsTableUpdateCompanionBuilder = TxnsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> kind,
  Value<int> amountMinor,
  Value<String> currency,
  Value<int> fxRate,
  Value<int> amountBase,
  Value<String?> walletId,
  Value<String?> toWalletId,
  Value<String?> categoryKey,
  Value<String?> envelopeId,
  Value<String?> memberId,
  Value<DateTime> occurredAt,
  Value<String> label,
  Value<String> note,
  Value<String> source,
  Value<bool> countsInWeek,
  Value<int> rowid,
});

class $$TxnsTableFilterComposer extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fxRate => $composableBuilder(
    column: $table.fxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBase => $composableBuilder(
    column: $table.amountBase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toWalletId => $composableBuilder(
    column: $table.toWalletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get envelopeId => $composableBuilder(
    column: $table.envelopeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get countsInWeek => $composableBuilder(
    column: $table.countsInWeek,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TxnsTableOrderingComposer extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fxRate => $composableBuilder(
    column: $table.fxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBase => $composableBuilder(
    column: $table.amountBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toWalletId => $composableBuilder(
    column: $table.toWalletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get envelopeId => $composableBuilder(
    column: $table.envelopeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get countsInWeek => $composableBuilder(
    column: $table.countsInWeek,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TxnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TxnsTable> {
  $$TxnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get fxRate =>
      $composableBuilder(column: $table.fxRate, builder: (column) => column);

  GeneratedColumn<int> get amountBase => $composableBuilder(
    column: $table.amountBase,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walletId =>
      $composableBuilder(column: $table.walletId, builder: (column) => column);

  GeneratedColumn<String> get toWalletId => $composableBuilder(
    column: $table.toWalletId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get envelopeId => $composableBuilder(
    column: $table.envelopeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get countsInWeek => $composableBuilder(
    column: $table.countsInWeek,
    builder: (column) => column,
  );
}

class $$TxnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TxnsTable,
          Txn,
          $$TxnsTableFilterComposer,
          $$TxnsTableOrderingComposer,
          $$TxnsTableAnnotationComposer,
          $$TxnsTableCreateCompanionBuilder,
          $$TxnsTableUpdateCompanionBuilder,
          (Txn, BaseReferences<_$AppDatabase, $TxnsTable, Txn>),
          Txn,
          PrefetchHooks Function()
        > {
  $$TxnsTableTableManager(_$AppDatabase db, $TxnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TxnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TxnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TxnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> fxRate = const Value.absent(),
                Value<int> amountBase = const Value.absent(),
                Value<String?> walletId = const Value.absent(),
                Value<String?> toWalletId = const Value.absent(),
                Value<String?> categoryKey = const Value.absent(),
                Value<String?> envelopeId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> countsInWeek = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                kind: kind,
                amountMinor: amountMinor,
                currency: currency,
                fxRate: fxRate,
                amountBase: amountBase,
                walletId: walletId,
                toWalletId: toWalletId,
                categoryKey: categoryKey,
                envelopeId: envelopeId,
                memberId: memberId,
                occurredAt: occurredAt,
                label: label,
                note: note,
                source: source,
                countsInWeek: countsInWeek,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String kind,
                required int amountMinor,
                Value<String> currency = const Value.absent(),
                Value<int> fxRate = const Value.absent(),
                required int amountBase,
                Value<String?> walletId = const Value.absent(),
                Value<String?> toWalletId = const Value.absent(),
                Value<String?> categoryKey = const Value.absent(),
                Value<String?> envelopeId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                required DateTime occurredAt,
                Value<String> label = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> countsInWeek = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                kind: kind,
                amountMinor: amountMinor,
                currency: currency,
                fxRate: fxRate,
                amountBase: amountBase,
                walletId: walletId,
                toWalletId: toWalletId,
                categoryKey: categoryKey,
                envelopeId: envelopeId,
                memberId: memberId,
                occurredAt: occurredAt,
                label: label,
                note: note,
                source: source,
                countsInWeek: countsInWeek,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TxnsTable, Txn>(table),
                  BaseReferences<_$AppDatabase, $TxnsTable, Txn>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TxnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TxnsTable,
      Txn,
      $$TxnsTableFilterComposer,
      $$TxnsTableOrderingComposer,
      $$TxnsTableAnnotationComposer,
      $$TxnsTableCreateCompanionBuilder,
      $$TxnsTableUpdateCompanionBuilder,
      (Txn, BaseReferences<_$AppDatabase, $TxnsTable, Txn>),
      Txn,
      PrefetchHooks Function()
    >;
typedef $$PlansTableCreateCompanionBuilder = PlansCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required int salary,
  Value<int> savePercent,
  Value<int> payDay,
  Value<int> minPerDay,
  Value<int> rowid,
});
typedef $$PlansTableUpdateCompanionBuilder = PlansCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<int> salary,
  Value<int> savePercent,
  Value<int> payDay,
  Value<int> minPerDay,
  Value<int> rowid,
});

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savePercent => $composableBuilder(
    column: $table.savePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payDay => $composableBuilder(
    column: $table.payDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minPerDay => $composableBuilder(
    column: $table.minPerDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savePercent => $composableBuilder(
    column: $table.savePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payDay => $composableBuilder(
    column: $table.payDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minPerDay => $composableBuilder(
    column: $table.minPerDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  GeneratedColumn<int> get savePercent => $composableBuilder(
    column: $table.savePercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payDay =>
      $composableBuilder(column: $table.payDay, builder: (column) => column);

  GeneratedColumn<int> get minPerDay =>
      $composableBuilder(column: $table.minPerDay, builder: (column) => column);
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          Plan,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
          Plan,
          PrefetchHooks Function()
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<int> salary = const Value.absent(),
                Value<int> savePercent = const Value.absent(),
                Value<int> payDay = const Value.absent(),
                Value<int> minPerDay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                salary: salary,
                savePercent: savePercent,
                payDay: payDay,
                minPerDay: minPerDay,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required int salary,
                Value<int> savePercent = const Value.absent(),
                Value<int> payDay = const Value.absent(),
                Value<int> minPerDay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                salary: salary,
                savePercent: savePercent,
                payDay: payDay,
                minPerDay: minPerDay,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlansTable, Plan>(table),
                  BaseReferences<_$AppDatabase, $PlansTable, Plan>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      Plan,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
      Plan,
      PrefetchHooks Function()
    >;
typedef $$BillsTableCreateCompanionBuilder = BillsCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String name,
  required String icon,
  required int amountMinor,
  required int dayOfMonth,
  required String categoryKey,
  Value<int?> amps,
  Value<int?> pricePerAmp,
  Value<bool> active,
  Value<String?> lastPosted,
  Value<int> rowid,
});
typedef $$BillsTableUpdateCompanionBuilder = BillsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> name,
  Value<String> icon,
  Value<int> amountMinor,
  Value<int> dayOfMonth,
  Value<String> categoryKey,
  Value<int?> amps,
  Value<int?> pricePerAmp,
  Value<bool> active,
  Value<String?> lastPosted,
  Value<int> rowid,
});

class $$BillsTableFilterComposer extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerAmp => $composableBuilder(
    column: $table.pricePerAmp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPosted => $composableBuilder(
    column: $table.lastPosted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerAmp => $composableBuilder(
    column: $table.pricePerAmp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPosted => $composableBuilder(
    column: $table.lastPosted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryKey => $composableBuilder(
    column: $table.categoryKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amps =>
      $composableBuilder(column: $table.amps, builder: (column) => column);

  GeneratedColumn<int> get pricePerAmp => $composableBuilder(
    column: $table.pricePerAmp,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get lastPosted => $composableBuilder(
    column: $table.lastPosted,
    builder: (column) => column,
  );
}

class $$BillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsTable,
          Bill,
          $$BillsTableFilterComposer,
          $$BillsTableOrderingComposer,
          $$BillsTableAnnotationComposer,
          $$BillsTableCreateCompanionBuilder,
          $$BillsTableUpdateCompanionBuilder,
          (Bill, BaseReferences<_$AppDatabase, $BillsTable, Bill>),
          Bill,
          PrefetchHooks Function()
        > {
  $$BillsTableTableManager(_$AppDatabase db, $BillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> dayOfMonth = const Value.absent(),
                Value<String> categoryKey = const Value.absent(),
                Value<int?> amps = const Value.absent(),
                Value<int?> pricePerAmp = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> lastPosted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                icon: icon,
                amountMinor: amountMinor,
                dayOfMonth: dayOfMonth,
                categoryKey: categoryKey,
                amps: amps,
                pricePerAmp: pricePerAmp,
                active: active,
                lastPosted: lastPosted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                required String icon,
                required int amountMinor,
                required int dayOfMonth,
                required String categoryKey,
                Value<int?> amps = const Value.absent(),
                Value<int?> pricePerAmp = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> lastPosted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                icon: icon,
                amountMinor: amountMinor,
                dayOfMonth: dayOfMonth,
                categoryKey: categoryKey,
                amps: amps,
                pricePerAmp: pricePerAmp,
                active: active,
                lastPosted: lastPosted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillsTable, Bill>(table),
                  BaseReferences<_$AppDatabase, $BillsTable, Bill>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsTable,
      Bill,
      $$BillsTableFilterComposer,
      $$BillsTableOrderingComposer,
      $$BillsTableAnnotationComposer,
      $$BillsTableCreateCompanionBuilder,
      $$BillsTableUpdateCompanionBuilder,
      (Bill, BaseReferences<_$AppDatabase, $BillsTable, Bill>),
      Bill,
      PrefetchHooks Function()
    >;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String personName,
  required String direction,
  required int amountMinor,
  Value<int> paidMinor,
  Value<String> note,
  Value<bool> forgiven,
  Value<int> rowid,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> personName,
  Value<String> direction,
  Value<int> amountMinor,
  Value<int> paidMinor,
  Value<String> note,
  Value<bool> forgiven,
  Value<int> rowid,
});

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidMinor => $composableBuilder(
    column: $table.paidMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get forgiven => $composableBuilder(
    column: $table.forgiven,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidMinor => $composableBuilder(
    column: $table.paidMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get forgiven => $composableBuilder(
    column: $table.forgiven,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get personName => $composableBuilder(
    column: $table.personName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paidMinor =>
      $composableBuilder(column: $table.paidMinor, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get forgiven =>
      $composableBuilder(column: $table.forgiven, builder: (column) => column);
}

class $$DebtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtsTable,
          Debt,
          $$DebtsTableFilterComposer,
          $$DebtsTableOrderingComposer,
          $$DebtsTableAnnotationComposer,
          $$DebtsTableCreateCompanionBuilder,
          $$DebtsTableUpdateCompanionBuilder,
          (Debt, BaseReferences<_$AppDatabase, $DebtsTable, Debt>),
          Debt,
          PrefetchHooks Function()
        > {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> personName = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> paidMinor = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> forgiven = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                personName: personName,
                direction: direction,
                amountMinor: amountMinor,
                paidMinor: paidMinor,
                note: note,
                forgiven: forgiven,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String personName,
                required String direction,
                required int amountMinor,
                Value<int> paidMinor = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> forgiven = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                personName: personName,
                direction: direction,
                amountMinor: amountMinor,
                paidMinor: paidMinor,
                note: note,
                forgiven: forgiven,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DebtsTable, Debt>(table),
                  BaseReferences<_$AppDatabase, $DebtsTable, Debt>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtsTable,
      Debt,
      $$DebtsTableFilterComposer,
      $$DebtsTableOrderingComposer,
      $$DebtsTableAnnotationComposer,
      $$DebtsTableCreateCompanionBuilder,
      $$DebtsTableUpdateCompanionBuilder,
      (Debt, BaseReferences<_$AppDatabase, $DebtsTable, Debt>),
      Debt,
      PrefetchHooks Function()
    >;
typedef $$RoscasTableCreateCompanionBuilder = RoscasCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String name,
  Value<String> organizer,
  required int membersCount,
  required int contribution,
  required int startYear,
  required int startMonth,
  required int myTurn,
  Value<int> paidRounds,
  Value<String> warning,
  Value<int> rowid,
});
typedef $$RoscasTableUpdateCompanionBuilder = RoscasCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> name,
  Value<String> organizer,
  Value<int> membersCount,
  Value<int> contribution,
  Value<int> startYear,
  Value<int> startMonth,
  Value<int> myTurn,
  Value<int> paidRounds,
  Value<String> warning,
  Value<int> rowid,
});

class $$RoscasTableFilterComposer
    extends Composer<_$AppDatabase, $RoscasTable> {
  $$RoscasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizer => $composableBuilder(
    column: $table.organizer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get membersCount => $composableBuilder(
    column: $table.membersCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contribution => $composableBuilder(
    column: $table.contribution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startYear => $composableBuilder(
    column: $table.startYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMonth => $composableBuilder(
    column: $table.startMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get myTurn => $composableBuilder(
    column: $table.myTurn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidRounds => $composableBuilder(
    column: $table.paidRounds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warning => $composableBuilder(
    column: $table.warning,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoscasTableOrderingComposer
    extends Composer<_$AppDatabase, $RoscasTable> {
  $$RoscasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizer => $composableBuilder(
    column: $table.organizer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get membersCount => $composableBuilder(
    column: $table.membersCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contribution => $composableBuilder(
    column: $table.contribution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startYear => $composableBuilder(
    column: $table.startYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMonth => $composableBuilder(
    column: $table.startMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get myTurn => $composableBuilder(
    column: $table.myTurn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidRounds => $composableBuilder(
    column: $table.paidRounds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warning => $composableBuilder(
    column: $table.warning,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoscasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoscasTable> {
  $$RoscasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get organizer =>
      $composableBuilder(column: $table.organizer, builder: (column) => column);

  GeneratedColumn<int> get membersCount => $composableBuilder(
    column: $table.membersCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contribution => $composableBuilder(
    column: $table.contribution,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startYear =>
      $composableBuilder(column: $table.startYear, builder: (column) => column);

  GeneratedColumn<int> get startMonth => $composableBuilder(
    column: $table.startMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get myTurn =>
      $composableBuilder(column: $table.myTurn, builder: (column) => column);

  GeneratedColumn<int> get paidRounds => $composableBuilder(
    column: $table.paidRounds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warning =>
      $composableBuilder(column: $table.warning, builder: (column) => column);
}

class $$RoscasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoscasTable,
          Rosca,
          $$RoscasTableFilterComposer,
          $$RoscasTableOrderingComposer,
          $$RoscasTableAnnotationComposer,
          $$RoscasTableCreateCompanionBuilder,
          $$RoscasTableUpdateCompanionBuilder,
          (Rosca, BaseReferences<_$AppDatabase, $RoscasTable, Rosca>),
          Rosca,
          PrefetchHooks Function()
        > {
  $$RoscasTableTableManager(_$AppDatabase db, $RoscasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoscasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoscasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoscasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> organizer = const Value.absent(),
                Value<int> membersCount = const Value.absent(),
                Value<int> contribution = const Value.absent(),
                Value<int> startYear = const Value.absent(),
                Value<int> startMonth = const Value.absent(),
                Value<int> myTurn = const Value.absent(),
                Value<int> paidRounds = const Value.absent(),
                Value<String> warning = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoscasCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                organizer: organizer,
                membersCount: membersCount,
                contribution: contribution,
                startYear: startYear,
                startMonth: startMonth,
                myTurn: myTurn,
                paidRounds: paidRounds,
                warning: warning,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String name,
                Value<String> organizer = const Value.absent(),
                required int membersCount,
                required int contribution,
                required int startYear,
                required int startMonth,
                required int myTurn,
                Value<int> paidRounds = const Value.absent(),
                Value<String> warning = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoscasCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                name: name,
                organizer: organizer,
                membersCount: membersCount,
                contribution: contribution,
                startYear: startYear,
                startMonth: startMonth,
                myTurn: myTurn,
                paidRounds: paidRounds,
                warning: warning,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoscasTable, Rosca>(table),
                  BaseReferences<_$AppDatabase, $RoscasTable, Rosca>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoscasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoscasTable,
      Rosca,
      $$RoscasTableFilterComposer,
      $$RoscasTableOrderingComposer,
      $$RoscasTableAnnotationComposer,
      $$RoscasTableCreateCompanionBuilder,
      $$RoscasTableUpdateCompanionBuilder,
      (Rosca, BaseReferences<_$AppDatabase, $RoscasTable, Rosca>),
      Rosca,
      PrefetchHooks Function()
    >;
typedef $$KidProfilesTableCreateCompanionBuilder =
    KidProfilesCompanion Function({
      required String id,
      required String householdId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> dirty,
      required String memberId,
      Value<String> goalName,
      Value<int> goalMinor,
      Value<int> matchPercent,
      Value<int> weeklyAllowance,
      Value<int> rowid,
    });
typedef $$KidProfilesTableUpdateCompanionBuilder =
    KidProfilesCompanion Function({
      Value<String> id,
      Value<String> householdId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<bool> dirty,
      Value<String> memberId,
      Value<String> goalName,
      Value<int> goalMinor,
      Value<int> matchPercent,
      Value<int> weeklyAllowance,
      Value<int> rowid,
    });

class $$KidProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $KidProfilesTable> {
  $$KidProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalName => $composableBuilder(
    column: $table.goalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalMinor => $composableBuilder(
    column: $table.goalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchPercent => $composableBuilder(
    column: $table.matchPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyAllowance => $composableBuilder(
    column: $table.weeklyAllowance,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KidProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $KidProfilesTable> {
  $$KidProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalName => $composableBuilder(
    column: $table.goalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalMinor => $composableBuilder(
    column: $table.goalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchPercent => $composableBuilder(
    column: $table.matchPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyAllowance => $composableBuilder(
    column: $table.weeklyAllowance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KidProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KidProfilesTable> {
  $$KidProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get goalName =>
      $composableBuilder(column: $table.goalName, builder: (column) => column);

  GeneratedColumn<int> get goalMinor =>
      $composableBuilder(column: $table.goalMinor, builder: (column) => column);

  GeneratedColumn<int> get matchPercent => $composableBuilder(
    column: $table.matchPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeklyAllowance => $composableBuilder(
    column: $table.weeklyAllowance,
    builder: (column) => column,
  );
}

class $$KidProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KidProfilesTable,
          KidProfile,
          $$KidProfilesTableFilterComposer,
          $$KidProfilesTableOrderingComposer,
          $$KidProfilesTableAnnotationComposer,
          $$KidProfilesTableCreateCompanionBuilder,
          $$KidProfilesTableUpdateCompanionBuilder,
          (
            KidProfile,
            BaseReferences<_$AppDatabase, $KidProfilesTable, KidProfile>,
          ),
          KidProfile,
          PrefetchHooks Function()
        > {
  $$KidProfilesTableTableManager(_$AppDatabase db, $KidProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KidProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KidProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KidProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> goalName = const Value.absent(),
                Value<int> goalMinor = const Value.absent(),
                Value<int> matchPercent = const Value.absent(),
                Value<int> weeklyAllowance = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KidProfilesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                memberId: memberId,
                goalName: goalName,
                goalMinor: goalMinor,
                matchPercent: matchPercent,
                weeklyAllowance: weeklyAllowance,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String memberId,
                Value<String> goalName = const Value.absent(),
                Value<int> goalMinor = const Value.absent(),
                Value<int> matchPercent = const Value.absent(),
                Value<int> weeklyAllowance = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KidProfilesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                memberId: memberId,
                goalName: goalName,
                goalMinor: goalMinor,
                matchPercent: matchPercent,
                weeklyAllowance: weeklyAllowance,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KidProfilesTable, KidProfile>(table),
                  BaseReferences<_$AppDatabase, $KidProfilesTable, KidProfile>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KidProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KidProfilesTable,
      KidProfile,
      $$KidProfilesTableFilterComposer,
      $$KidProfilesTableOrderingComposer,
      $$KidProfilesTableAnnotationComposer,
      $$KidProfilesTableCreateCompanionBuilder,
      $$KidProfilesTableUpdateCompanionBuilder,
      (
        KidProfile,
        BaseReferences<_$AppDatabase, $KidProfilesTable, KidProfile>,
      ),
      KidProfile,
      PrefetchHooks Function()
    >;
typedef $$KidEntriesTableCreateCompanionBuilder = KidEntriesCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required String memberId,
  required String jar,
  required String kind,
  required int amountMinor,
  Value<String> label,
  required DateTime occurredAt,
  Value<int> rowid,
});
typedef $$KidEntriesTableUpdateCompanionBuilder = KidEntriesCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<String> memberId,
  Value<String> jar,
  Value<String> kind,
  Value<int> amountMinor,
  Value<String> label,
  Value<DateTime> occurredAt,
  Value<int> rowid,
});

class $$KidEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $KidEntriesTable> {
  $$KidEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jar => $composableBuilder(
    column: $table.jar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KidEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $KidEntriesTable> {
  $$KidEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jar => $composableBuilder(
    column: $table.jar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KidEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KidEntriesTable> {
  $$KidEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get jar =>
      $composableBuilder(column: $table.jar, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );
}

class $$KidEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KidEntriesTable,
          KidEntry,
          $$KidEntriesTableFilterComposer,
          $$KidEntriesTableOrderingComposer,
          $$KidEntriesTableAnnotationComposer,
          $$KidEntriesTableCreateCompanionBuilder,
          $$KidEntriesTableUpdateCompanionBuilder,
          (KidEntry, BaseReferences<_$AppDatabase, $KidEntriesTable, KidEntry>),
          KidEntry,
          PrefetchHooks Function()
        > {
  $$KidEntriesTableTableManager(_$AppDatabase db, $KidEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KidEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KidEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KidEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> jar = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KidEntriesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                memberId: memberId,
                jar: jar,
                kind: kind,
                amountMinor: amountMinor,
                label: label,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required String memberId,
                required String jar,
                required String kind,
                required int amountMinor,
                Value<String> label = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => KidEntriesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                memberId: memberId,
                jar: jar,
                kind: kind,
                amountMinor: amountMinor,
                label: label,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KidEntriesTable, KidEntry>(table),
                  BaseReferences<_$AppDatabase, $KidEntriesTable, KidEntry>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KidEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KidEntriesTable,
      KidEntry,
      $$KidEntriesTableFilterComposer,
      $$KidEntriesTableOrderingComposer,
      $$KidEntriesTableAnnotationComposer,
      $$KidEntriesTableCreateCompanionBuilder,
      $$KidEntriesTableUpdateCompanionBuilder,
      (KidEntry, BaseReferences<_$AppDatabase, $KidEntriesTable, KidEntry>),
      KidEntry,
      PrefetchHooks Function()
    >;
typedef $$WeekClosesTableCreateCompanionBuilder = WeekClosesCompanion Function({
  required String id,
  required String householdId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  required DateTime weekStart,
  required int leftover,
  required int toVault,
  required int carried,
  Value<int> rowid,
});
typedef $$WeekClosesTableUpdateCompanionBuilder = WeekClosesCompanion Function({
  Value<String> id,
  Value<String> householdId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> dirty,
  Value<DateTime> weekStart,
  Value<int> leftover,
  Value<int> toVault,
  Value<int> carried,
  Value<int> rowid,
});

class $$WeekClosesTableFilterComposer
    extends Composer<_$AppDatabase, $WeekClosesTable> {
  $$WeekClosesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leftover => $composableBuilder(
    column: $table.leftover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toVault => $composableBuilder(
    column: $table.toVault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get carried => $composableBuilder(
    column: $table.carried,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeekClosesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeekClosesTable> {
  $$WeekClosesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leftover => $composableBuilder(
    column: $table.leftover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toVault => $composableBuilder(
    column: $table.toVault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get carried => $composableBuilder(
    column: $table.carried,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeekClosesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeekClosesTable> {
  $$WeekClosesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
    column: $table.householdId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<int> get leftover =>
      $composableBuilder(column: $table.leftover, builder: (column) => column);

  GeneratedColumn<int> get toVault =>
      $composableBuilder(column: $table.toVault, builder: (column) => column);

  GeneratedColumn<int> get carried =>
      $composableBuilder(column: $table.carried, builder: (column) => column);
}

class $$WeekClosesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeekClosesTable,
          WeekClose,
          $$WeekClosesTableFilterComposer,
          $$WeekClosesTableOrderingComposer,
          $$WeekClosesTableAnnotationComposer,
          $$WeekClosesTableCreateCompanionBuilder,
          $$WeekClosesTableUpdateCompanionBuilder,
          (
            WeekClose,
            BaseReferences<_$AppDatabase, $WeekClosesTable, WeekClose>,
          ),
          WeekClose,
          PrefetchHooks Function()
        > {
  $$WeekClosesTableTableManager(_$AppDatabase db, $WeekClosesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeekClosesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeekClosesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeekClosesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> householdId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> weekStart = const Value.absent(),
                Value<int> leftover = const Value.absent(),
                Value<int> toVault = const Value.absent(),
                Value<int> carried = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeekClosesCompanion(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                weekStart: weekStart,
                leftover: leftover,
                toVault: toVault,
                carried: carried,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String householdId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required DateTime weekStart,
                required int leftover,
                required int toVault,
                required int carried,
                Value<int> rowid = const Value.absent(),
              }) => WeekClosesCompanion.insert(
                id: id,
                householdId: householdId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                dirty: dirty,
                weekStart: weekStart,
                leftover: leftover,
                toVault: toVault,
                carried: carried,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeekClosesTable, WeekClose>(table),
                  BaseReferences<_$AppDatabase, $WeekClosesTable, WeekClose>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeekClosesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeekClosesTable,
      WeekClose,
      $$WeekClosesTableFilterComposer,
      $$WeekClosesTableOrderingComposer,
      $$WeekClosesTableAnnotationComposer,
      $$WeekClosesTableCreateCompanionBuilder,
      $$WeekClosesTableUpdateCompanionBuilder,
      (WeekClose, BaseReferences<_$AppDatabase, $WeekClosesTable, WeekClose>),
      WeekClose,
      PrefetchHooks Function()
    >;
typedef $$InboxItemsTableCreateCompanionBuilder = InboxItemsCompanion Function({
  required String id,
  required String smsKey,
  required String sender,
  required String body,
  required DateTime receivedAt,
  required String kind,
  required int amountMinor,
  required String currency,
  Value<String?> merchant,
  required String suggestedCategory,
  Value<String> status,
  Value<String?> txnId,
  Value<int> rowid,
});
typedef $$InboxItemsTableUpdateCompanionBuilder = InboxItemsCompanion Function({
  Value<String> id,
  Value<String> smsKey,
  Value<String> sender,
  Value<String> body,
  Value<DateTime> receivedAt,
  Value<String> kind,
  Value<int> amountMinor,
  Value<String> currency,
  Value<String?> merchant,
  Value<String> suggestedCategory,
  Value<String> status,
  Value<String?> txnId,
  Value<int> rowid,
});

class $$InboxItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InboxItemsTable> {
  $$InboxItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsKey => $composableBuilder(
    column: $table.smsKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suggestedCategory => $composableBuilder(
    column: $table.suggestedCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get txnId => $composableBuilder(
    column: $table.txnId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InboxItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InboxItemsTable> {
  $$InboxItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsKey => $composableBuilder(
    column: $table.smsKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suggestedCategory => $composableBuilder(
    column: $table.suggestedCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get txnId => $composableBuilder(
    column: $table.txnId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InboxItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InboxItemsTable> {
  $$InboxItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get smsKey =>
      $composableBuilder(column: $table.smsKey, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<String> get suggestedCategory => $composableBuilder(
    column: $table.suggestedCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get txnId =>
      $composableBuilder(column: $table.txnId, builder: (column) => column);
}

class $$InboxItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InboxItemsTable,
          InboxItem,
          $$InboxItemsTableFilterComposer,
          $$InboxItemsTableOrderingComposer,
          $$InboxItemsTableAnnotationComposer,
          $$InboxItemsTableCreateCompanionBuilder,
          $$InboxItemsTableUpdateCompanionBuilder,
          (
            InboxItem,
            BaseReferences<_$AppDatabase, $InboxItemsTable, InboxItem>,
          ),
          InboxItem,
          PrefetchHooks Function()
        > {
  $$InboxItemsTableTableManager(_$AppDatabase db, $InboxItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InboxItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InboxItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InboxItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> smsKey = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String> suggestedCategory = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> txnId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InboxItemsCompanion(
                id: id,
                smsKey: smsKey,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
                kind: kind,
                amountMinor: amountMinor,
                currency: currency,
                merchant: merchant,
                suggestedCategory: suggestedCategory,
                status: status,
                txnId: txnId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String smsKey,
                required String sender,
                required String body,
                required DateTime receivedAt,
                required String kind,
                required int amountMinor,
                required String currency,
                Value<String?> merchant = const Value.absent(),
                required String suggestedCategory,
                Value<String> status = const Value.absent(),
                Value<String?> txnId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InboxItemsCompanion.insert(
                id: id,
                smsKey: smsKey,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
                kind: kind,
                amountMinor: amountMinor,
                currency: currency,
                merchant: merchant,
                suggestedCategory: suggestedCategory,
                status: status,
                txnId: txnId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InboxItemsTable, InboxItem>(table),
                  BaseReferences<_$AppDatabase, $InboxItemsTable, InboxItem>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InboxItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InboxItemsTable,
      InboxItem,
      $$InboxItemsTableFilterComposer,
      $$InboxItemsTableOrderingComposer,
      $$InboxItemsTableAnnotationComposer,
      $$InboxItemsTableCreateCompanionBuilder,
      $$InboxItemsTableUpdateCompanionBuilder,
      (InboxItem, BaseReferences<_$AppDatabase, $InboxItemsTable, InboxItem>),
      InboxItem,
      PrefetchHooks Function()
    >;
typedef $$KeyValuesTableCreateCompanionBuilder = KeyValuesCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$KeyValuesTableUpdateCompanionBuilder = KeyValuesCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$KeyValuesTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValuesTable> {
  $$KeyValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KeyValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValuesTable,
          KeyValue,
          $$KeyValuesTableFilterComposer,
          $$KeyValuesTableOrderingComposer,
          $$KeyValuesTableAnnotationComposer,
          $$KeyValuesTableCreateCompanionBuilder,
          $$KeyValuesTableUpdateCompanionBuilder,
          (KeyValue, BaseReferences<_$AppDatabase, $KeyValuesTable, KeyValue>),
          KeyValue,
          PrefetchHooks Function()
        > {
  $$KeyValuesTableTableManager(_$AppDatabase db, $KeyValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => KeyValuesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => KeyValuesCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KeyValuesTable, KeyValue>(table),
                  BaseReferences<_$AppDatabase, $KeyValuesTable, KeyValue>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValuesTable,
      KeyValue,
      $$KeyValuesTableFilterComposer,
      $$KeyValuesTableOrderingComposer,
      $$KeyValuesTableAnnotationComposer,
      $$KeyValuesTableCreateCompanionBuilder,
      $$KeyValuesTableUpdateCompanionBuilder,
      (KeyValue, BaseReferences<_$AppDatabase, $KeyValuesTable, KeyValue>),
      KeyValue,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HouseholdsTableTableManager get households =>
      $$HouseholdsTableTableManager(_db, _db.households);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$WalletsTableTableManager get wallets =>
      $$WalletsTableTableManager(_db, _db.wallets);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$EnvelopesTableTableManager get envelopes =>
      $$EnvelopesTableTableManager(_db, _db.envelopes);
  $$TxnsTableTableManager get txns => $$TxnsTableTableManager(_db, _db.txns);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$RoscasTableTableManager get roscas =>
      $$RoscasTableTableManager(_db, _db.roscas);
  $$KidProfilesTableTableManager get kidProfiles =>
      $$KidProfilesTableTableManager(_db, _db.kidProfiles);
  $$KidEntriesTableTableManager get kidEntries =>
      $$KidEntriesTableTableManager(_db, _db.kidEntries);
  $$WeekClosesTableTableManager get weekCloses =>
      $$WeekClosesTableTableManager(_db, _db.weekCloses);
  $$InboxItemsTableTableManager get inboxItems =>
      $$InboxItemsTableTableManager(_db, _db.inboxItems);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db, _db.keyValues);
}
