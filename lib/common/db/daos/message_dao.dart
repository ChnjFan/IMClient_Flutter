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
}
