import 'package:drift/drift.dart';

/// 登录凭证表
///
/// 替换 SharedPreferences 中的 user_id / token / area_code / phone_number /
/// login_type / login_account / server_host / server_config。仅维护一条记录。
class UserCredentials extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get token => text()();
  TextColumn get areaCode =>
      text().named('area_code').withDefault(const Constant('+86'))();
  TextColumn get phoneNumber => text().named('phone_number').nullable()();
  IntColumn get loginType =>
      integer().named('login_type').withDefault(const Constant(0))();
  TextColumn get loginAccount => text().named('login_account').nullable()();
  TextColumn get serverHost => text().named('server_host').nullable()();
  TextColumn get serverPort => text().named('server_port').nullable()();
  TextColumn get serverConfig => text().named('server_config').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

}

/// 用户资料表
///
/// 缓存当前登录用户及联系人的基本信息，对应 [UserInfo] 模型。
class UserProfiles extends Table {
  TextColumn get userId => text().named('user_id')();
  TextColumn get name => text().nullable()();
  TextColumn get remark => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get ex => text().nullable()();
  BoolColumn get isSelf =>
      boolean().named('is_self').withDefault(const Constant(false))();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 会话列表表
///
/// 缓存最近会话，支持按最后消息时间排序和置顶。
class Conversations extends Table {
  TextColumn get conversationId => text().named('conversation_id')();
  IntColumn get type => integer().withDefault(const Constant(0))(); // 0=单聊, 1=群聊
  TextColumn get title => text().nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get lastMsg => text().named('last_msg').nullable()();
  IntColumn get lastMsgTime => integer().named('last_msg_time').nullable()();
  IntColumn get unreadCount =>
      integer().named('unread_count').withDefault(const Constant(0))();
  BoolColumn get isTop =>
      boolean().named('is_top').withDefault(const Constant(false))();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {conversationId};
}

/// 消息缓存表
///
/// 按会话缓存最近消息，支持分页加载。联合主键 (msgId, conversationId)。
class Messages extends Table {
  TextColumn get msgId => text().named('msg_id')();
  TextColumn get conversationId => text().named('conversation_id')();
  TextColumn get fromUid => text().named('from_uid').nullable()();
  TextColumn get toUid => text().named('to_uid').nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get contentType =>
      integer().named('content_type').withDefault(const Constant(0))(); // 0=文本, 1=图片, 2=文件, 3=语音
  IntColumn get status =>
      integer().withDefault(const Constant(0))(); // 0=发送中, 1=已发送, 2=失败
  IntColumn get sendTime => integer().named('send_time')();
  IntColumn get createdAt => integer().named('created_at')();

  @override
  Set<Column> get primaryKey => {msgId, conversationId};
}

/// 好友列表表
///
/// 仅存储已确认的好友关系。status: 1=正常, 2=已拉黑。
/// 昵称、头像等详情通过 userId 关联 [UserProfiles] 查询。
class Friends extends Table {
  TextColumn get userId => text().named('user_id')();
  TextColumn get remark => text().nullable()();
  TextColumn get groupName =>
      text().named('group_name').withDefault(const Constant('我的好友'))();
  IntColumn get status => integer().withDefault(const Constant(1))();
  TextColumn get source => text().nullable()();
  IntColumn get addedAt => integer().named('added_at').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 好友请求表
///
/// 待处理的好友申请（收到/发出）。处理完成后移入 [Friends] 表。
/// - fromUid == currentUser: 发出的申请
/// - toUid == currentUser: 收到的申请
class FriendRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromUid => text().named('from_uid')();
  TextColumn get toUid => text().named('to_uid')();
  TextColumn get message => text().nullable()();
  IntColumn get status =>
      integer().withDefault(const Constant(0))(); // 0=待确认, 1=已同意, 2=已拒绝
  IntColumn get handledAt => integer().named('handled_at').nullable()();
  IntColumn get createdAt => integer().named('created_at')();
  IntColumn get updatedAt => integer().named('updated_at')();
}

/// 应用设置表
///
/// Key-value 存储零散配置项，保留 SharedPreferences 的灵活性。
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
