import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'conversation_dao.g.dart';

/// 会话 DAO。
///
/// 管理最近会话列表的读写。
@DriftAccessor(tables: [Conversations])
class ConversationDao extends DatabaseAccessor<AppDatabase>
    with _$ConversationDaoMixin {
  ConversationDao(super.db);

  /// 插入或更新会话。
  Future<void> upsert(ConversationsCompanion data) =>
      into(conversations).insertOnConflictUpdate(data);

  /// 批量同步会话列表。
  Future<void> syncFromServer(List<ConversationsCompanion> list) async {
    await batch((batch) {
      batch.deleteAll(conversations);
      batch.insertAll(conversations, list, mode: InsertMode.insertOrReplace);
    });
  }

  /// 监听会话列表（置顶优先，按最后消息时间倒序）。
  Stream<List<Conversation>> watchAll() =>
      (select(conversations)
        ..orderBy([
          (u) => OrderingTerm(expression: u.isTop, mode: OrderingMode.desc),
          (u) =>
              OrderingTerm(expression: u.lastMsgTime, mode: OrderingMode.desc),
        ]))
          .watch();

  /// 获取单个会话。
  Future<Conversation?> getById(String conversationId) =>
      (select(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .getSingleOrNull();

  /// 更新未读数。
  Future<void> updateUnreadCount(String conversationId, int count) =>
      (update(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .write(ConversationsCompanion(unreadCount: Value(count)));

  /// 切换置顶。
  Future<void> toggleTop(String conversationId, bool isTop) =>
      (update(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .write(ConversationsCompanion(isTop: Value(isTop)));

  /// 删除会话。
  Future<void> deleteById(String conversationId) =>
      (delete(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .go();
}
