// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserCredentialsTable extends UserCredentials
    with TableInfo<$UserCredentialsTable, UserCredential> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCredentialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaCodeMeta = const VerificationMeta(
    'areaCode',
  );
  @override
  late final GeneratedColumn<String> areaCode = GeneratedColumn<String>(
    'area_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('+86'),
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loginTypeMeta = const VerificationMeta(
    'loginType',
  );
  @override
  late final GeneratedColumn<int> loginType = GeneratedColumn<int>(
    'login_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _loginAccountMeta = const VerificationMeta(
    'loginAccount',
  );
  @override
  late final GeneratedColumn<String> loginAccount = GeneratedColumn<String>(
    'login_account',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverHostMeta = const VerificationMeta(
    'serverHost',
  );
  @override
  late final GeneratedColumn<String> serverHost = GeneratedColumn<String>(
    'server_host',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverPortMeta = const VerificationMeta(
    'serverPort',
  );
  @override
  late final GeneratedColumn<String> serverPort = GeneratedColumn<String>(
    'server_port',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverConfigMeta = const VerificationMeta(
    'serverConfig',
  );
  @override
  late final GeneratedColumn<String> serverConfig = GeneratedColumn<String>(
    'server_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    token,
    areaCode,
    phoneNumber,
    loginType,
    loginAccount,
    serverHost,
    serverPort,
    serverConfig,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_credentials';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserCredential> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('area_code')) {
      context.handle(
        _areaCodeMeta,
        areaCode.isAcceptableOrUnknown(data['area_code']!, _areaCodeMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('login_type')) {
      context.handle(
        _loginTypeMeta,
        loginType.isAcceptableOrUnknown(data['login_type']!, _loginTypeMeta),
      );
    }
    if (data.containsKey('login_account')) {
      context.handle(
        _loginAccountMeta,
        loginAccount.isAcceptableOrUnknown(
          data['login_account']!,
          _loginAccountMeta,
        ),
      );
    }
    if (data.containsKey('server_host')) {
      context.handle(
        _serverHostMeta,
        serverHost.isAcceptableOrUnknown(data['server_host']!, _serverHostMeta),
      );
    }
    if (data.containsKey('server_port')) {
      context.handle(
        _serverPortMeta,
        serverPort.isAcceptableOrUnknown(data['server_port']!, _serverPortMeta),
      );
    }
    if (data.containsKey('server_config')) {
      context.handle(
        _serverConfigMeta,
        serverConfig.isAcceptableOrUnknown(
          data['server_config']!,
          _serverConfigMeta,
        ),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserCredential map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCredential(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      areaCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area_code'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      loginType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}login_type'],
      )!,
      loginAccount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login_account'],
      ),
      serverHost: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_host'],
      ),
      serverPort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_port'],
      ),
      serverConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_config'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserCredentialsTable createAlias(String alias) {
    return $UserCredentialsTable(attachedDatabase, alias);
  }
}

class UserCredential extends DataClass implements Insertable<UserCredential> {
  final int id;
  final String userId;
  final String token;
  final String areaCode;
  final String? phoneNumber;
  final int loginType;
  final String? loginAccount;
  final String? serverHost;
  final String? serverPort;
  final String? serverConfig;
  final int createdAt;
  final int updatedAt;
  const UserCredential({
    required this.id,
    required this.userId,
    required this.token,
    required this.areaCode,
    this.phoneNumber,
    required this.loginType,
    this.loginAccount,
    this.serverHost,
    this.serverPort,
    this.serverConfig,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['token'] = Variable<String>(token);
    map['area_code'] = Variable<String>(areaCode);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['login_type'] = Variable<int>(loginType);
    if (!nullToAbsent || loginAccount != null) {
      map['login_account'] = Variable<String>(loginAccount);
    }
    if (!nullToAbsent || serverHost != null) {
      map['server_host'] = Variable<String>(serverHost);
    }
    if (!nullToAbsent || serverPort != null) {
      map['server_port'] = Variable<String>(serverPort);
    }
    if (!nullToAbsent || serverConfig != null) {
      map['server_config'] = Variable<String>(serverConfig);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  UserCredentialsCompanion toCompanion(bool nullToAbsent) {
    return UserCredentialsCompanion(
      id: Value(id),
      userId: Value(userId),
      token: Value(token),
      areaCode: Value(areaCode),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      loginType: Value(loginType),
      loginAccount: loginAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(loginAccount),
      serverHost: serverHost == null && nullToAbsent
          ? const Value.absent()
          : Value(serverHost),
      serverPort: serverPort == null && nullToAbsent
          ? const Value.absent()
          : Value(serverPort),
      serverConfig: serverConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(serverConfig),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserCredential.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCredential(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      token: serializer.fromJson<String>(json['token']),
      areaCode: serializer.fromJson<String>(json['areaCode']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      loginType: serializer.fromJson<int>(json['loginType']),
      loginAccount: serializer.fromJson<String?>(json['loginAccount']),
      serverHost: serializer.fromJson<String?>(json['serverHost']),
      serverPort: serializer.fromJson<String?>(json['serverPort']),
      serverConfig: serializer.fromJson<String?>(json['serverConfig']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'token': serializer.toJson<String>(token),
      'areaCode': serializer.toJson<String>(areaCode),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'loginType': serializer.toJson<int>(loginType),
      'loginAccount': serializer.toJson<String?>(loginAccount),
      'serverHost': serializer.toJson<String?>(serverHost),
      'serverPort': serializer.toJson<String?>(serverPort),
      'serverConfig': serializer.toJson<String?>(serverConfig),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  UserCredential copyWith({
    int? id,
    String? userId,
    String? token,
    String? areaCode,
    Value<String?> phoneNumber = const Value.absent(),
    int? loginType,
    Value<String?> loginAccount = const Value.absent(),
    Value<String?> serverHost = const Value.absent(),
    Value<String?> serverPort = const Value.absent(),
    Value<String?> serverConfig = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => UserCredential(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    token: token ?? this.token,
    areaCode: areaCode ?? this.areaCode,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    loginType: loginType ?? this.loginType,
    loginAccount: loginAccount.present ? loginAccount.value : this.loginAccount,
    serverHost: serverHost.present ? serverHost.value : this.serverHost,
    serverPort: serverPort.present ? serverPort.value : this.serverPort,
    serverConfig: serverConfig.present ? serverConfig.value : this.serverConfig,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserCredential copyWithCompanion(UserCredentialsCompanion data) {
    return UserCredential(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      token: data.token.present ? data.token.value : this.token,
      areaCode: data.areaCode.present ? data.areaCode.value : this.areaCode,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      loginType: data.loginType.present ? data.loginType.value : this.loginType,
      loginAccount: data.loginAccount.present
          ? data.loginAccount.value
          : this.loginAccount,
      serverHost: data.serverHost.present
          ? data.serverHost.value
          : this.serverHost,
      serverPort: data.serverPort.present
          ? data.serverPort.value
          : this.serverPort,
      serverConfig: data.serverConfig.present
          ? data.serverConfig.value
          : this.serverConfig,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCredential(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('areaCode: $areaCode, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('loginType: $loginType, ')
          ..write('loginAccount: $loginAccount, ')
          ..write('serverHost: $serverHost, ')
          ..write('serverPort: $serverPort, ')
          ..write('serverConfig: $serverConfig, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    token,
    areaCode,
    phoneNumber,
    loginType,
    loginAccount,
    serverHost,
    serverPort,
    serverConfig,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCredential &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.token == this.token &&
          other.areaCode == this.areaCode &&
          other.phoneNumber == this.phoneNumber &&
          other.loginType == this.loginType &&
          other.loginAccount == this.loginAccount &&
          other.serverHost == this.serverHost &&
          other.serverPort == this.serverPort &&
          other.serverConfig == this.serverConfig &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserCredentialsCompanion extends UpdateCompanion<UserCredential> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> token;
  final Value<String> areaCode;
  final Value<String?> phoneNumber;
  final Value<int> loginType;
  final Value<String?> loginAccount;
  final Value<String?> serverHost;
  final Value<String?> serverPort;
  final Value<String?> serverConfig;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const UserCredentialsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.token = const Value.absent(),
    this.areaCode = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.loginType = const Value.absent(),
    this.loginAccount = const Value.absent(),
    this.serverHost = const Value.absent(),
    this.serverPort = const Value.absent(),
    this.serverConfig = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserCredentialsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String token,
    this.areaCode = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.loginType = const Value.absent(),
    this.loginAccount = const Value.absent(),
    this.serverHost = const Value.absent(),
    this.serverPort = const Value.absent(),
    this.serverConfig = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : userId = Value(userId),
       token = Value(token),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserCredential> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? token,
    Expression<String>? areaCode,
    Expression<String>? phoneNumber,
    Expression<int>? loginType,
    Expression<String>? loginAccount,
    Expression<String>? serverHost,
    Expression<String>? serverPort,
    Expression<String>? serverConfig,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (token != null) 'token': token,
      if (areaCode != null) 'area_code': areaCode,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (loginType != null) 'login_type': loginType,
      if (loginAccount != null) 'login_account': loginAccount,
      if (serverHost != null) 'server_host': serverHost,
      if (serverPort != null) 'server_port': serverPort,
      if (serverConfig != null) 'server_config': serverConfig,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserCredentialsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? token,
    Value<String>? areaCode,
    Value<String?>? phoneNumber,
    Value<int>? loginType,
    Value<String?>? loginAccount,
    Value<String?>? serverHost,
    Value<String?>? serverPort,
    Value<String?>? serverConfig,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return UserCredentialsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      areaCode: areaCode ?? this.areaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      loginType: loginType ?? this.loginType,
      loginAccount: loginAccount ?? this.loginAccount,
      serverHost: serverHost ?? this.serverHost,
      serverPort: serverPort ?? this.serverPort,
      serverConfig: serverConfig ?? this.serverConfig,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (areaCode.present) {
      map['area_code'] = Variable<String>(areaCode.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (loginType.present) {
      map['login_type'] = Variable<int>(loginType.value);
    }
    if (loginAccount.present) {
      map['login_account'] = Variable<String>(loginAccount.value);
    }
    if (serverHost.present) {
      map['server_host'] = Variable<String>(serverHost.value);
    }
    if (serverPort.present) {
      map['server_port'] = Variable<String>(serverPort.value);
    }
    if (serverConfig.present) {
      map['server_config'] = Variable<String>(serverConfig.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCredentialsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('areaCode: $areaCode, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('loginType: $loginType, ')
          ..write('loginAccount: $loginAccount, ')
          ..write('serverHost: $serverHost, ')
          ..write('serverPort: $serverPort, ')
          ..write('serverConfig: $serverConfig, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exMeta = const VerificationMeta('ex');
  @override
  late final GeneratedColumn<String> ex = GeneratedColumn<String>(
    'ex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSelfMeta = const VerificationMeta('isSelf');
  @override
  late final GeneratedColumn<bool> isSelf = GeneratedColumn<bool>(
    'is_self',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_self" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    name,
    remark,
    email,
    avatarUrl,
    ex,
    isSelf,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('ex')) {
      context.handle(_exMeta, ex.isAcceptableOrUnknown(data['ex']!, _exMeta));
    }
    if (data.containsKey('is_self')) {
      context.handle(
        _isSelfMeta,
        isSelf.isAcceptableOrUnknown(data['is_self']!, _isSelfMeta),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      ex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ex'],
      ),
      isSelf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_self'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String userId;
  final String? name;
  final String? remark;
  final String? email;
  final String? avatarUrl;
  final String? ex;
  final bool isSelf;
  final int createdAt;
  final int updatedAt;
  const UserProfile({
    required this.userId,
    this.name,
    this.remark,
    this.email,
    this.avatarUrl,
    this.ex,
    required this.isSelf,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || ex != null) {
      map['ex'] = Variable<String>(ex);
    }
    map['is_self'] = Variable<bool>(isSelf);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      userId: Value(userId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      remark: remark == null && nullToAbsent
          ? const Value.absent()
          : Value(remark),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      ex: ex == null && nullToAbsent ? const Value.absent() : Value(ex),
      isSelf: Value(isSelf),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String?>(json['name']),
      remark: serializer.fromJson<String?>(json['remark']),
      email: serializer.fromJson<String?>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      ex: serializer.fromJson<String?>(json['ex']),
      isSelf: serializer.fromJson<bool>(json['isSelf']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String?>(name),
      'remark': serializer.toJson<String?>(remark),
      'email': serializer.toJson<String?>(email),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'ex': serializer.toJson<String?>(ex),
      'isSelf': serializer.toJson<bool>(isSelf),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  UserProfile copyWith({
    String? userId,
    Value<String?> name = const Value.absent(),
    Value<String?> remark = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> ex = const Value.absent(),
    bool? isSelf,
    int? createdAt,
    int? updatedAt,
  }) => UserProfile(
    userId: userId ?? this.userId,
    name: name.present ? name.value : this.name,
    remark: remark.present ? remark.value : this.remark,
    email: email.present ? email.value : this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    ex: ex.present ? ex.value : this.ex,
    isSelf: isSelf ?? this.isSelf,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      remark: data.remark.present ? data.remark.value : this.remark,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      ex: data.ex.present ? data.ex.value : this.ex,
      isSelf: data.isSelf.present ? data.isSelf.value : this.isSelf,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('remark: $remark, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('ex: $ex, ')
          ..write('isSelf: $isSelf, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    name,
    remark,
    email,
    avatarUrl,
    ex,
    isSelf,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.remark == this.remark &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.ex == this.ex &&
          other.isSelf == this.isSelf &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> userId;
  final Value<String?> name;
  final Value<String?> remark;
  final Value<String?> email;
  final Value<String?> avatarUrl;
  final Value<String?> ex;
  final Value<bool> isSelf;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.remark = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.ex = const Value.absent(),
    this.isSelf = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String userId,
    this.name = const Value.absent(),
    this.remark = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.ex = const Value.absent(),
    this.isSelf = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfile> custom({
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? remark,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<String>? ex,
    Expression<bool>? isSelf,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (remark != null) 'remark': remark,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (ex != null) 'ex': ex,
      if (isSelf != null) 'is_self': isSelf,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? userId,
    Value<String?>? name,
    Value<String?>? remark,
    Value<String?>? email,
    Value<String?>? avatarUrl,
    Value<String?>? ex,
    Value<bool>? isSelf,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      remark: remark ?? this.remark,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      ex: ex ?? this.ex,
      isSelf: isSelf ?? this.isSelf,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (ex.present) {
      map['ex'] = Variable<String>(ex.value);
    }
    if (isSelf.present) {
      map['is_self'] = Variable<bool>(isSelf.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('remark: $remark, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('ex: $ex, ')
          ..write('isSelf: $isSelf, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMsgMeta = const VerificationMeta(
    'lastMsg',
  );
  @override
  late final GeneratedColumn<String> lastMsg = GeneratedColumn<String>(
    'last_msg',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMsgTimeMeta = const VerificationMeta(
    'lastMsgTime',
  );
  @override
  late final GeneratedColumn<int> lastMsgTime = GeneratedColumn<int>(
    'last_msg_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isTopMeta = const VerificationMeta('isTop');
  @override
  late final GeneratedColumn<bool> isTop = GeneratedColumn<bool>(
    'is_top',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_top" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    conversationId,
    type,
    title,
    avatarUrl,
    lastMsg,
    lastMsgTime,
    unreadCount,
    isTop,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Conversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('last_msg')) {
      context.handle(
        _lastMsgMeta,
        lastMsg.isAcceptableOrUnknown(data['last_msg']!, _lastMsgMeta),
      );
    }
    if (data.containsKey('last_msg_time')) {
      context.handle(
        _lastMsgTimeMeta,
        lastMsgTime.isAcceptableOrUnknown(
          data['last_msg_time']!,
          _lastMsgTimeMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('is_top')) {
      context.handle(
        _isTopMeta,
        isTop.isAcceptableOrUnknown(data['is_top']!, _isTopMeta),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      lastMsg: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_msg'],
      ),
      lastMsgTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_msg_time'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      isTop: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_top'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String conversationId;
  final int type;
  final String? title;
  final String? avatarUrl;
  final String? lastMsg;
  final int? lastMsgTime;
  final int unreadCount;
  final bool isTop;
  final int createdAt;
  final int updatedAt;
  const Conversation({
    required this.conversationId,
    required this.type,
    this.title,
    this.avatarUrl,
    this.lastMsg,
    this.lastMsgTime,
    required this.unreadCount,
    required this.isTop,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<String>(conversationId);
    map['type'] = Variable<int>(type);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || lastMsg != null) {
      map['last_msg'] = Variable<String>(lastMsg);
    }
    if (!nullToAbsent || lastMsgTime != null) {
      map['last_msg_time'] = Variable<int>(lastMsgTime);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_top'] = Variable<bool>(isTop);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      conversationId: Value(conversationId),
      type: Value(type),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      lastMsg: lastMsg == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMsg),
      lastMsgTime: lastMsgTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMsgTime),
      unreadCount: Value(unreadCount),
      isTop: Value(isTop),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      conversationId: serializer.fromJson<String>(json['conversationId']),
      type: serializer.fromJson<int>(json['type']),
      title: serializer.fromJson<String?>(json['title']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      lastMsg: serializer.fromJson<String?>(json['lastMsg']),
      lastMsgTime: serializer.fromJson<int?>(json['lastMsgTime']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isTop: serializer.fromJson<bool>(json['isTop']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<String>(conversationId),
      'type': serializer.toJson<int>(type),
      'title': serializer.toJson<String?>(title),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'lastMsg': serializer.toJson<String?>(lastMsg),
      'lastMsgTime': serializer.toJson<int?>(lastMsgTime),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isTop': serializer.toJson<bool>(isTop),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Conversation copyWith({
    String? conversationId,
    int? type,
    Value<String?> title = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> lastMsg = const Value.absent(),
    Value<int?> lastMsgTime = const Value.absent(),
    int? unreadCount,
    bool? isTop,
    int? createdAt,
    int? updatedAt,
  }) => Conversation(
    conversationId: conversationId ?? this.conversationId,
    type: type ?? this.type,
    title: title.present ? title.value : this.title,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    lastMsg: lastMsg.present ? lastMsg.value : this.lastMsg,
    lastMsgTime: lastMsgTime.present ? lastMsgTime.value : this.lastMsgTime,
    unreadCount: unreadCount ?? this.unreadCount,
    isTop: isTop ?? this.isTop,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      lastMsg: data.lastMsg.present ? data.lastMsg.value : this.lastMsg,
      lastMsgTime: data.lastMsgTime.present
          ? data.lastMsgTime.value
          : this.lastMsgTime,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      isTop: data.isTop.present ? data.isTop.value : this.isTop,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastMsg: $lastMsg, ')
          ..write('lastMsgTime: $lastMsgTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isTop: $isTop, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    conversationId,
    type,
    title,
    avatarUrl,
    lastMsg,
    lastMsgTime,
    unreadCount,
    isTop,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.conversationId == this.conversationId &&
          other.type == this.type &&
          other.title == this.title &&
          other.avatarUrl == this.avatarUrl &&
          other.lastMsg == this.lastMsg &&
          other.lastMsgTime == this.lastMsgTime &&
          other.unreadCount == this.unreadCount &&
          other.isTop == this.isTop &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> conversationId;
  final Value<int> type;
  final Value<String?> title;
  final Value<String?> avatarUrl;
  final Value<String?> lastMsg;
  final Value<int?> lastMsgTime;
  final Value<int> unreadCount;
  final Value<bool> isTop;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.conversationId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.lastMsg = const Value.absent(),
    this.lastMsgTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isTop = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String conversationId,
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.lastMsg = const Value.absent(),
    this.lastMsgTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isTop = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : conversationId = Value(conversationId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Conversation> custom({
    Expression<String>? conversationId,
    Expression<int>? type,
    Expression<String>? title,
    Expression<String>? avatarUrl,
    Expression<String>? lastMsg,
    Expression<int>? lastMsgTime,
    Expression<int>? unreadCount,
    Expression<bool>? isTop,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (lastMsg != null) 'last_msg': lastMsg,
      if (lastMsgTime != null) 'last_msg_time': lastMsgTime,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isTop != null) 'is_top': isTop,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith({
    Value<String>? conversationId,
    Value<int>? type,
    Value<String?>? title,
    Value<String?>? avatarUrl,
    Value<String?>? lastMsg,
    Value<int?>? lastMsgTime,
    Value<int>? unreadCount,
    Value<bool>? isTop,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return ConversationsCompanion(
      conversationId: conversationId ?? this.conversationId,
      type: type ?? this.type,
      title: title ?? this.title,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMsg: lastMsg ?? this.lastMsg,
      lastMsgTime: lastMsgTime ?? this.lastMsgTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isTop: isTop ?? this.isTop,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (lastMsg.present) {
      map['last_msg'] = Variable<String>(lastMsg.value);
    }
    if (lastMsgTime.present) {
      map['last_msg_time'] = Variable<int>(lastMsgTime.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isTop.present) {
      map['is_top'] = Variable<bool>(isTop.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastMsg: $lastMsg, ')
          ..write('lastMsgTime: $lastMsgTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isTop: $isTop, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _msgIdMeta = const VerificationMeta('msgId');
  @override
  late final GeneratedColumn<String> msgId = GeneratedColumn<String>(
    'msg_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromUidMeta = const VerificationMeta(
    'fromUid',
  );
  @override
  late final GeneratedColumn<String> fromUid = GeneratedColumn<String>(
    'from_uid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toUidMeta = const VerificationMeta('toUid');
  @override
  late final GeneratedColumn<String> toUid = GeneratedColumn<String>(
    'to_uid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<int> contentType = GeneratedColumn<int>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sendTimeMeta = const VerificationMeta(
    'sendTime',
  );
  @override
  late final GeneratedColumn<int> sendTime = GeneratedColumn<int>(
    'send_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    msgId,
    conversationId,
    fromUid,
    toUid,
    content,
    contentType,
    status,
    sendTime,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('msg_id')) {
      context.handle(
        _msgIdMeta,
        msgId.isAcceptableOrUnknown(data['msg_id']!, _msgIdMeta),
      );
    } else if (isInserting) {
      context.missing(_msgIdMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('from_uid')) {
      context.handle(
        _fromUidMeta,
        fromUid.isAcceptableOrUnknown(data['from_uid']!, _fromUidMeta),
      );
    }
    if (data.containsKey('to_uid')) {
      context.handle(
        _toUidMeta,
        toUid.isAcceptableOrUnknown(data['to_uid']!, _toUidMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('send_time')) {
      context.handle(
        _sendTimeMeta,
        sendTime.isAcceptableOrUnknown(data['send_time']!, _sendTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_sendTimeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {msgId, conversationId};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      msgId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}msg_id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      fromUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_uid'],
      ),
      toUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_uid'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      sendTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}send_time'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String msgId;
  final String conversationId;
  final String? fromUid;
  final String? toUid;
  final String? content;
  final int contentType;
  final int status;
  final int sendTime;
  final int createdAt;
  const Message({
    required this.msgId,
    required this.conversationId,
    this.fromUid,
    this.toUid,
    this.content,
    required this.contentType,
    required this.status,
    required this.sendTime,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['msg_id'] = Variable<String>(msgId);
    map['conversation_id'] = Variable<String>(conversationId);
    if (!nullToAbsent || fromUid != null) {
      map['from_uid'] = Variable<String>(fromUid);
    }
    if (!nullToAbsent || toUid != null) {
      map['to_uid'] = Variable<String>(toUid);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['content_type'] = Variable<int>(contentType);
    map['status'] = Variable<int>(status);
    map['send_time'] = Variable<int>(sendTime);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      msgId: Value(msgId),
      conversationId: Value(conversationId),
      fromUid: fromUid == null && nullToAbsent
          ? const Value.absent()
          : Value(fromUid),
      toUid: toUid == null && nullToAbsent
          ? const Value.absent()
          : Value(toUid),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      contentType: Value(contentType),
      status: Value(status),
      sendTime: Value(sendTime),
      createdAt: Value(createdAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      msgId: serializer.fromJson<String>(json['msgId']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      fromUid: serializer.fromJson<String?>(json['fromUid']),
      toUid: serializer.fromJson<String?>(json['toUid']),
      content: serializer.fromJson<String?>(json['content']),
      contentType: serializer.fromJson<int>(json['contentType']),
      status: serializer.fromJson<int>(json['status']),
      sendTime: serializer.fromJson<int>(json['sendTime']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'msgId': serializer.toJson<String>(msgId),
      'conversationId': serializer.toJson<String>(conversationId),
      'fromUid': serializer.toJson<String?>(fromUid),
      'toUid': serializer.toJson<String?>(toUid),
      'content': serializer.toJson<String?>(content),
      'contentType': serializer.toJson<int>(contentType),
      'status': serializer.toJson<int>(status),
      'sendTime': serializer.toJson<int>(sendTime),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Message copyWith({
    String? msgId,
    String? conversationId,
    Value<String?> fromUid = const Value.absent(),
    Value<String?> toUid = const Value.absent(),
    Value<String?> content = const Value.absent(),
    int? contentType,
    int? status,
    int? sendTime,
    int? createdAt,
  }) => Message(
    msgId: msgId ?? this.msgId,
    conversationId: conversationId ?? this.conversationId,
    fromUid: fromUid.present ? fromUid.value : this.fromUid,
    toUid: toUid.present ? toUid.value : this.toUid,
    content: content.present ? content.value : this.content,
    contentType: contentType ?? this.contentType,
    status: status ?? this.status,
    sendTime: sendTime ?? this.sendTime,
    createdAt: createdAt ?? this.createdAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      msgId: data.msgId.present ? data.msgId.value : this.msgId,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      fromUid: data.fromUid.present ? data.fromUid.value : this.fromUid,
      toUid: data.toUid.present ? data.toUid.value : this.toUid,
      content: data.content.present ? data.content.value : this.content,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      status: data.status.present ? data.status.value : this.status,
      sendTime: data.sendTime.present ? data.sendTime.value : this.sendTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('msgId: $msgId, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('status: $status, ')
          ..write('sendTime: $sendTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    msgId,
    conversationId,
    fromUid,
    toUid,
    content,
    contentType,
    status,
    sendTime,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.msgId == this.msgId &&
          other.conversationId == this.conversationId &&
          other.fromUid == this.fromUid &&
          other.toUid == this.toUid &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.status == this.status &&
          other.sendTime == this.sendTime &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> msgId;
  final Value<String> conversationId;
  final Value<String?> fromUid;
  final Value<String?> toUid;
  final Value<String?> content;
  final Value<int> contentType;
  final Value<int> status;
  final Value<int> sendTime;
  final Value<int> createdAt;
  final Value<int> rowid;
  const MessagesCompanion({
    this.msgId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.fromUid = const Value.absent(),
    this.toUid = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.status = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String msgId,
    required String conversationId,
    this.fromUid = const Value.absent(),
    this.toUid = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.status = const Value.absent(),
    required int sendTime,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : msgId = Value(msgId),
       conversationId = Value(conversationId),
       sendTime = Value(sendTime),
       createdAt = Value(createdAt);
  static Insertable<Message> custom({
    Expression<String>? msgId,
    Expression<String>? conversationId,
    Expression<String>? fromUid,
    Expression<String>? toUid,
    Expression<String>? content,
    Expression<int>? contentType,
    Expression<int>? status,
    Expression<int>? sendTime,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (msgId != null) 'msg_id': msgId,
      if (conversationId != null) 'conversation_id': conversationId,
      if (fromUid != null) 'from_uid': fromUid,
      if (toUid != null) 'to_uid': toUid,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (status != null) 'status': status,
      if (sendTime != null) 'send_time': sendTime,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? msgId,
    Value<String>? conversationId,
    Value<String?>? fromUid,
    Value<String?>? toUid,
    Value<String?>? content,
    Value<int>? contentType,
    Value<int>? status,
    Value<int>? sendTime,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      msgId: msgId ?? this.msgId,
      conversationId: conversationId ?? this.conversationId,
      fromUid: fromUid ?? this.fromUid,
      toUid: toUid ?? this.toUid,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      status: status ?? this.status,
      sendTime: sendTime ?? this.sendTime,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (msgId.present) {
      map['msg_id'] = Variable<String>(msgId.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (fromUid.present) {
      map['from_uid'] = Variable<String>(fromUid.value);
    }
    if (toUid.present) {
      map['to_uid'] = Variable<String>(toUid.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<int>(contentType.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (sendTime.present) {
      map['send_time'] = Variable<int>(sendTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('msgId: $msgId, ')
          ..write('conversationId: $conversationId, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('status: $status, ')
          ..write('sendTime: $sendTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: const Constant('我的好友'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<int> addedAt = GeneratedColumn<int>(
    'added_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    remark,
    groupName,
    status,
    source,
    addedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friends';
  @override
  VerificationContext validateIntegrity(
    Insertable<Friend> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Friend(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      ),
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}added_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(attachedDatabase, alias);
  }
}

class Friend extends DataClass implements Insertable<Friend> {
  final String userId;
  final String? remark;
  final String groupName;
  final int status;
  final String? source;
  final int? addedAt;
  final int createdAt;
  final int updatedAt;
  const Friend({
    required this.userId,
    this.remark,
    required this.groupName,
    required this.status,
    this.source,
    this.addedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    map['group_name'] = Variable<String>(groupName);
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || addedAt != null) {
      map['added_at'] = Variable<int>(addedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      userId: Value(userId),
      remark: remark == null && nullToAbsent
          ? const Value.absent()
          : Value(remark),
      groupName: Value(groupName),
      status: Value(status),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      addedAt: addedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(addedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Friend.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Friend(
      userId: serializer.fromJson<String>(json['userId']),
      remark: serializer.fromJson<String?>(json['remark']),
      groupName: serializer.fromJson<String>(json['groupName']),
      status: serializer.fromJson<int>(json['status']),
      source: serializer.fromJson<String?>(json['source']),
      addedAt: serializer.fromJson<int?>(json['addedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'remark': serializer.toJson<String?>(remark),
      'groupName': serializer.toJson<String>(groupName),
      'status': serializer.toJson<int>(status),
      'source': serializer.toJson<String?>(source),
      'addedAt': serializer.toJson<int?>(addedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Friend copyWith({
    String? userId,
    Value<String?> remark = const Value.absent(),
    String? groupName,
    int? status,
    Value<String?> source = const Value.absent(),
    Value<int?> addedAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => Friend(
    userId: userId ?? this.userId,
    remark: remark.present ? remark.value : this.remark,
    groupName: groupName ?? this.groupName,
    status: status ?? this.status,
    source: source.present ? source.value : this.source,
    addedAt: addedAt.present ? addedAt.value : this.addedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Friend copyWithCompanion(FriendsCompanion data) {
    return Friend(
      userId: data.userId.present ? data.userId.value : this.userId,
      remark: data.remark.present ? data.remark.value : this.remark,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('userId: $userId, ')
          ..write('remark: $remark, ')
          ..write('groupName: $groupName, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('addedAt: $addedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    remark,
    groupName,
    status,
    source,
    addedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.userId == this.userId &&
          other.remark == this.remark &&
          other.groupName == this.groupName &&
          other.status == this.status &&
          other.source == this.source &&
          other.addedAt == this.addedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<String> userId;
  final Value<String?> remark;
  final Value<String> groupName;
  final Value<int> status;
  final Value<String?> source;
  final Value<int?> addedAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const FriendsCompanion({
    this.userId = const Value.absent(),
    this.remark = const Value.absent(),
    this.groupName = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendsCompanion.insert({
    required String userId,
    this.remark = const Value.absent(),
    this.groupName = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.addedAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Friend> custom({
    Expression<String>? userId,
    Expression<String>? remark,
    Expression<String>? groupName,
    Expression<int>? status,
    Expression<String>? source,
    Expression<int>? addedAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (remark != null) 'remark': remark,
      if (groupName != null) 'group_name': groupName,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (addedAt != null) 'added_at': addedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendsCompanion copyWith({
    Value<String>? userId,
    Value<String?>? remark,
    Value<String>? groupName,
    Value<int>? status,
    Value<String?>? source,
    Value<int?>? addedAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return FriendsCompanion(
      userId: userId ?? this.userId,
      remark: remark ?? this.remark,
      groupName: groupName ?? this.groupName,
      status: status ?? this.status,
      source: source ?? this.source,
      addedAt: addedAt ?? this.addedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<int>(addedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('userId: $userId, ')
          ..write('remark: $remark, ')
          ..write('groupName: $groupName, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('addedAt: $addedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendRequestsTable extends FriendRequests
    with TableInfo<$FriendRequestsTable, FriendRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fromUidMeta = const VerificationMeta(
    'fromUid',
  );
  @override
  late final GeneratedColumn<String> fromUid = GeneratedColumn<String>(
    'from_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toUidMeta = const VerificationMeta('toUid');
  @override
  late final GeneratedColumn<String> toUid = GeneratedColumn<String>(
    'to_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _handledAtMeta = const VerificationMeta(
    'handledAt',
  );
  @override
  late final GeneratedColumn<int> handledAt = GeneratedColumn<int>(
    'handled_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromUid,
    toUid,
    message,
    status,
    handledAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<FriendRequest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_uid')) {
      context.handle(
        _fromUidMeta,
        fromUid.isAcceptableOrUnknown(data['from_uid']!, _fromUidMeta),
      );
    } else if (isInserting) {
      context.missing(_fromUidMeta);
    }
    if (data.containsKey('to_uid')) {
      context.handle(
        _toUidMeta,
        toUid.isAcceptableOrUnknown(data['to_uid']!, _toUidMeta),
      );
    } else if (isInserting) {
      context.missing(_toUidMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('handled_at')) {
      context.handle(
        _handledAtMeta,
        handledAt.isAcceptableOrUnknown(data['handled_at']!, _handledAtMeta),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendRequest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_uid'],
      )!,
      toUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_uid'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      handledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}handled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FriendRequestsTable createAlias(String alias) {
    return $FriendRequestsTable(attachedDatabase, alias);
  }
}

class FriendRequest extends DataClass implements Insertable<FriendRequest> {
  final int id;
  final String fromUid;
  final String toUid;
  final String? message;
  final int status;
  final int? handledAt;
  final int createdAt;
  final int updatedAt;
  const FriendRequest({
    required this.id,
    required this.fromUid,
    required this.toUid,
    this.message,
    required this.status,
    this.handledAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_uid'] = Variable<String>(fromUid);
    map['to_uid'] = Variable<String>(toUid);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || handledAt != null) {
      map['handled_at'] = Variable<int>(handledAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  FriendRequestsCompanion toCompanion(bool nullToAbsent) {
    return FriendRequestsCompanion(
      id: Value(id),
      fromUid: Value(fromUid),
      toUid: Value(toUid),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      status: Value(status),
      handledAt: handledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(handledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FriendRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendRequest(
      id: serializer.fromJson<int>(json['id']),
      fromUid: serializer.fromJson<String>(json['fromUid']),
      toUid: serializer.fromJson<String>(json['toUid']),
      message: serializer.fromJson<String?>(json['message']),
      status: serializer.fromJson<int>(json['status']),
      handledAt: serializer.fromJson<int?>(json['handledAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromUid': serializer.toJson<String>(fromUid),
      'toUid': serializer.toJson<String>(toUid),
      'message': serializer.toJson<String?>(message),
      'status': serializer.toJson<int>(status),
      'handledAt': serializer.toJson<int?>(handledAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  FriendRequest copyWith({
    int? id,
    String? fromUid,
    String? toUid,
    Value<String?> message = const Value.absent(),
    int? status,
    Value<int?> handledAt = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => FriendRequest(
    id: id ?? this.id,
    fromUid: fromUid ?? this.fromUid,
    toUid: toUid ?? this.toUid,
    message: message.present ? message.value : this.message,
    status: status ?? this.status,
    handledAt: handledAt.present ? handledAt.value : this.handledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FriendRequest copyWithCompanion(FriendRequestsCompanion data) {
    return FriendRequest(
      id: data.id.present ? data.id.value : this.id,
      fromUid: data.fromUid.present ? data.fromUid.value : this.fromUid,
      toUid: data.toUid.present ? data.toUid.value : this.toUid,
      message: data.message.present ? data.message.value : this.message,
      status: data.status.present ? data.status.value : this.status,
      handledAt: data.handledAt.present ? data.handledAt.value : this.handledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequest(')
          ..write('id: $id, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('handledAt: $handledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromUid,
    toUid,
    message,
    status,
    handledAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendRequest &&
          other.id == this.id &&
          other.fromUid == this.fromUid &&
          other.toUid == this.toUid &&
          other.message == this.message &&
          other.status == this.status &&
          other.handledAt == this.handledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FriendRequestsCompanion extends UpdateCompanion<FriendRequest> {
  final Value<int> id;
  final Value<String> fromUid;
  final Value<String> toUid;
  final Value<String?> message;
  final Value<int> status;
  final Value<int?> handledAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const FriendRequestsCompanion({
    this.id = const Value.absent(),
    this.fromUid = const Value.absent(),
    this.toUid = const Value.absent(),
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.handledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FriendRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String fromUid,
    required String toUid,
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.handledAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : fromUid = Value(fromUid),
       toUid = Value(toUid),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FriendRequest> custom({
    Expression<int>? id,
    Expression<String>? fromUid,
    Expression<String>? toUid,
    Expression<String>? message,
    Expression<int>? status,
    Expression<int>? handledAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromUid != null) 'from_uid': fromUid,
      if (toUid != null) 'to_uid': toUid,
      if (message != null) 'message': message,
      if (status != null) 'status': status,
      if (handledAt != null) 'handled_at': handledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FriendRequestsCompanion copyWith({
    Value<int>? id,
    Value<String>? fromUid,
    Value<String>? toUid,
    Value<String?>? message,
    Value<int>? status,
    Value<int?>? handledAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return FriendRequestsCompanion(
      id: id ?? this.id,
      fromUid: fromUid ?? this.fromUid,
      toUid: toUid ?? this.toUid,
      message: message ?? this.message,
      status: status ?? this.status,
      handledAt: handledAt ?? this.handledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromUid.present) {
      map['from_uid'] = Variable<String>(fromUid.value);
    }
    if (toUid.present) {
      map['to_uid'] = Variable<String>(toUid.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (handledAt.present) {
      map['handled_at'] = Variable<int>(handledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequestsCompanion(')
          ..write('id: $id, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('handledAt: $handledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
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
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
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
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
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

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
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
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
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

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
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
    return (StringBuffer('AppSettingsCompanion(')
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
  late final $UserCredentialsTable userCredentials = $UserCredentialsTable(
    this,
  );
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $FriendRequestsTable friendRequests = $FriendRequestsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final CredentialDao credentialDao = CredentialDao(this as AppDatabase);
  late final UserProfileDao userProfileDao = UserProfileDao(
    this as AppDatabase,
  );
  late final ConversationDao conversationDao = ConversationDao(
    this as AppDatabase,
  );
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final FriendDao friendDao = FriendDao(this as AppDatabase);
  late final FriendRequestDao friendRequestDao = FriendRequestDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userCredentials,
    userProfiles,
    conversations,
    messages,
    friends,
    friendRequests,
    appSettings,
  ];
}

typedef $$UserCredentialsTableCreateCompanionBuilder =
    UserCredentialsCompanion Function({
      Value<int> id,
      required String userId,
      required String token,
      Value<String> areaCode,
      Value<String?> phoneNumber,
      Value<int> loginType,
      Value<String?> loginAccount,
      Value<String?> serverHost,
      Value<String?> serverPort,
      Value<String?> serverConfig,
      required int createdAt,
      required int updatedAt,
    });
typedef $$UserCredentialsTableUpdateCompanionBuilder =
    UserCredentialsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> token,
      Value<String> areaCode,
      Value<String?> phoneNumber,
      Value<int> loginType,
      Value<String?> loginAccount,
      Value<String?> serverHost,
      Value<String?> serverPort,
      Value<String?> serverConfig,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

class $$UserCredentialsTableFilterComposer
    extends Composer<_$AppDatabase, $UserCredentialsTable> {
  $$UserCredentialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get areaCode => $composableBuilder(
    column: $table.areaCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get loginType => $composableBuilder(
    column: $table.loginType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginAccount => $composableBuilder(
    column: $table.loginAccount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverHost => $composableBuilder(
    column: $table.serverHost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverPort => $composableBuilder(
    column: $table.serverPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverConfig => $composableBuilder(
    column: $table.serverConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserCredentialsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCredentialsTable> {
  $$UserCredentialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get areaCode => $composableBuilder(
    column: $table.areaCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get loginType => $composableBuilder(
    column: $table.loginType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginAccount => $composableBuilder(
    column: $table.loginAccount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverHost => $composableBuilder(
    column: $table.serverHost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverPort => $composableBuilder(
    column: $table.serverPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverConfig => $composableBuilder(
    column: $table.serverConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserCredentialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCredentialsTable> {
  $$UserCredentialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get areaCode =>
      $composableBuilder(column: $table.areaCode, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get loginType =>
      $composableBuilder(column: $table.loginType, builder: (column) => column);

  GeneratedColumn<String> get loginAccount => $composableBuilder(
    column: $table.loginAccount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverHost => $composableBuilder(
    column: $table.serverHost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverPort => $composableBuilder(
    column: $table.serverPort,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverConfig => $composableBuilder(
    column: $table.serverConfig,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserCredentialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserCredentialsTable,
          UserCredential,
          $$UserCredentialsTableFilterComposer,
          $$UserCredentialsTableOrderingComposer,
          $$UserCredentialsTableAnnotationComposer,
          $$UserCredentialsTableCreateCompanionBuilder,
          $$UserCredentialsTableUpdateCompanionBuilder,
          (
            UserCredential,
            BaseReferences<
              _$AppDatabase,
              $UserCredentialsTable,
              UserCredential
            >,
          ),
          UserCredential,
          PrefetchHooks Function()
        > {
  $$UserCredentialsTableTableManager(
    _$AppDatabase db,
    $UserCredentialsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCredentialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCredentialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCredentialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> token = const Value.absent(),
                Value<String> areaCode = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<int> loginType = const Value.absent(),
                Value<String?> loginAccount = const Value.absent(),
                Value<String?> serverHost = const Value.absent(),
                Value<String?> serverPort = const Value.absent(),
                Value<String?> serverConfig = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => UserCredentialsCompanion(
                id: id,
                userId: userId,
                token: token,
                areaCode: areaCode,
                phoneNumber: phoneNumber,
                loginType: loginType,
                loginAccount: loginAccount,
                serverHost: serverHost,
                serverPort: serverPort,
                serverConfig: serverConfig,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String token,
                Value<String> areaCode = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<int> loginType = const Value.absent(),
                Value<String?> loginAccount = const Value.absent(),
                Value<String?> serverHost = const Value.absent(),
                Value<String?> serverPort = const Value.absent(),
                Value<String?> serverConfig = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => UserCredentialsCompanion.insert(
                id: id,
                userId: userId,
                token: token,
                areaCode: areaCode,
                phoneNumber: phoneNumber,
                loginType: loginType,
                loginAccount: loginAccount,
                serverHost: serverHost,
                serverPort: serverPort,
                serverConfig: serverConfig,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserCredentialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserCredentialsTable,
      UserCredential,
      $$UserCredentialsTableFilterComposer,
      $$UserCredentialsTableOrderingComposer,
      $$UserCredentialsTableAnnotationComposer,
      $$UserCredentialsTableCreateCompanionBuilder,
      $$UserCredentialsTableUpdateCompanionBuilder,
      (
        UserCredential,
        BaseReferences<_$AppDatabase, $UserCredentialsTable, UserCredential>,
      ),
      UserCredential,
      PrefetchHooks Function()
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String userId,
      Value<String?> name,
      Value<String?> remark,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> ex,
      Value<bool> isSelf,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> userId,
      Value<String?> name,
      Value<String?> remark,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> ex,
      Value<bool> isSelf,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ex => $composableBuilder(
    column: $table.ex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelf => $composableBuilder(
    column: $table.isSelf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ex => $composableBuilder(
    column: $table.ex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelf => $composableBuilder(
    column: $table.isSelf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get ex =>
      $composableBuilder(column: $table.ex, builder: (column) => column);

  GeneratedColumn<bool> get isSelf =>
      $composableBuilder(column: $table.isSelf, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> ex = const Value.absent(),
                Value<bool> isSelf = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                userId: userId,
                name: name,
                remark: remark,
                email: email,
                avatarUrl: avatarUrl,
                ex: ex,
                isSelf: isSelf,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<String?> name = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> ex = const Value.absent(),
                Value<bool> isSelf = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                userId: userId,
                name: name,
                remark: remark,
                email: email,
                avatarUrl: avatarUrl,
                ex: ex,
                isSelf: isSelf,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({
      required String conversationId,
      Value<int> type,
      Value<String?> title,
      Value<String?> avatarUrl,
      Value<String?> lastMsg,
      Value<int?> lastMsgTime,
      Value<int> unreadCount,
      Value<bool> isTop,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({
      Value<String> conversationId,
      Value<int> type,
      Value<String?> title,
      Value<String?> avatarUrl,
      Value<String?> lastMsg,
      Value<int?> lastMsgTime,
      Value<int> unreadCount,
      Value<bool> isTop,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMsg => $composableBuilder(
    column: $table.lastMsg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastMsgTime => $composableBuilder(
    column: $table.lastMsgTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTop => $composableBuilder(
    column: $table.isTop,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMsg => $composableBuilder(
    column: $table.lastMsg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastMsgTime => $composableBuilder(
    column: $table.lastMsgTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTop => $composableBuilder(
    column: $table.isTop,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get lastMsg =>
      $composableBuilder(column: $table.lastMsg, builder: (column) => column);

  GeneratedColumn<int> get lastMsgTime => $composableBuilder(
    column: $table.lastMsgTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTop =>
      $composableBuilder(column: $table.isTop, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConversationsTable,
          Conversation,
          $$ConversationsTableFilterComposer,
          $$ConversationsTableOrderingComposer,
          $$ConversationsTableAnnotationComposer,
          $$ConversationsTableCreateCompanionBuilder,
          $$ConversationsTableUpdateCompanionBuilder,
          (
            Conversation,
            BaseReferences<_$AppDatabase, $ConversationsTable, Conversation>,
          ),
          Conversation,
          PrefetchHooks Function()
        > {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> conversationId = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> lastMsg = const Value.absent(),
                Value<int?> lastMsgTime = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isTop = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion(
                conversationId: conversationId,
                type: type,
                title: title,
                avatarUrl: avatarUrl,
                lastMsg: lastMsg,
                lastMsgTime: lastMsgTime,
                unreadCount: unreadCount,
                isTop: isTop,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String conversationId,
                Value<int> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> lastMsg = const Value.absent(),
                Value<int?> lastMsgTime = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isTop = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion.insert(
                conversationId: conversationId,
                type: type,
                title: title,
                avatarUrl: avatarUrl,
                lastMsg: lastMsg,
                lastMsgTime: lastMsgTime,
                unreadCount: unreadCount,
                isTop: isTop,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConversationsTable,
      Conversation,
      $$ConversationsTableFilterComposer,
      $$ConversationsTableOrderingComposer,
      $$ConversationsTableAnnotationComposer,
      $$ConversationsTableCreateCompanionBuilder,
      $$ConversationsTableUpdateCompanionBuilder,
      (
        Conversation,
        BaseReferences<_$AppDatabase, $ConversationsTable, Conversation>,
      ),
      Conversation,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String msgId,
      required String conversationId,
      Value<String?> fromUid,
      Value<String?> toUid,
      Value<String?> content,
      Value<int> contentType,
      Value<int> status,
      required int sendTime,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> msgId,
      Value<String> conversationId,
      Value<String?> fromUid,
      Value<String?> toUid,
      Value<String?> content,
      Value<int> contentType,
      Value<int> status,
      Value<int> sendTime,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get msgId => $composableBuilder(
    column: $table.msgId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sendTime => $composableBuilder(
    column: $table.sendTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get msgId => $composableBuilder(
    column: $table.msgId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sendTime => $composableBuilder(
    column: $table.sendTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get msgId =>
      $composableBuilder(column: $table.msgId, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fromUid =>
      $composableBuilder(column: $table.fromUid, builder: (column) => column);

  GeneratedColumn<String> get toUid =>
      $composableBuilder(column: $table.toUid, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get sendTime =>
      $composableBuilder(column: $table.sendTime, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> msgId = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String?> fromUid = const Value.absent(),
                Value<String?> toUid = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<int> contentType = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int> sendTime = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                msgId: msgId,
                conversationId: conversationId,
                fromUid: fromUid,
                toUid: toUid,
                content: content,
                contentType: contentType,
                status: status,
                sendTime: sendTime,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String msgId,
                required String conversationId,
                Value<String?> fromUid = const Value.absent(),
                Value<String?> toUid = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<int> contentType = const Value.absent(),
                Value<int> status = const Value.absent(),
                required int sendTime,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                msgId: msgId,
                conversationId: conversationId,
                fromUid: fromUid,
                toUid: toUid,
                content: content,
                contentType: contentType,
                status: status,
                sendTime: sendTime,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$FriendsTableCreateCompanionBuilder =
    FriendsCompanion Function({
      required String userId,
      Value<String?> remark,
      Value<String> groupName,
      Value<int> status,
      Value<String?> source,
      Value<int?> addedAt,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$FriendsTableUpdateCompanionBuilder =
    FriendsCompanion Function({
      Value<String> userId,
      Value<String?> remark,
      Value<String> groupName,
      Value<int> status,
      Value<String?> source,
      Value<int?> addedAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$FriendsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FriendsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FriendsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FriendsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FriendsTable,
          Friend,
          $$FriendsTableFilterComposer,
          $$FriendsTableOrderingComposer,
          $$FriendsTableAnnotationComposer,
          $$FriendsTableCreateCompanionBuilder,
          $$FriendsTableUpdateCompanionBuilder,
          (Friend, BaseReferences<_$AppDatabase, $FriendsTable, Friend>),
          Friend,
          PrefetchHooks Function()
        > {
  $$FriendsTableTableManager(_$AppDatabase db, $FriendsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int?> addedAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FriendsCompanion(
                userId: userId,
                remark: remark,
                groupName: groupName,
                status: status,
                source: source,
                addedAt: addedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<String?> remark = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int?> addedAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FriendsCompanion.insert(
                userId: userId,
                remark: remark,
                groupName: groupName,
                status: status,
                source: source,
                addedAt: addedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FriendsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FriendsTable,
      Friend,
      $$FriendsTableFilterComposer,
      $$FriendsTableOrderingComposer,
      $$FriendsTableAnnotationComposer,
      $$FriendsTableCreateCompanionBuilder,
      $$FriendsTableUpdateCompanionBuilder,
      (Friend, BaseReferences<_$AppDatabase, $FriendsTable, Friend>),
      Friend,
      PrefetchHooks Function()
    >;
typedef $$FriendRequestsTableCreateCompanionBuilder =
    FriendRequestsCompanion Function({
      Value<int> id,
      required String fromUid,
      required String toUid,
      Value<String?> message,
      Value<int> status,
      Value<int?> handledAt,
      required int createdAt,
      required int updatedAt,
    });
typedef $$FriendRequestsTableUpdateCompanionBuilder =
    FriendRequestsCompanion Function({
      Value<int> id,
      Value<String> fromUid,
      Value<String> toUid,
      Value<String?> message,
      Value<int> status,
      Value<int?> handledAt,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

class $$FriendRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get handledAt => $composableBuilder(
    column: $table.handledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FriendRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get handledAt => $composableBuilder(
    column: $table.handledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FriendRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromUid =>
      $composableBuilder(column: $table.fromUid, builder: (column) => column);

  GeneratedColumn<String> get toUid =>
      $composableBuilder(column: $table.toUid, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get handledAt =>
      $composableBuilder(column: $table.handledAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FriendRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FriendRequestsTable,
          FriendRequest,
          $$FriendRequestsTableFilterComposer,
          $$FriendRequestsTableOrderingComposer,
          $$FriendRequestsTableAnnotationComposer,
          $$FriendRequestsTableCreateCompanionBuilder,
          $$FriendRequestsTableUpdateCompanionBuilder,
          (
            FriendRequest,
            BaseReferences<_$AppDatabase, $FriendRequestsTable, FriendRequest>,
          ),
          FriendRequest,
          PrefetchHooks Function()
        > {
  $$FriendRequestsTableTableManager(
    _$AppDatabase db,
    $FriendRequestsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fromUid = const Value.absent(),
                Value<String> toUid = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int?> handledAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => FriendRequestsCompanion(
                id: id,
                fromUid: fromUid,
                toUid: toUid,
                message: message,
                status: status,
                handledAt: handledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fromUid,
                required String toUid,
                Value<String?> message = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int?> handledAt = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => FriendRequestsCompanion.insert(
                id: id,
                fromUid: fromUid,
                toUid: toUid,
                message: message,
                status: status,
                handledAt: handledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FriendRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FriendRequestsTable,
      FriendRequest,
      $$FriendRequestsTableFilterComposer,
      $$FriendRequestsTableOrderingComposer,
      $$FriendRequestsTableAnnotationComposer,
      $$FriendRequestsTableCreateCompanionBuilder,
      $$FriendRequestsTableUpdateCompanionBuilder,
      (
        FriendRequest,
        BaseReferences<_$AppDatabase, $FriendRequestsTable, FriendRequest>,
      ),
      FriendRequest,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
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

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserCredentialsTableTableManager get userCredentials =>
      $$UserCredentialsTableTableManager(_db, _db.userCredentials);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$FriendsTableTableManager get friends =>
      $$FriendsTableTableManager(_db, _db.friends);
  $$FriendRequestsTableTableManager get friendRequests =>
      $$FriendRequestsTableTableManager(_db, _db.friendRequests);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
