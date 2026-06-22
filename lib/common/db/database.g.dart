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
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
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
    email,
    loginType,
    loginAccount,
    serverHost,
    serverPort,
    serverConfig,
    createTime,
    updateTime,
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
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
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
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
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
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
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
  final String? email;
  final int loginType;
  final String? loginAccount;
  final String? serverHost;
  final String? serverPort;
  final String? serverConfig;
  final int createTime;
  final int updateTime;
  const UserCredential({
    required this.id,
    required this.userId,
    required this.token,
    required this.areaCode,
    this.phoneNumber,
    this.email,
    required this.loginType,
    this.loginAccount,
    this.serverHost,
    this.serverPort,
    this.serverConfig,
    required this.createTime,
    required this.updateTime,
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
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
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
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
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
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
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
      createTime: Value(createTime),
      updateTime: Value(updateTime),
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
      email: serializer.fromJson<String?>(json['email']),
      loginType: serializer.fromJson<int>(json['loginType']),
      loginAccount: serializer.fromJson<String?>(json['loginAccount']),
      serverHost: serializer.fromJson<String?>(json['serverHost']),
      serverPort: serializer.fromJson<String?>(json['serverPort']),
      serverConfig: serializer.fromJson<String?>(json['serverConfig']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
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
      'email': serializer.toJson<String?>(email),
      'loginType': serializer.toJson<int>(loginType),
      'loginAccount': serializer.toJson<String?>(loginAccount),
      'serverHost': serializer.toJson<String?>(serverHost),
      'serverPort': serializer.toJson<String?>(serverPort),
      'serverConfig': serializer.toJson<String?>(serverConfig),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
    };
  }

  UserCredential copyWith({
    int? id,
    String? userId,
    String? token,
    String? areaCode,
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> email = const Value.absent(),
    int? loginType,
    Value<String?> loginAccount = const Value.absent(),
    Value<String?> serverHost = const Value.absent(),
    Value<String?> serverPort = const Value.absent(),
    Value<String?> serverConfig = const Value.absent(),
    int? createTime,
    int? updateTime,
  }) => UserCredential(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    token: token ?? this.token,
    areaCode: areaCode ?? this.areaCode,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    email: email.present ? email.value : this.email,
    loginType: loginType ?? this.loginType,
    loginAccount: loginAccount.present ? loginAccount.value : this.loginAccount,
    serverHost: serverHost.present ? serverHost.value : this.serverHost,
    serverPort: serverPort.present ? serverPort.value : this.serverPort,
    serverConfig: serverConfig.present ? serverConfig.value : this.serverConfig,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
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
      email: data.email.present ? data.email.value : this.email,
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
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
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
          ..write('email: $email, ')
          ..write('loginType: $loginType, ')
          ..write('loginAccount: $loginAccount, ')
          ..write('serverHost: $serverHost, ')
          ..write('serverPort: $serverPort, ')
          ..write('serverConfig: $serverConfig, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
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
    email,
    loginType,
    loginAccount,
    serverHost,
    serverPort,
    serverConfig,
    createTime,
    updateTime,
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
          other.email == this.email &&
          other.loginType == this.loginType &&
          other.loginAccount == this.loginAccount &&
          other.serverHost == this.serverHost &&
          other.serverPort == this.serverPort &&
          other.serverConfig == this.serverConfig &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class UserCredentialsCompanion extends UpdateCompanion<UserCredential> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> token;
  final Value<String> areaCode;
  final Value<String?> phoneNumber;
  final Value<String?> email;
  final Value<int> loginType;
  final Value<String?> loginAccount;
  final Value<String?> serverHost;
  final Value<String?> serverPort;
  final Value<String?> serverConfig;
  final Value<int> createTime;
  final Value<int> updateTime;
  const UserCredentialsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.token = const Value.absent(),
    this.areaCode = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.loginType = const Value.absent(),
    this.loginAccount = const Value.absent(),
    this.serverHost = const Value.absent(),
    this.serverPort = const Value.absent(),
    this.serverConfig = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  UserCredentialsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String token,
    this.areaCode = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.loginType = const Value.absent(),
    this.loginAccount = const Value.absent(),
    this.serverHost = const Value.absent(),
    this.serverPort = const Value.absent(),
    this.serverConfig = const Value.absent(),
    required int createTime,
    required int updateTime,
  }) : userId = Value(userId),
       token = Value(token),
       createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<UserCredential> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? token,
    Expression<String>? areaCode,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<int>? loginType,
    Expression<String>? loginAccount,
    Expression<String>? serverHost,
    Expression<String>? serverPort,
    Expression<String>? serverConfig,
    Expression<int>? createTime,
    Expression<int>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (token != null) 'token': token,
      if (areaCode != null) 'area_code': areaCode,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (loginType != null) 'login_type': loginType,
      if (loginAccount != null) 'login_account': loginAccount,
      if (serverHost != null) 'server_host': serverHost,
      if (serverPort != null) 'server_port': serverPort,
      if (serverConfig != null) 'server_config': serverConfig,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  UserCredentialsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? token,
    Value<String>? areaCode,
    Value<String?>? phoneNumber,
    Value<String?>? email,
    Value<int>? loginType,
    Value<String?>? loginAccount,
    Value<String?>? serverHost,
    Value<String?>? serverPort,
    Value<String?>? serverConfig,
    Value<int>? createTime,
    Value<int>? updateTime,
  }) {
    return UserCredentialsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      areaCode: areaCode ?? this.areaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      loginType: loginType ?? this.loginType,
      loginAccount: loginAccount ?? this.loginAccount,
      serverHost: serverHost ?? this.serverHost,
      serverPort: serverPort ?? this.serverPort,
      serverConfig: serverConfig ?? this.serverConfig,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
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
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
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
          ..write('email: $email, ')
          ..write('loginType: $loginType, ')
          ..write('loginAccount: $loginAccount, ')
          ..write('serverHost: $serverHost, ')
          ..write('serverPort: $serverPort, ')
          ..write('serverConfig: $serverConfig, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
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
    'uid',
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
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
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
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    name,
    alias,
    email,
    avatarUrl,
    region,
    gender,
    ex,
    isSelf,
    createTime,
    updateTime,
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
    if (data.containsKey('uid')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['uid']!, _userIdMeta),
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
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
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
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
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
        data['${effectivePrefix}uid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gender'],
      )!,
      ex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ex'],
      ),
      isSelf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_self'],
      )!,
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
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
  final String? alias;
  final String? email;
  final String? avatarUrl;
  final String? region;
  final int gender;
  final String? ex;
  final bool isSelf;
  final int createTime;
  final int updateTime;
  const UserProfile({
    required this.userId,
    this.name,
    this.alias,
    this.email,
    this.avatarUrl,
    this.region,
    required this.gender,
    this.ex,
    required this.isSelf,
    required this.createTime,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(userId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || alias != null) {
      map['alias'] = Variable<String>(alias);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['gender'] = Variable<int>(gender);
    if (!nullToAbsent || ex != null) {
      map['ex'] = Variable<String>(ex);
    }
    map['is_self'] = Variable<bool>(isSelf);
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      userId: Value(userId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      alias: alias == null && nullToAbsent
          ? const Value.absent()
          : Value(alias),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      gender: Value(gender),
      ex: ex == null && nullToAbsent ? const Value.absent() : Value(ex),
      isSelf: Value(isSelf),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
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
      alias: serializer.fromJson<String?>(json['alias']),
      email: serializer.fromJson<String?>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      region: serializer.fromJson<String?>(json['region']),
      gender: serializer.fromJson<int>(json['gender']),
      ex: serializer.fromJson<String?>(json['ex']),
      isSelf: serializer.fromJson<bool>(json['isSelf']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String?>(name),
      'alias': serializer.toJson<String?>(alias),
      'email': serializer.toJson<String?>(email),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'region': serializer.toJson<String?>(region),
      'gender': serializer.toJson<int>(gender),
      'ex': serializer.toJson<String?>(ex),
      'isSelf': serializer.toJson<bool>(isSelf),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
    };
  }

  UserProfile copyWith({
    String? userId,
    Value<String?> name = const Value.absent(),
    Value<String?> alias = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> region = const Value.absent(),
    int? gender,
    Value<String?> ex = const Value.absent(),
    bool? isSelf,
    int? createTime,
    int? updateTime,
  }) => UserProfile(
    userId: userId ?? this.userId,
    name: name.present ? name.value : this.name,
    alias: alias.present ? alias.value : this.alias,
    email: email.present ? email.value : this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    region: region.present ? region.value : this.region,
    gender: gender ?? this.gender,
    ex: ex.present ? ex.value : this.ex,
    isSelf: isSelf ?? this.isSelf,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      alias: data.alias.present ? data.alias.value : this.alias,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      region: data.region.present ? data.region.value : this.region,
      gender: data.gender.present ? data.gender.value : this.gender,
      ex: data.ex.present ? data.ex.value : this.ex,
      isSelf: data.isSelf.present ? data.isSelf.value : this.isSelf,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('alias: $alias, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('region: $region, ')
          ..write('gender: $gender, ')
          ..write('ex: $ex, ')
          ..write('isSelf: $isSelf, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    name,
    alias,
    email,
    avatarUrl,
    region,
    gender,
    ex,
    isSelf,
    createTime,
    updateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.alias == this.alias &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.region == this.region &&
          other.gender == this.gender &&
          other.ex == this.ex &&
          other.isSelf == this.isSelf &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> userId;
  final Value<String?> name;
  final Value<String?> alias;
  final Value<String?> email;
  final Value<String?> avatarUrl;
  final Value<String?> region;
  final Value<int> gender;
  final Value<String?> ex;
  final Value<bool> isSelf;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.alias = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.region = const Value.absent(),
    this.gender = const Value.absent(),
    this.ex = const Value.absent(),
    this.isSelf = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String userId,
    this.name = const Value.absent(),
    this.alias = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.region = const Value.absent(),
    this.gender = const Value.absent(),
    this.ex = const Value.absent(),
    this.isSelf = const Value.absent(),
    required int createTime,
    required int updateTime,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<UserProfile> custom({
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? alias,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<String>? region,
    Expression<int>? gender,
    Expression<String>? ex,
    Expression<bool>? isSelf,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'uid': userId,
      if (name != null) 'name': name,
      if (alias != null) 'alias': alias,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (region != null) 'region': region,
      if (gender != null) 'gender': gender,
      if (ex != null) 'ex': ex,
      if (isSelf != null) 'is_self': isSelf,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? userId,
    Value<String?>? name,
    Value<String?>? alias,
    Value<String?>? email,
    Value<String?>? avatarUrl,
    Value<String?>? region,
    Value<int>? gender,
    Value<String?>? ex,
    Value<bool>? isSelf,
    Value<int>? createTime,
    Value<int>? updateTime,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      region: region ?? this.region,
      gender: gender ?? this.gender,
      ex: ex ?? this.ex,
      isSelf: isSelf ?? this.isSelf,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['uid'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (ex.present) {
      map['ex'] = Variable<String>(ex.value);
    }
    if (isSelf.present) {
      map['is_self'] = Variable<bool>(isSelf.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
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
          ..write('alias: $alias, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('region: $region, ')
          ..write('gender: $gender, ')
          ..write('ex: $ex, ')
          ..write('isSelf: $isSelf, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
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
    'conv_id',
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
    'last_time',
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
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
    createTime,
    updateTime,
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
    if (data.containsKey('conv_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conv_id']!,
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
    if (data.containsKey('last_time')) {
      context.handle(
        _lastMsgTimeMeta,
        lastMsgTime.isAcceptableOrUnknown(data['last_time']!, _lastMsgTimeMeta),
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
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
        data['${effectivePrefix}conv_id'],
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
        data['${effectivePrefix}last_time'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
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
  final int createTime;
  final int updateTime;
  const Conversation({
    required this.conversationId,
    required this.type,
    this.title,
    this.avatarUrl,
    this.lastMsg,
    this.lastMsgTime,
    required this.unreadCount,
    required this.createTime,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conv_id'] = Variable<String>(conversationId);
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
      map['last_time'] = Variable<int>(lastMsgTime);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
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
      createTime: Value(createTime),
      updateTime: Value(updateTime),
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
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
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
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
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
    int? createTime,
    int? updateTime,
  }) => Conversation(
    conversationId: conversationId ?? this.conversationId,
    type: type ?? this.type,
    title: title.present ? title.value : this.title,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    lastMsg: lastMsg.present ? lastMsg.value : this.lastMsg,
    lastMsgTime: lastMsgTime.present ? lastMsgTime.value : this.lastMsgTime,
    unreadCount: unreadCount ?? this.unreadCount,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
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
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
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
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
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
    createTime,
    updateTime,
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
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> conversationId;
  final Value<int> type;
  final Value<String?> title;
  final Value<String?> avatarUrl;
  final Value<String?> lastMsg;
  final Value<int?> lastMsgTime;
  final Value<int> unreadCount;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.conversationId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.lastMsg = const Value.absent(),
    this.lastMsgTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
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
    required int createTime,
    required int updateTime,
    this.rowid = const Value.absent(),
  }) : conversationId = Value(conversationId),
       createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<Conversation> custom({
    Expression<String>? conversationId,
    Expression<int>? type,
    Expression<String>? title,
    Expression<String>? avatarUrl,
    Expression<String>? lastMsg,
    Expression<int>? lastMsgTime,
    Expression<int>? unreadCount,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conv_id': conversationId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (lastMsg != null) 'last_msg': lastMsg,
      if (lastMsgTime != null) 'last_time': lastMsgTime,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
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
    Value<int>? createTime,
    Value<int>? updateTime,
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
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conv_id'] = Variable<String>(conversationId.value);
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
      map['last_time'] = Variable<int>(lastMsgTime.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
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
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
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
    'conv_id',
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
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
    createTime,
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
    if (data.containsKey('conv_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conv_id']!,
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
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
        data['${effectivePrefix}conv_id'],
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
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
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
  final int createTime;
  const Message({
    required this.msgId,
    required this.conversationId,
    this.fromUid,
    this.toUid,
    this.content,
    required this.contentType,
    required this.status,
    required this.createTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['msg_id'] = Variable<String>(msgId);
    map['conv_id'] = Variable<String>(conversationId);
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
    map['create_time'] = Variable<int>(createTime);
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
      createTime: Value(createTime),
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
      createTime: serializer.fromJson<int>(json['createTime']),
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
      'createTime': serializer.toJson<int>(createTime),
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
    int? createTime,
  }) => Message(
    msgId: msgId ?? this.msgId,
    conversationId: conversationId ?? this.conversationId,
    fromUid: fromUid.present ? fromUid.value : this.fromUid,
    toUid: toUid.present ? toUid.value : this.toUid,
    content: content.present ? content.value : this.content,
    contentType: contentType ?? this.contentType,
    status: status ?? this.status,
    createTime: createTime ?? this.createTime,
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
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
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
          ..write('createTime: $createTime')
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
    createTime,
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
          other.createTime == this.createTime);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> msgId;
  final Value<String> conversationId;
  final Value<String?> fromUid;
  final Value<String?> toUid;
  final Value<String?> content;
  final Value<int> contentType;
  final Value<int> status;
  final Value<int> createTime;
  final Value<int> rowid;
  const MessagesCompanion({
    this.msgId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.fromUid = const Value.absent(),
    this.toUid = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.status = const Value.absent(),
    this.createTime = const Value.absent(),
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
    required int createTime,
    this.rowid = const Value.absent(),
  }) : msgId = Value(msgId),
       conversationId = Value(conversationId),
       createTime = Value(createTime);
  static Insertable<Message> custom({
    Expression<String>? msgId,
    Expression<String>? conversationId,
    Expression<String>? fromUid,
    Expression<String>? toUid,
    Expression<String>? content,
    Expression<int>? contentType,
    Expression<int>? status,
    Expression<int>? createTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (msgId != null) 'msg_id': msgId,
      if (conversationId != null) 'conv_id': conversationId,
      if (fromUid != null) 'from_uid': fromUid,
      if (toUid != null) 'to_uid': toUid,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (status != null) 'status': status,
      if (createTime != null) 'create_time': createTime,
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
    Value<int>? createTime,
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
      createTime: createTime ?? this.createTime,
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
      map['conv_id'] = Variable<String>(conversationId.value);
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
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
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
          ..write('createTime: $createTime, ')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    alias,
    groupName,
    status,
    source,
    createTime,
    updateTime,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['uid']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Friend(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
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
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
      )!,
    );
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(attachedDatabase, alias);
  }
}

class Friend extends DataClass implements Insertable<Friend> {
  final int? id;
  final String userId;
  final String? alias;
  final String groupName;
  final int status;
  final String? source;
  final int createTime;
  final int updateTime;
  const Friend({
    this.id,
    required this.userId,
    this.alias,
    required this.groupName,
    required this.status,
    this.source,
    required this.createTime,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['uid'] = Variable<String>(userId);
    if (!nullToAbsent || alias != null) {
      map['alias'] = Variable<String>(alias);
    }
    map['group_name'] = Variable<String>(groupName);
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId: Value(userId),
      alias: alias == null && nullToAbsent
          ? const Value.absent()
          : Value(alias),
      groupName: Value(groupName),
      status: Value(status),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
    );
  }

  factory Friend.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Friend(
      id: serializer.fromJson<int?>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      alias: serializer.fromJson<String?>(json['alias']),
      groupName: serializer.fromJson<String>(json['groupName']),
      status: serializer.fromJson<int>(json['status']),
      source: serializer.fromJson<String?>(json['source']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'userId': serializer.toJson<String>(userId),
      'alias': serializer.toJson<String?>(alias),
      'groupName': serializer.toJson<String>(groupName),
      'status': serializer.toJson<int>(status),
      'source': serializer.toJson<String?>(source),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
    };
  }

  Friend copyWith({
    Value<int?> id = const Value.absent(),
    String? userId,
    Value<String?> alias = const Value.absent(),
    String? groupName,
    int? status,
    Value<String?> source = const Value.absent(),
    int? createTime,
    int? updateTime,
  }) => Friend(
    id: id.present ? id.value : this.id,
    userId: userId ?? this.userId,
    alias: alias.present ? alias.value : this.alias,
    groupName: groupName ?? this.groupName,
    status: status ?? this.status,
    source: source.present ? source.value : this.source,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
  );
  Friend copyWithCompanion(FriendsCompanion data) {
    return Friend(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      alias: data.alias.present ? data.alias.value : this.alias,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('alias: $alias, ')
          ..write('groupName: $groupName, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    alias,
    groupName,
    status,
    source,
    createTime,
    updateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.alias == this.alias &&
          other.groupName == this.groupName &&
          other.status == this.status &&
          other.source == this.source &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<int?> id;
  final Value<String> userId;
  final Value<String?> alias;
  final Value<String> groupName;
  final Value<int> status;
  final Value<String?> source;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<int> rowid;
  const FriendsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.alias = const Value.absent(),
    this.groupName = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.alias = const Value.absent(),
    this.groupName = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    required int createTime,
    required int updateTime,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<Friend> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? alias,
    Expression<String>? groupName,
    Expression<int>? status,
    Expression<String>? source,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'uid': userId,
      if (alias != null) 'alias': alias,
      if (groupName != null) 'group_name': groupName,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendsCompanion copyWith({
    Value<int?>? id,
    Value<String>? userId,
    Value<String?>? alias,
    Value<String>? groupName,
    Value<int>? status,
    Value<String?>? source,
    Value<int>? createTime,
    Value<int>? updateTime,
    Value<int>? rowid,
  }) {
    return FriendsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      alias: alias ?? this.alias,
      groupName: groupName ?? this.groupName,
      status: status ?? this.status,
      source: source ?? this.source,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['uid'] = Variable<String>(userId.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
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
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('alias: $alias, ')
          ..write('groupName: $groupName, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
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
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid ',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _friendIdMeta = const VerificationMeta(
    'friendId',
  );
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
    'friend_id',
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
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    friendId,
    message,
    status,
    createTime,
    updateTime,
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
    if (data.containsKey('uid ')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid ']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(
        _friendIdMeta,
        friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta),
      );
    } else if (isInserting) {
      context.missing(_friendIdMeta);
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
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
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
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid '],
      )!,
      friendId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}friend_id'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}update_time'],
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
  final String uid;
  final String friendId;
  final String? message;
  final int status;
  final int createTime;
  final int updateTime;
  const FriendRequest({
    required this.id,
    required this.uid,
    required this.friendId,
    this.message,
    required this.status,
    required this.createTime,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid '] = Variable<String>(uid);
    map['friend_id'] = Variable<String>(friendId);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['status'] = Variable<int>(status);
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    return map;
  }

  FriendRequestsCompanion toCompanion(bool nullToAbsent) {
    return FriendRequestsCompanion(
      id: Value(id),
      uid: Value(uid),
      friendId: Value(friendId),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      status: Value(status),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
    );
  }

  factory FriendRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendRequest(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      friendId: serializer.fromJson<String>(json['friendId']),
      message: serializer.fromJson<String?>(json['message']),
      status: serializer.fromJson<int>(json['status']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'friendId': serializer.toJson<String>(friendId),
      'message': serializer.toJson<String?>(message),
      'status': serializer.toJson<int>(status),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
    };
  }

  FriendRequest copyWith({
    int? id,
    String? uid,
    String? friendId,
    Value<String?> message = const Value.absent(),
    int? status,
    int? createTime,
    int? updateTime,
  }) => FriendRequest(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    friendId: friendId ?? this.friendId,
    message: message.present ? message.value : this.message,
    status: status ?? this.status,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
  );
  FriendRequest copyWithCompanion(FriendRequestsCompanion data) {
    return FriendRequest(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      message: data.message.present ? data.message.value : this.message,
      status: data.status.present ? data.status.value : this.status,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequest(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('friendId: $friendId, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uid, friendId, message, status, createTime, updateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendRequest &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.friendId == this.friendId &&
          other.message == this.message &&
          other.status == this.status &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime);
}

class FriendRequestsCompanion extends UpdateCompanion<FriendRequest> {
  final Value<int> id;
  final Value<String> uid;
  final Value<String> friendId;
  final Value<String?> message;
  final Value<int> status;
  final Value<int> createTime;
  final Value<int> updateTime;
  const FriendRequestsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.friendId = const Value.absent(),
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  FriendRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required String friendId,
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    required int createTime,
    required int updateTime,
  }) : uid = Value(uid),
       friendId = Value(friendId),
       createTime = Value(createTime),
       updateTime = Value(updateTime);
  static Insertable<FriendRequest> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<String>? friendId,
    Expression<String>? message,
    Expression<int>? status,
    Expression<int>? createTime,
    Expression<int>? updateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid ': uid,
      if (friendId != null) 'friend_id': friendId,
      if (message != null) 'message': message,
      if (status != null) 'status': status,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  FriendRequestsCompanion copyWith({
    Value<int>? id,
    Value<String>? uid,
    Value<String>? friendId,
    Value<String?>? message,
    Value<int>? status,
    Value<int>? createTime,
    Value<int>? updateTime,
  }) {
    return FriendRequestsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      friendId: friendId ?? this.friendId,
      message: message ?? this.message,
      status: status ?? this.status,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid '] = Variable<String>(uid.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequestsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('friendId: $friendId, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime')
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
      Value<String?> email,
      Value<int> loginType,
      Value<String?> loginAccount,
      Value<String?> serverHost,
      Value<String?> serverPort,
      Value<String?> serverConfig,
      required int createTime,
      required int updateTime,
    });
typedef $$UserCredentialsTableUpdateCompanionBuilder =
    UserCredentialsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> token,
      Value<String> areaCode,
      Value<String?> phoneNumber,
      Value<String?> email,
      Value<int> loginType,
      Value<String?> loginAccount,
      Value<String?> serverHost,
      Value<String?> serverPort,
      Value<String?> serverConfig,
      Value<int> createTime,
      Value<int> updateTime,
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

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

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
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
                Value<String?> email = const Value.absent(),
                Value<int> loginType = const Value.absent(),
                Value<String?> loginAccount = const Value.absent(),
                Value<String?> serverHost = const Value.absent(),
                Value<String?> serverPort = const Value.absent(),
                Value<String?> serverConfig = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
              }) => UserCredentialsCompanion(
                id: id,
                userId: userId,
                token: token,
                areaCode: areaCode,
                phoneNumber: phoneNumber,
                email: email,
                loginType: loginType,
                loginAccount: loginAccount,
                serverHost: serverHost,
                serverPort: serverPort,
                serverConfig: serverConfig,
                createTime: createTime,
                updateTime: updateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String token,
                Value<String> areaCode = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> loginType = const Value.absent(),
                Value<String?> loginAccount = const Value.absent(),
                Value<String?> serverHost = const Value.absent(),
                Value<String?> serverPort = const Value.absent(),
                Value<String?> serverConfig = const Value.absent(),
                required int createTime,
                required int updateTime,
              }) => UserCredentialsCompanion.insert(
                id: id,
                userId: userId,
                token: token,
                areaCode: areaCode,
                phoneNumber: phoneNumber,
                email: email,
                loginType: loginType,
                loginAccount: loginAccount,
                serverHost: serverHost,
                serverPort: serverPort,
                serverConfig: serverConfig,
                createTime: createTime,
                updateTime: updateTime,
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
      Value<String?> alias,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> region,
      Value<int> gender,
      Value<String?> ex,
      Value<bool> isSelf,
      required int createTime,
      required int updateTime,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> userId,
      Value<String?> name,
      Value<String?> alias,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> region,
      Value<int> gender,
      Value<String?> ex,
      Value<bool> isSelf,
      Value<int> createTime,
      Value<int> updateTime,
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

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
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

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gender => $composableBuilder(
    column: $table.gender,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
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

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gender => $composableBuilder(
    column: $table.gender,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get ex =>
      $composableBuilder(column: $table.ex, builder: (column) => column);

  GeneratedColumn<bool> get isSelf =>
      $composableBuilder(column: $table.isSelf, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
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
                Value<String?> alias = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<int> gender = const Value.absent(),
                Value<String?> ex = const Value.absent(),
                Value<bool> isSelf = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                userId: userId,
                name: name,
                alias: alias,
                email: email,
                avatarUrl: avatarUrl,
                region: region,
                gender: gender,
                ex: ex,
                isSelf: isSelf,
                createTime: createTime,
                updateTime: updateTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<String?> name = const Value.absent(),
                Value<String?> alias = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<int> gender = const Value.absent(),
                Value<String?> ex = const Value.absent(),
                Value<bool> isSelf = const Value.absent(),
                required int createTime,
                required int updateTime,
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                userId: userId,
                name: name,
                alias: alias,
                email: email,
                avatarUrl: avatarUrl,
                region: region,
                gender: gender,
                ex: ex,
                isSelf: isSelf,
                createTime: createTime,
                updateTime: updateTime,
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
      required int createTime,
      required int updateTime,
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
      Value<int> createTime,
      Value<int> updateTime,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
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
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion(
                conversationId: conversationId,
                type: type,
                title: title,
                avatarUrl: avatarUrl,
                lastMsg: lastMsg,
                lastMsgTime: lastMsgTime,
                unreadCount: unreadCount,
                createTime: createTime,
                updateTime: updateTime,
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
                required int createTime,
                required int updateTime,
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion.insert(
                conversationId: conversationId,
                type: type,
                title: title,
                avatarUrl: avatarUrl,
                lastMsg: lastMsg,
                lastMsgTime: lastMsgTime,
                unreadCount: unreadCount,
                createTime: createTime,
                updateTime: updateTime,
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
      required int createTime,
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
      Value<int> createTime,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
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

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );
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
                Value<int> createTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                msgId: msgId,
                conversationId: conversationId,
                fromUid: fromUid,
                toUid: toUid,
                content: content,
                contentType: contentType,
                status: status,
                createTime: createTime,
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
                required int createTime,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                msgId: msgId,
                conversationId: conversationId,
                fromUid: fromUid,
                toUid: toUid,
                content: content,
                contentType: contentType,
                status: status,
                createTime: createTime,
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
      Value<int?> id,
      required String userId,
      Value<String?> alias,
      Value<String> groupName,
      Value<int> status,
      Value<String?> source,
      required int createTime,
      required int updateTime,
      Value<int> rowid,
    });
typedef $$FriendsTableUpdateCompanionBuilder =
    FriendsCompanion Function({
      Value<int?> id,
      Value<String> userId,
      Value<String?> alias,
      Value<String> groupName,
      Value<int> status,
      Value<String?> source,
      Value<int> createTime,
      Value<int> updateTime,
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
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
                Value<int?> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> alias = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FriendsCompanion(
                id: id,
                userId: userId,
                alias: alias,
                groupName: groupName,
                status: status,
                source: source,
                createTime: createTime,
                updateTime: updateTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required String userId,
                Value<String?> alias = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required int createTime,
                required int updateTime,
                Value<int> rowid = const Value.absent(),
              }) => FriendsCompanion.insert(
                id: id,
                userId: userId,
                alias: alias,
                groupName: groupName,
                status: status,
                source: source,
                createTime: createTime,
                updateTime: updateTime,
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
      required String uid,
      required String friendId,
      Value<String?> message,
      Value<int> status,
      required int createTime,
      required int updateTime,
    });
typedef $$FriendRequestsTableUpdateCompanionBuilder =
    FriendRequestsCompanion Function({
      Value<int> id,
      Value<String> uid,
      Value<String> friendId,
      Value<String?> message,
      Value<int> status,
      Value<int> createTime,
      Value<int> updateTime,
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

  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get friendId => $composableBuilder(
    column: $table.friendId,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get friendId => $composableBuilder(
    column: $table.friendId,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );
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
                Value<String> uid = const Value.absent(),
                Value<String> friendId = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> updateTime = const Value.absent(),
              }) => FriendRequestsCompanion(
                id: id,
                uid: uid,
                friendId: friendId,
                message: message,
                status: status,
                createTime: createTime,
                updateTime: updateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uid,
                required String friendId,
                Value<String?> message = const Value.absent(),
                Value<int> status = const Value.absent(),
                required int createTime,
                required int updateTime,
              }) => FriendRequestsCompanion.insert(
                id: id,
                uid: uid,
                friendId: friendId,
                message: message,
                status: status,
                createTime: createTime,
                updateTime: updateTime,
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
