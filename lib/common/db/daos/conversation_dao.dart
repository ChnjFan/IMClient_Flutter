import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';
import '../../utils/time_utils.dart';

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

  /// 从服务端原始数据批量同步会话列表（全量覆盖）。
  Future<void> syncFromServerMaps(List<Map<String, dynamic>> list) async {
    final companions = _mapsToCompanions(list);
    await syncFromServer(companions);
  }

  /// 从服务端原始数据增量更新会话列表（upsert，不清表）。
  ///
  /// 用于 [sinceUpdateTime] > 0 的增量拉取场景，避免覆盖本地
  /// 尚未同步到服务端的最新状态（如刚发送消息更新的 lastMsg）。
  Future<void> upsertFromServerMaps(List<Map<String, dynamic>> list) async {
    if (list.isEmpty) return;
    final companions = _mapsToCompanions(list);
    await batch((batch) {
      batch.insertAll(conversations, companions,
          mode: InsertMode.insertOrReplace);
    });
  }

  /// 将服务端原始 Map 列表转为 Drift companion 列表。
  List<ConversationsCompanion> _mapsToCompanions(List<Map<String, dynamic>> list) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return list.map((map) {
      return ConversationsCompanion(
        conversationId: Value(map['conv_id']?.toString() ?? ''),
        type: Value(map['conv_type'] as int? ?? 0),
        title: Value(map['title'] as String?),
        avatarUrl: Value(map['avatar_url']?.toString() ?? ''),
        lastMsg: Value(map['last_msg_content'] as String?),
        lastMsgTime: Value(TimeUtils.parseServerTime(map['last_time']?.toString())),
        unreadCount: Value(map['unread_count'] as int? ?? 0),
        isMute: Value(map['is_mute'] as int? ?? 0),
        createTime: Value(TimeUtils.parseServerTime(map['create_time']?.toString()) ?? now),
        updateTime: Value(TimeUtils.parseServerTime(map['update_time']?.toString()) ?? now),
      );
    }).toList();
  }

  /// 获取本地所有会话中最大的 updateTime，用于增量同步。
  ///
  /// 表空时返回 0。
  Future<int> getMaxUpdateTime() async {
    final query = selectOnly(conversations)
      ..addColumns([conversations.updateTime])
      ..orderBy([
        OrderingTerm(
            expression: conversations.updateTime, mode: OrderingMode.desc)
      ])
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row?.read(conversations.updateTime) ?? 0;
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
        lastMsgTime: Value(TimeUtils.parseServerTime(data['last_time']?.toString())),
        unreadCount: const Value(0),
        isMute: Value(data['is_mute'] as int? ?? 0),
        createTime: Value(TimeUtils.parseServerTime(data['create_time']?.toString()) ?? now),
        updateTime: Value(TimeUtils.parseServerTime(data['update_time']?.toString()) ?? now),
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

  /// 发送消息后更新会话的最后消息和最后消息时间。
  ///
  /// 仅更新 lastMsg、lastMsgTime，不修改未读计数。
  /// 如果会话不存在（极少见，比如服务端创建了会话但本地尚未同步），则新建一条。
  Future<void> updateLastMessage({
    required String convId,
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
          unreadCount: Value(existing.unreadCount),
          type: Value(existing.type),
          title: Value(existing.title),
          avatarUrl: Value(existing.avatarUrl),
          createTime: Value(existing.createTime),
          updateTime: Value(now),
        ),
      );
    } else {
      // 兜底：会话尚不存在时创建一条最小记录
      await upsert(
        ConversationsCompanion(
          conversationId: Value(convId),
          type: const Value(0),
          lastMsg: Value(content),
          lastMsgTime: Value(now),
          unreadCount: const Value(0),
          createTime: Value(now),
          updateTime: Value(now),
        ),
      );
    }
  }
}
