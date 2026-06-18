# Drift 本地存储方案文档

## 1. 现状分析

### 当前存储方式

项目目前使用 `shared_preferences` 进行本地持久化，封装在 [lib/common/utils/storage.dart](../lib/common/utils/storage.dart)。

**存储的数据：**

| 键名 | 类型 | 用途 |
|------|------|------|
| `user_id` | String | 当前登录用户 ID |
| `im_token` | String | IM 登录 Token |
| `area_code` | String | 手机区号 |
| `phone_number` | String | 手机号 |
| `login_type` | int | 登录方式 |
| `login_account` | JSON String | 登录账号信息 (host/port) |
| `server_host` | String | 服务器地址 |
| `server_config` | JSON String | 完整服务器配置 |

### 存在的问题

1. **无结构查询** — 所有数据通过 key 读取，无法进行条件查询、排序、分页
2. **JSON 序列化开销** — 对象数据（如 `login_account`、`server_config`）每次读写都需要 `jsonEncode`/`jsonDecode`
3. **无类型安全** — 编译期无法校验字段类型
4. **无关系模型** — 无法表达用户、消息、会话之间的关联关系
5. **无法扩展** — 后续缓存消息、会话列表、联系人等功能需要结构化存储
6. **无迁移机制** — 数据结构变更时只能手动处理兼容

---

## 2. 为什么选择 Drift

