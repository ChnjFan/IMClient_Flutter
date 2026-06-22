import 'package:drift/drift.dart';

/// 登录凭证表
///
/// 替换 SharedPreferences 中的 user_id / token / area_code / phone_number /
/// login_type / login_account / server_host / server_config。仅维护一条记录。
class UserCredentials extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get token => text().named('token')();
  TextColumn get areaCode =>
      text().named('area_code').withDefault(const Constant('+86'))();
  TextColumn get phoneNumber => text().named('phone_number').nullable()();
  TextColumn get email => text().named('email').nullable()();
  IntColumn get loginType =>
      integer().named('login_type').withDefault(const Constant(0))();
  // 登录账号信息（手机号/邮箱/第三方账号等）
  TextColumn get loginAccount => text().named('login_account').nullable()();
  // 记录 TCP 服务器的 IP 和 PORT
  TextColumn get serverHost => text().named('server_host').nullable()();
  TextColumn get serverPort => text().named('server_port').nullable()();
  // 协商服务端配置，JSON 格式字符串，内容根据实际需求定义（如是否开启消息加密等）
  TextColumn get serverConfig => text().named('server_config').nullable()();
  IntColumn get createTime => integer().named('create_time')();
  IntColumn get updateTime => integer().named('update_time')();
}

/// 用户资料表
///
/// 缓存当前登录用户及联系人的基本信息，对应 [UserInfo] 模型。
class UserProfiles extends Table {
  TextColumn get userId => text().named('uid')();
  TextColumn get name => text().named('name').nullable()();
  TextColumn get alias => text().named('alias').nullable()();
  TextColumn get email => text().named('email').nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get region => text().named('region').nullable()();
  IntColumn get gender =>
      integer().withDefault(const Constant(0))(); // 0=未知, 1=男, 2=女
  TextColumn get ex => text().named('ex').nullable()();
  BoolColumn get isSelf =>
      boolean().named('is_self').withDefault(const Constant(false))();
  IntColumn get createTime => integer().named('create_time')();
  IntColumn get updateTime => integer().named('update_time')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 会话列表表
///
/// 缓存最近会话，支持按最后消息时间排序和置顶。
class Conversations extends Table {
  TextColumn get conversationId => text().named('conv_id')();
  IntColumn get type => integer().withDefault(const Constant(0))(); // 0=单聊, 1=群聊
  TextColumn get title => text().named('title').nullable()();
  TextColumn get avatarUrl => text().named('avatar_url').nullable()();
  TextColumn get lastMsg => text().named('last_msg').nullable()();
  IntColumn get lastMsgTime => integer().named('last_time').nullable()();
  IntColumn get unreadCount =>
      integer().named('unread_count').withDefault(const Constant(0))();
  IntColumn get createTime => integer().named('create_time')();
  IntColumn get updateTime => integer().named('update_time')();

  @override
  Set<Column> get primaryKey => {conversationId};
}

/// 消息缓存表
///
/// 按会话缓存最近消息，支持分页加载。联合主键 (msgId, conversationId)。
class Messages extends Table {
  TextColumn get msgId => text().named('msg_id')();
  TextColumn get conversationId => text().named('conv_id')();
  TextColumn get fromUid => text().named('from_uid').nullable()();
  TextColumn get toUid => text().named('to_uid').nullable()();
  TextColumn get content => text().nullable()();
  IntColumn get contentType =>
      integer().named('content_type').withDefault(const Constant(0))(); // 0=文本, 1=图片, 2=文件, 3=语音
  IntColumn get status =>
      integer().withDefault(const Constant(0))(); // 0=发送中, 1=已发送, 2=失败
  IntColumn get createTime => integer().named('create_time')();

  @override
  Set<Column> get primaryKey => {msgId, conversationId};
}

/// 好友列表表
///
/// 仅存储已确认的好友关系。status: 1=正常, 2=已拉黑, 3=已删除，4=屏蔽消息。
/// 昵称、头像等详情通过 userId 关联 [UserProfiles] 查询。
class Friends extends Table {
  // id 字段记录服务端生成的自增 ID，用于增量查询和数据同步，非业务主键。
  IntColumn get id => integer().named('id').nullable()();
  TextColumn get userId => text().named('uid')();
  TextColumn get alias => text().named('alias').nullable()();
  TextColumn get groupName =>
      text().named('group_name').withDefault(const Constant('我的好友'))();
  IntColumn get status => integer().withDefault(const Constant(1))();
  // source 记录好友关系的来源，如 'imported', 'added', 'mutual_friend' 等，便于后续分析和分组。
  TextColumn get source => text().named('source').nullable()();
  IntColumn get createTime => integer().named('create_time')();
  IntColumn get updateTime => integer().named('update_time')();

  @override
  Set<Column> get primaryKey => {userId};
}

/// 好友请求表
///
/// 待处理的好友申请（收到/发出）。处理完成后移入 [Friends] 表。
/// - fromUid == currentUser: 发出的申请
/// - toUid == currentUser: 收到的申请
class FriendRequests extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get uid => text().named('uid ')(); // 发出申请的用户 uid
  TextColumn get friendId => text().named('friend_id')(); // 申请的好友 uid
  TextColumn get message => text().named('message').nullable()();
  IntColumn get status =>
      integer().withDefault(const Constant(0))(); // 0=待确认, 1=已同意, 2=已拒绝, 3=已过期
  IntColumn get createTime => integer().named('create_time')();
  IntColumn get updateTime => integer().named('update_time')();
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
