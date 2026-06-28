import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'message_dao.g.dart';

/// 消息 DAO。
///
/// 按会话缓存最近消息，支持分页查询。
@DriftAccessor(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase>
    with _$MessageDaoMixin {
  MessageDao(super.db);

  /// 插入一条消息。
  Future<void> insert(MessagesCompanion data) =>
      into(messages).insert(data, mode: InsertMode.insertOrReplace);

  /// 批量插入消息。
  Future<void> insertAll(List<MessagesCompanion> list) =>
      batch((batch) => batch.insertAll(messages, list,
          mode: InsertMode.insertOrReplace));

  /// 按会话分页获取消息（从旧到新）。
  Future<List<Message>> getByConversation(
    String conversationId, {
    int limit = 20,
    int offset = 0,
  }) =>
      (select(messages)
        ..where((m) => m.conversationId.equals(conversationId))
        ..orderBy([(m) => OrderingTerm(expression: m.createTime, mode: OrderingMode.desc)])
        ..limit(limit, offset: offset))
          .get();

  /// 监听会话的最新消息列表。
  Stream<List<Message>> watchByConversation(
    String conversationId, {
    int limit = 20,
  }) =>
      (select(messages)
        ..where((m) => m.conversationId.equals(conversationId))
        ..orderBy([(m) => OrderingTerm(expression: m.createTime, mode: OrderingMode.desc)])
        ..limit(limit))
          .watch();

  /// 更新消息状态（如发送成功）。
  Future<void> updateStatus(String msgId, String conversationId, int status) =>
      (update(messages)
        ..where((m) =>
            m.msgId.equals(msgId) & m.conversationId.equals(conversationId)))
          .write(MessagesCompanion(status: Value(status)));

  /// 删除单条消息。
  Future<void> deleteOne(String msgId, String conversationId) =>
      (delete(messages)
        ..where((m) =>
            m.msgId.equals(msgId) & m.conversationId.equals(conversationId)))
          .go();

  /// 清空会话消息。
  Future<void> deleteByConversation(String conversationId) =>
      (delete(messages)
            ..where((m) => m.conversationId.equals(conversationId)))
          .go();

  /// 清理 N 天前的旧消息（返回删除条数）。
  Future<int> deleteOlderThan(int timestampMs) =>
      (delete(messages)..where((m) => m.createTime.isSmallerThanValue(timestampMs)))
          .go();

  /// 清空所有消息（调试用）。
  Future<void> clear() => delete(messages).go();

  /// 收到新消息推送时插入一条消息（避免调用方直接构造 Drift companion）。
  Future<void> insertFromNotification({
    required String msgId,
    required String conversationId,
    String? fromUid,
    String? toUid,
    String? content,
    int contentType = 0,
    int status = 0,
    required int createTime,
  }) async {
    await insert(
      MessagesCompanion(
        msgId: Value(msgId),
        conversationId: Value(conversationId),
        fromUid: Value(fromUid),
        toUid: Value(toUid),
        content: Value(content),
        contentType: Value(contentType),
        status: Value(status),
        createTime: Value(createTime),
      ),
    );
  }

  /// 从服务端历史消息原始数据批量插入消息。
  Future<void> insertFromHistoryMaps(List<Map<String, dynamic>> list) async {
    if (list.isEmpty) return;
    final companions = list.map((map) {
      return MessagesCompanion(
        msgId: Value(map['msg_id']?.toString() ?? ''),
        conversationId: Value(map['conv_id']?.toString() ?? ''),
        fromUid: Value(map['from_uid'] as String?),
        toUid: Value(map['to_uid'] as String?),
        content: Value(map['content'] as String?),
        contentType: Value(map['content_type'] as int? ?? 0),
        status: Value(map['status'] as int? ?? 1),
        createTime: Value(map['create_time'] as int? ?? DateTime.now().millisecondsSinceEpoch),
      );
    }).toList();
    await insertAll(companions);
  }

  /// 获取指定会话中最大的 createTime，用于增量同步去重。
  Future<int> getMaxCreateTime(String conversationId) async {
    final query = selectOnly(messages)
      ..addColumns([messages.createTime])
      ..where(messages.conversationId.equals(conversationId))
      ..orderBy([OrderingTerm(expression: messages.createTime, mode: OrderingMode.desc)])
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row?.read(messages.createTime) ?? 0;
  }
}
