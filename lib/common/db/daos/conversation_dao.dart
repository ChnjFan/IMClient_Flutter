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

  /// 从服务端原始数据批量同步会话列表。
  Future<void> syncFromServerMaps(List<Map<String, dynamic>> list) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final companions = list.map((map) {
      return ConversationsCompanion(
        conversationId: Value(map['conv_id']?.toString() ?? ''),
        type: Value(map['type'] as int? ?? 0),
        title: Value(map['title'] as String?),
        avatarUrl: Value(map['avatar_url'] as String?),
        lastMsg: Value(map['last_msg'] as String?),
        lastMsgTime: Value(map['last_time'] as int?),
        unreadCount: Value(map['unread_count'] as int? ?? 0),
        createTime: Value(map['create_time'] as int? ?? now),
        updateTime: Value(map['update_time'] as int? ?? now),
      );
    }).toList();
    await syncFromServer(companions);
  }

  /// 监听会话列表（按最后消息时间倒序）。
  Stream<List<Conversation>> watchAll() =>
      (select(conversations)
        ..orderBy([
          (u) =>
              OrderingTerm(expression: u.lastMsgTime, mode: OrderingMode.desc),
        ]))
          .watch();

  /// 获取单个会话。
  Future<Conversation?> getById(String conversationId) =>
      (select(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .getSingleOrNull();

  /// 创建会话成功后，将服务端返回的会话信息保存到本地。
  ///
  /// [titleOverride] 不为空时覆盖服务端返回的 title（用于设置对方显示名）。
  Future<void> upsertFromCreateResponse(Map<String, dynamic> data, {String? titleOverride}) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await upsert(
      ConversationsCompanion(
        conversationId: Value(data['conv_id']?.toString() ?? ''),
        type: Value(data['conv_type'] as int? ?? 0),
        title: Value(titleOverride ?? data['title'] as String?),
        avatarUrl: Value(data['avatar_url'] as String?),
        lastMsg: Value(data['last_msg_content'] as String?),
        lastMsgTime: Value(data['last_time'] is int ? data['last_time'] as int? : null),
        unreadCount: const Value(0),
        createTime: Value(data['create_time'] is int ? data['create_time'] as int : now),
        updateTime: Value(now),
      ),
    );
  }

  /// 更新未读数。
  Future<void> updateUnreadCount(String conversationId, int count) =>
      (update(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .write(ConversationsCompanion(unreadCount: Value(count)));

  /// 删除会话。
  Future<void> deleteById(String conversationId) =>
      (delete(conversations)
            ..where((c) => c.conversationId.equals(conversationId)))
          .go();

  /// 清空所有会话（调试用）。
  Future<void> clear() => delete(conversations).go();

  /// 收到新消息时更新或创建会话。
  ///
  /// 如果会话已存在，则更新 lastMsg、lastMsgTime、unreadCount+1；
  /// 如果不存在，则创建新会话。
  Future<void> upsertFromNewMessage({
    required String convId,
    required String fromUid,
    required String content,
  }) async {
    final existing = await getById(convId);
    final now = DateTime.now().millisecondsSinceEpoch;

    if (existing != null) {
      await upsert(
        ConversationsCompanion(
          conversationId: Value(convId),
          lastMsg: Value(content),
          lastMsgTime: Value(now),
          unreadCount: Value(existing.unreadCount + 1),
          type: Value(existing.type),
          title: Value(existing.title),
          avatarUrl: Value(existing.avatarUrl),
          createTime: Value(existing.createTime),
          updateTime: Value(now),
        ),
      );
    } else {
      await upsert(
        ConversationsCompanion(
          conversationId: Value(convId),
          type: const Value(0),
          title: Value(fromUid),
          lastMsg: Value(content),
          lastMsgTime: Value(now),
          unreadCount: const Value(1),
          createTime: Value(now),
          updateTime: Value(now),
        ),
      );
    }
  }
}