[Drift](https://drift.simonbinder.eu/)（前身 Moor）是 Flutter/Dart 生态中最成熟的响应式本地数据库方案。

| 对比维度 | SharedPreferences | Drift |
|---------|-------------------|-------|
| 类型安全 | ❌ 运行时转换 | ✅ 编译期校验 |
| SQL 查询 | ❌ | ✅ 完整 SQL 支持 |
| 关系模型 | ❌ | ✅ 表关联、外键 |
| 响应式流 | ❌ | ✅ Stream / Watch |
| 迁移管理 | ❌ 手动 | ✅ 内置迁移系统 |
| 跨平台 | ✅ | ✅ iOS/Android/Desktop/Web |
| 性能 | 只适合小数据 | 适合万级数据 |

---

## 3. 整体架构

```
┌────────────────────────────────────────┐
│              UI Layer                  │
│  (GetX Controllers / Views)           │
└──────────────┬─────────────────────────┘
               │
┌──────────────▼─────────────────────────┐
│          Repository Layer              │
│  (UserRepo / MessageRepo / ...)       │
│  封装 DAO 调用，提供业务语义接口         │
└──────────────┬─────────────────────────┘
               │
┌──────────────▼─────────────────────────┐
│            DAO Layer                   │
│  (UserDao / CredentialDao / ...)      │
│  定义数据库操作，返回 Stream/List       │
└──────────────┬─────────────────────────┘
               │
┌──────────────▼─────────────────────────┐
│         AppDatabase (Drift)            │
│  管理所有 Table 和 DAO                  │
│  提供数据库实例、迁移                   │
└──────────────┬─────────────────────────┘
               │
┌──────────────▼─────────────────────────┐
│         SQLite (底层引擎)               │
└────────────────────────────────────────┘
```

---

## 4. 数据库表设计

### 4.1 `user_credentials` — 登录凭证

替换当前 `Storage` 类的大部分功能。

```sql
CREATE TABLE user_credentials (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id         TEXT NOT NULL,
  token           TEXT NOT NULL,
  area_code       TEXT DEFAULT '+86',
  phone_number    TEXT,
  login_type      INTEGER DEFAULT 0,
  login_account   TEXT,            -- JSON: {host, port}
  server_host     TEXT,
  server_config   TEXT,            -- JSON: 完整服务器配置
  created_at      INTEGER NOT NULL,
  updated_at      INTEGER NOT NULL
);
```

> 该表只维护一条记录（最新登录凭证），通过 `id = 1` 或 `LIMIT 1` 访问。

### 4.2 `user_profiles` — 用户资料

缓存当前用户及联系人信息，对应 [UserInfo](../lib/common/models/user/user_info.dart)。

```sql
CREATE TABLE user_profiles (
  user_id         TEXT PRIMARY KEY,
  name            TEXT,
  remark          TEXT,            -- 备注名
  email           TEXT,
  avatar_url      TEXT,
  ex              TEXT,            -- 扩展字段 (JSON)
  is_self         INTEGER DEFAULT 0,  -- 1 = 当前登录用户
  created_at      INTEGER NOT NULL,
  updated_at      INTEGER NOT NULL
);
```

### 4.3 `conversations` — 会话列表

缓存最近会话，支持按最新消息时间排序。

```sql
CREATE TABLE conversations (
  conversation_id  TEXT PRIMARY KEY,
  type             INTEGER NOT NULL DEFAULT 0,  -- 0=单聊, 1=群聊
  title            TEXT,
  avatar_url       TEXT,
  last_msg         TEXT,            -- 最后一条消息摘要
  last_msg_time    INTEGER,         -- 最后消息时间戳
  unread_count     INTEGER DEFAULT 0,
  is_top           INTEGER DEFAULT 0,  -- 是否置顶
  created_at       INTEGER NOT NULL,
  updated_at       INTEGER NOT NULL
);
```

### 4.4 `messages` — 消息缓存

缓存最近聊天消息，支持分页加载。

```sql
CREATE TABLE messages (
  msg_id           TEXT NOT NULL,
  conversation_id  TEXT NOT NULL,
  from_uid         TEXT,
  to_uid           TEXT,
  content          TEXT,
  content_type     INTEGER DEFAULT 0,  -- 0=文本, 1=图片, 2=文件, 3=语音
  status           INTEGER DEFAULT 0,  -- 0=发送中, 1=已发送, 2=失败
  send_time        INTEGER NOT NULL,
  created_at       INTEGER NOT NULL,

  PRIMARY KEY (msg_id, conversation_id),
  FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id)
);
```

### 4.5 `friends` — 已添加好友

仅存储已确认的好友关系，待处理的请求见 `friend_requests` 表。

```sql
CREATE TABLE friends (
  user_id         TEXT PRIMARY KEY,
  remark          TEXT,              -- 备注名
  group_name      TEXT,              -- 好友分组（默认 '我的好友'）
  status          INTEGER DEFAULT 1, -- 1=正常, 2=已拉黑
  source          TEXT,              -- 添加来源/验证消息
  added_at        INTEGER,           -- 添加时间戳
  created_at      INTEGER NOT NULL,
  updated_at      INTEGER NOT NULL
);
```

> 好友详情（昵称、头像等）通过 `user_id` 关联 `user_profiles` 表查询，避免数据冗余。

### 4.6 `friend_requests` — 好友请求

存储未处理的好友申请（收到或发出的），处理完成后移入 `friends` 表。

```sql
CREATE TABLE friend_requests (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  from_uid        TEXT NOT NULL,       -- 发起方用户ID
  to_uid          TEXT NOT NULL,       -- 接收方用户ID
  message         TEXT,                -- 验证消息
  status          INTEGER DEFAULT 0,   -- 0=待确认, 1=已同意, 2=已拒绝
  handled_at      INTEGER,             -- 处理时间戳
  created_at      INTEGER NOT NULL,
  updated_at      INTEGER NOT NULL
);
```

> 通过 `from_uid` / `to_uid` 区分是收到还是发出的请求。当前用户 ID 等于 `to_uid` 时即为收到的申请。

### 4.7 `app_settings` — 应用配置

以 key-value 形式存储零散配置项，保留 `SharedPreferences` 的灵活性。

```sql
CREATE TABLE app_settings (
  key    TEXT PRIMARY KEY,
  value  TEXT NOT NULL
);
```

---

## 5. 依赖配置

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  drift: ^2.21.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.1    # 已有
  path: ^1.9.0

dev_dependencies:
  drift_dev: ^2.21.0
  build_runner: ^2.4.0
```

---

## 6. 核心代码实现

### 6.1 数据库定义 (`lib/common/db/database.dart`)

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';
import 'daos/credential_dao.dart';
import 'daos/user_dao.dart';
import 'daos/conversation_dao.dart';
import 'daos/message_dao.dart';
import 'daos/friend_dao.dart';
import 'daos/friend_request_dao.dart';
import 'daos/settings_dao.dart';

part 'database.g.dart'; // build_runner 生成

@DriftDatabase(
  tables: [
    UserCredentials,
    UserProfiles,
    Conversations,
    Messages,
    Friends,
    FriendRequests,
    AppSettings,
  ],
  daos: [
    CredentialDao,
    UserProfileDao,
    ConversationDao,
    MessageDao,
    FriendDao,
    FriendRequestDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // 后续版本在此处理迁移
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imclient.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

### 6.2 表定义 (`lib/common/db/tables.dart`)

```dart
import 'package:drift/drift.dart';

/// 登录凭证表
class UserCredentials extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get token => text()();
  TextColumn get areaCode => text().named('area_code').withDefault(const Constant('+86'))();
  TextColumn get phoneNumber => text().named('phone_number').nullable()();
  IntColumn get loginType => integer().named('login_type').withDefault(const Constant(0))();
  TextColumn get loginAccount => text().named('login_account').nullable()();
  TextColumn get serverHost => text().named('server_host').nullable()();
  TextColumn get serverConfig => text().named('server_config').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// 用户资料表
class UserProfiles extends Table {
  TextColumn get userId => text().named('user_id')();
  TextColumn get name => text().nullable()();
  TextColumn get remark => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get ex => text().nullable()();
  BoolColumn get isSelf => boolean().named('is_self').withDefault(const Constant(false))();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 会话表
class Conversations extends Table {
  TextColumn get conversationId => text().named('conversation_id')();
  IntColumn get type => integer().withDefault(const Constant(0))();
  TextColumn get title => text().nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get lastMsg => text().named('last_msg').nullable()();
  IntColumn get lastMsgTime => integer().named('last_msg_time').nullable()();
  IntColumn get unreadCount => integer().named('unread_count').withDefault(const Constant(0))();
  BoolColumn get isTop => boolean().named('is_top').withDefault(const Constant(false))();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {conversationId};
}

/// 消息表
class Messages extends Table {
  TextColumn get msgId => text().named('msg_id')();
  TextColumn get conversationId => text().named('conversation_id')();
  TextColumn get fromUid => text().named('from_uid').nullable()();
  TextColumn get toUid => text().named('to_uid').nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get contentType => integer().named('content_type').withDefault(const Constant(0))();
  IntColumn get status => integer().withDefault(const Constant(0))();
  IntColumn get sendTime => integer().named('send_time')();
  IntColumn get createdAt => integer().named('created_at')();

  @override
  Set<Column> get primaryKey => {msgId, conversationId};
}

/// 好友列表表（已确认好友）
class Friends extends Table {
  TextColumn get userId => text().named('user_id')();
  TextColumn get remark => text().nullable()();
  TextColumn get groupName => text().named('group_name').withDefault(const Constant('我的好友'))();
  IntColumn get status => integer().withDefault(const Constant(1))();
  TextColumn get source => text().nullable()();
  IntColumn get addedAt => integer().named('added_at').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 好友请求表（待处理申请）
class FriendRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromUid => text().named('from_uid')();
  TextColumn get toUid => text().named('to_uid')();
  TextColumn get message => text().nullable()();
  IntColumn get status => integer().withDefault(const Constant(0))();
  IntColumn get handledAt => integer().named('handled_at').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// 应用设置表
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
```

### 6.3 DAO 示例

**凭证 DAO (`lib/common/db/daos/credential_dao.dart`)：**

```dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'credential_dao.g.dart';

@DriftAccessor(tables: [UserCredentials])
class CredentialDao extends DatabaseAccessor<AppDatabase>
    with _$CredentialDaoMixin {
  CredentialDao(super.db);

  // ---- 写入 ----

  /// 保存登录凭证（先清空旧数据，再插入新记录）
  Future<void> saveCredentials({
    required String userId,
    required String token,
    String areaCode = '+86',
    String? phoneNumber,
    int loginType = 0,
    Map<String, dynamic>? loginAccount,
    Map<String, dynamic>? serverConfig,
  }) async {
    await delete(userCredentials).go();
    final now = DateTime.now().millisecondsSinceEpoch;
    await into(userCredentials).insert(
      UserCredentialsCompanion(
        userId: Value(userId),
        token: Value(token),
        areaCode: Value(areaCode),
        phoneNumber: Value.absentIfNull(phoneNumber),
        loginType: Value(loginType),
        loginAccount: Value.absentIfNull(loginAccount),
        serverConfig: Value.absentIfNull(serverConfig),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  // ---- 读取 ----

  /// 获取当前登录凭证（最多一条记录）
  Future<UserCredential?> getLatest() {
    return (selectOnly(userCredentials)
      ..limit(1))
      .map((row) => row.readTable(userCredentials))
      .getSingleOrNull();
  }

  /// 监听登录凭证变化
  Stream<UserCredential?> watchLatest() {
    return (select(userCredentials)
      ..limit(1))
      .map((rows) => rows.isNotEmpty ? rows.first : null)
      .watchSingleOrNull();
  }

  // ---- 删除 ----

  Future<void> clearCredentials() => delete(userCredentials).go();
}
```

**用户 DAO (`lib/common/db/daos/user_dao.dart`)：**

```dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserProfiles])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  Future<void> upsert(UserProfilesCompanion data) =>
      into(userProfiles).insertOnConflictUpdate(data);

  Future<UserProfile?> getByUserId(String userId) =>
      (select(userProfiles)..where((u) => u.userId.equals(userId)))
          .getSingleOrNull();

  Future<UserProfile?> getSelf() =>
      (select(userProfiles)..where((u) => u.isSelf.equals(true)))
          .getSingleOrNull();

  Stream<List<UserProfile>> watchAll() => select(userProfiles).watch();

  Future<void> deleteByUserId(String userId) =>
      (delete(userProfiles)..where((u) => u.userId.equals(userId))).go();
}
```

**好友 DAO (`lib/common/db/daos/friend_dao.dart`)：**

```dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'friend_dao.g.dart';

@DriftAccessor(tables: [Friends, UserProfiles])
class FriendDao extends DatabaseAccessor<AppDatabase>
    with _$FriendDaoMixin {
  FriendDao(super.db);

  /// 插入或更新好友
  Future<void> upsert(FriendsCompanion data) =>
      into(friends).insertOnConflictUpdate(data);

  /// 批量同步好友列表（全量替换，通常用于初次拉取）
  Future<void> syncFromServer(List<FriendsCompanion> list) async {
    await batch((batch) {
      batch.deleteAll(friends);
      batch.insertAll(friends, list, mode: InsertMode.insertOrReplace);
    });
  }

  /// 按分组获取好友列表
  Stream<List<Friend>> watchByGroup(String groupName) =>
      (select(friends)..where((f) => f.groupName.equals(groupName)))
          .watch();

  /// 获取所有正常好友
  Stream<List<Friend>> watchAll() =>
      (select(friends)..where((f) => f.status.equals(1))).watch();

  /// 拉黑列表
  Stream<List<Friend>> watchBlocked() =>
      (select(friends)..where((f) => f.status.equals(2))).watch();

  /// 按 userId 查找好友
  Future<Friend?> getByUserId(String userId) =>
      (select(friends)..where((f) => f.userId.equals(userId)))
          .getSingleOrNull();

  /// 好友详情（联表 user_profiles，含头像昵称）
  Stream<List<FriendWithProfile>> watchAllWithProfile() {
    final query = select(friends).join([
      leftOuterJoin(userProfiles, userProfiles.userId.equals(friends.userId)),
    ]);
    return query.map((row) {
      return FriendWithProfile(
        friend: row.readTable(friends),
        profile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 更新备注
  Future<void> updateRemark(String userId, String remark) =>
      (update(friends)
        ..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(remark: Value(remark)));

  /// 拉黑/取消拉黑
  Future<void> updateStatus(String userId, int status) =>
      (update(friends)
        ..where((f) => f.userId.equals(userId)))
        .write(FriendsCompanion(status: Value(status)));

  /// 删除好友
  Future<void> deleteByUserId(String userId) =>
      (delete(friends)..where((f) => f.userId.equals(userId))).go();
}

/// 好友 + 资料联表结果
class FriendWithProfile {
  final Friend friend;
  final UserProfile? profile;

  FriendWithProfile({required this.friend, required this.profile});
}
```

**好友请求 DAO (`lib/common/db/daos/friend_request_dao.dart`)：**

```dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'friend_request_dao.g.dart';

@DriftAccessor(tables: [FriendRequests, UserProfiles])
class FriendRequestDao extends DatabaseAccessor<AppDatabase>
    with _$FriendRequestDaoMixin {
  FriendRequestDao(super.db);

  /// 插入新的好友请求
  Future<int> insert(FriendRequestsCompanion data) =>
      into(friendRequests).insert(data);

  /// 收到的好友申请（to_uid == 当前用户，待确认）
  Stream<List<FriendRequest>> watchIncoming(String currentUid) =>
      (select(friendRequests)
        ..where((r) => r.toUid.equals(currentUid) & r.status.equals(0)))
        .watch();

  /// 发出的好友申请（from_uid == 当前用户）
  Stream<List<FriendRequest>> watchOutgoing(String currentUid) =>
      (select(friendRequests)
        ..where((r) => r.fromUid.equals(currentUid)))
        .watch();

  /// 待处理申请数量（红点用）
  Stream<int> watchPendingCount(String currentUid) {
    final q = selectOnly(friendRequests)
      ..addColumns([friendRequests.id.count()])
      ..where(friendRequests.toUid.equals(currentUid) &
          friendRequests.status.equals(0));
    return q.map((row) => row.read(friendRequests.id.count()) ?? 0).watchSingle();
  }

  /// 收到的好友申请（联表资料，含申请人头像昵称）
  Stream<List<FriendRequestWithProfile>> watchIncomingWithProfile(String currentUid) {
    final query = select(friendRequests).join([
      leftOuterJoin(userProfiles, userProfiles.userId.equals(friendRequests.fromUid)),
    ])
      ..where(friendRequests.toUid.equals(currentUid) &
          friendRequests.status.equals(0));
    return query.map((row) {
      return FriendRequestWithProfile(
        request: row.readTable(friendRequests),
        fromProfile: row.readTableOrNull(userProfiles),
      );
    }).watch();
  }

  /// 处理好友请求（同意/拒绝）
  Future<void> handle(int id, bool accept) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(friendRequests)
      ..where((r) => r.id.equals(id)))
      .write(FriendRequestsCompanion(
        status: Value(accept ? 1 : 2),
        handledAt: Value(now),
        updatedAt: Value(now),
      ));
  }

  /// 删除请求记录
  Future<void> deleteById(int id) =>
      (delete(friendRequests)..where((r) => r.id.equals(id))).go();
}

/// 好友请求 + 申请人资料联表结果
class FriendRequestWithProfile {
  final FriendRequest request;
  final UserProfile? fromProfile;

  FriendRequestWithProfile({required this.request, required this.fromProfile});
}
```

---

## 7. 迁移方案

### 7.1 从 SharedPreferences 到 Drift 的迁移

迁移分三步走，保证平滑过渡：

#### 阶段一：双写（1 周）

```
SharedPreferences ──写入──► Storage (旧代码)
                  ──写入──► Drift (新增)
SharedPreferences ◄──读取── Storage (现有逻辑，不受影响)
```

1. 在 `AppDatabase` 初始化后，新增 `MigrationHelper` 类
2. `MigrationHelper` 读取 `SharedPreferences` 现有数据，写入 Drift 对应表
3. 所有写入操作同时写两处，读取仍走 `SharedPreferences`

#### 阶段二：切换读取（验证后）

```
Drift ◄──读取── Repository (新代码)
```

1. 验证 Drift 数据与 `SharedPreferences` 数据一致性
2. 将读取逻辑从 `Storage` 切换到 `CredentialDao`
3. 停止双写，只写 Drift

#### 阶段三：清理

1. `Storage` 类标记为 `@Deprecated`
2. 清空 `SharedPreferences` 中的冗余数据
3. 2 个版本后彻底删除 `Storage` 类

### 7.2 迁移辅助代码

```dart
/// lib/common/db/migration_helper.dart
class MigrationHelper {
  static Future<void> migrateFromSharedPrefs(AppDatabase db) async {
    final pref = await SharedPreferences.getInstance();

    final uid = pref.getString('user_id');
    final tkn = pref.getString('im_token');
    if (uid == null || uid.isEmpty) return; // 无旧数据，跳过

    final accountStr = pref.getString('login_account');
    Map<String, dynamic>? account;
    if (accountStr != null) {
      account = jsonDecode(accountStr);
    }

    final configStr = pref.getString('server_config');
    Map<String, dynamic>? config;
    if (configStr != null) {
      config = jsonDecode(configStr);
    }

    await db.credentialDao.saveCredentials(
      userId: uid,
      token: tkn ?? '',
      areaCode: pref.getString('area_code') ?? '+86',
      phoneNumber: pref.getString('phone_number'),
      loginType: pref.getInt('login_type') ?? 0,
      loginAccount: account,
      serverConfig: config,
    );

    print('MigrationHelper — migrated from SharedPreferences to Drift');
  }
}
```

---

## 8. 集成到现有流程

### 8.1 App 启动初始化

在 `main.dart` 中初始化 Drift：

```dart
final appDatabase = AppDatabase();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Drift
  final db = AppDatabase();

  // 迁移旧数据
  await MigrationHelper.migrateFromSharedPrefs(db);

  // 注入到 GetX
  Get.put<AppDatabase>(db, permanent: true);

  runApp(const MyApp());
}
```

### 8.2 Splash 页面改造

在 `SplashLogic._checkLoginState()` 中：

```dart
Future<void> _checkLoginState() async {
  await Future.delayed(const Duration(seconds: 2));

  final db = Get.find<AppDatabase>();
  final credential = await db.credentialDao.getLatest();

  if (credential != null &&
      credential.userId.isNotEmpty &&
      credential.token.isNotEmpty) {
    // 有凭证，自动登录
    try {
      final cert = LoginCertificate(
        userId: credential.userId,
        chatToken: credential.token,
        chatServerIp: credential.serverHost ?? '',
        chatServerPort: credential.loginAccount?['port'] ?? '0',
      );
      await imLogic.login(cert);
      AppNavigator.startSplashToMain(isAutoLogin: true);
    } catch (e) {
      await db.credentialDao.clearCredentials();
      AppNavigator.startLogin();
    }
  } else {
    AppNavigator.startLogin();
  }
}
```

### 8.3 登录成功后保存凭证

```dart
// 替换原来的 Storage.putLoginCertificate()
await db.credentialDao.saveCredentials(
  userId: cert.userId,
  token: cert.chatToken,
  serverHost: cert.chatServerIp,
  loginAccount: {'host': cert.chatServerIp, 'port': cert.chatServerPort},
);
```

### 8.4 登出时清理

```dart
// 替换原来的 Storage.removeLoginCertificate()
await db.credentialDao.clearCredentials();
```

---

## 9. 代码结构

```
lib/
├── common/
│   ├── db/
│   │   ├── database.dart            # AppDatabase 定义 + 初始化
│   │   ├── database.g.dart          # (build_runner 生成)
│   │   ├── tables.dart              # 所有 Table 定义
│   │   ├── migration_helper.dart    # 从 SharedPreferences 迁移
│   │   ├── converters.dart          # 自定义类型转换器
│   │   └── daos/
│   │       ├── credential_dao.dart  # 凭证 CRUD
│   │       ├── credential_dao.g.dart
│   │       ├── user_dao.dart        # 用户 CRUD
│   │       ├── user_dao.g.dart
│   │       ├── conversation_dao.dart
│   │       ├── conversation_dao.g.dart
│   │       ├── message_dao.dart
│   │       ├── message_dao.g.dart
│   │       ├── friend_dao.dart
│   │       ├── friend_dao.g.dart
│   │       ├── friend_request_dao.dart
│   │       ├── friend_request_dao.g.dart
│   │       ├── settings_dao.dart
│   │       └── settings_dao.g.dart
│   ├── repository/                   # (可选) 业务仓储层
│   │   ├── user_repository.dart
│   │   ├── credential_repository.dart
│   │   └── ...
│   └── utils/
│       └── storage.dart              # 保留，标记 @Deprecated
```

---

## 10. 生成与开发流程

```bash
# 安装依赖
flutter pub add drift sqlite3_flutter_libs
flutter pub add --dev drift_dev build_runner

# 每次修改表或 DAO 后运行
dart run build_runner build --delete-conflicting-outputs

# 或 watch 模式（开发时推荐）
dart run build_runner watch --delete-conflicting-outputs
```

---

## 11. 最佳实践

1. **主键策略** — 凭据表用自增 ID；用户 ID、会话 ID 由服务端返回，直接做主键；消息表用 `(msgId, conversationId)` 联合主键
2. **时间戳** — 统一使用 `millisecondsSinceEpoch`（`int`），与 IM 协议的时间戳格式保持一致
3. **响应式查询** — 对于 UI 需要实时更新的数据（会话列表、消息列表），使用 `watch()` 返回 `Stream`
4. **单例数据库** — `AppDatabase` 通过 `Get.put(..., permanent: true)` 全局持有一个实例，避免多次初始化
5. **后台写入** — 使用 `NativeDatabase.createInBackground()` 确保数据库操作不阻塞 UI 线程
6. **JSON 字段** — 对于 `login_account`、`server_config` 等灵活结构的字段，使用 Drift 的 `TypeConverter` 自动序列化/反序列化
7. **测试** — DAO 层可在单元测试中使用内存数据库独立验证

---

## 12. 风险与注意事项

| 风险 | 应对 |
|------|------|
| 数据库文件损坏 | 捕获 `SqliteException`，降级到 SharedPreferences 或触发重新登录 |
| 旧版本升级时数据丢失 | 实现 `onUpgrade` 迁移，按 schemaVersion 逐版本处理 |
| 大消息量导致性能下降 | 消息表按时间分页 + 定期清理超过 N 天的旧消息 |
| build_runner 生成冲突 | CI 中严格检查 `.g.dart` 文件是否与源文件同步 |

---

## 13. 参考

- [Drift 官方文档](https://drift.simonbinder.eu/docs/)
- [Drift Dart API](https://pub.dev/packages/drift)
- [SQLite 数据类型](https://www.sqlite.org/datatype3.html)
