import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/message_dao.dart';
import '../../common/models/user/user_full_info.dart';
import '../../common/models/user/user_info.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import '../conversation/conversation_logic.dart';

class ChatLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final IMController _imController = Get.find<IMController>();
  late final MessageDao _messageDao;

  // 由路由参数注入
  late final String convId;
  UserInfo? targetUser;

  final messages = <Message>[].obs;
  /// 展示列表：在消息间插入时间分隔符（间隔 > 1 分钟时）。
  final displayItems = <dynamic>[].obs;
  final convCreateTime = 0.obs;
  final isLoading = true.obs;
  final isSending = false.obs;
  final isRefreshing = false.obs;

  StreamSubscription<List<Message>>? _subscription;
  Timer? _readTimer;
  bool _isFetchingHistory = false;

  String get currentUid => _imController.userInfo.value.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    _parseArguments();
    _messageDao = _db.messageDao;

    // 本地优先：订阅本地消息流
    _subscription = _messageDao.watchByConversation(convId, limit: 100).listen(
      (list) {
        messages.value = list.reversed.toList(); // Drift 查询默认倒序，反转后升序
        _updateDisplayItems();
        isLoading.value = false;
        if (list.isNotEmpty) {
          Logger.print('ChatLogic — watch emitted ${list.length} messages for conv $convId');
        }
      },
      onError: (_) {
        isLoading.value = false;
      },
    );

    // 加载会话创建时间
    _loadConvCreateTime();

    // 后台拉取服务端历史消息
    _fetchHistoryMessages();

    // 延迟标记消息已读
    _markMessagesRead();
  }

  void _parseArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      convId = args['convId'] as String? ?? '';
      final user = args['targetUser'];
      if (user is UserInfo) targetUser = user;
    } else {
      convId = '';
    }

    if (convId.isEmpty) {
      Logger.print('ChatLogic — convId is empty, cannot initialize chat');
      isLoading.value = false;
    }
  }

  /// 在消息间插入时间分隔符（前后两条消息间隔超过 1 分钟时）。
  void _updateDisplayItems() {
    final list = messages;
    final items = <dynamic>[];
    for (int i = 0; i < list.length; i++) {
      final msg = list[i];
      if (i == 0 || (msg.createTime - list[i - 1].createTime) > 600000) {
        items.add(ConversationLogic.formatTime(msg.createTime));
      }
      items.add(msg);
    }
    displayItems.value = items;
  }

  /// 从本地数据库加载会话创建时间。
  Future<void> _loadConvCreateTime() async {
    final conv = await _db.conversationDao.getById(convId);
    if (conv != null) {
      convCreateTime.value = conv.createTime;
    }
  }

  /// 从 convId（格式 "c2c_3_7"）中提取对方 uid。
  static String? extractPeerUid(String convId, String currentUid) {
    final parts = convId.split('_');
    if (parts.length < 3) return null;
    final uid1 = parts[1];
    final uid2 = parts[2];
    if (uid1 == currentUid) return uid2;
    if (uid2 == currentUid) return uid1;
    return uid2;
  }

  /// 从服务端拉取历史消息，增量合并到本地数据库。
  /// 服务端返回 [has_more] 为 1 时持续拉取，直到拉完所有历史消息。
  Future<void> _fetchHistoryMessages() async {
    if (_isFetchingHistory) return;
    _isFetchingHistory = true;

    try {
      var sinceMsgId = await _messageDao.getMaxServerMsgId(convId);
      var totalSynced = 0;

      while (true) {
        Logger.print('ChatLogic — fetching history since $sinceMsgId for conv $convId');

        final (:list, :hasMore) = await _imController.fetchHistoryMessages(
          convId: convId,
          msgId: sinceMsgId,
        );

        if (list.isEmpty) break;

        await _messageDao.insertFromHistoryMaps(list);
        totalSynced += list.length;
        Logger.print('ChatLogic — synced ${list.length} history messages (total: $totalSynced)');

        if (hasMore != 1) break;

        // 以本批次最后一条消息的 serverMsgId 作为下次拉取的起点
        final last = list.last;
        final lastMsgId = last['msg_id'];
        if (lastMsgId is int) {
          sinceMsgId = lastMsgId;
        } else if (lastMsgId is String) {
          sinceMsgId = int.tryParse(lastMsgId) ?? sinceMsgId;
        }
      }

      if (totalSynced > 0) {
        Logger.print('ChatLogic — history fetch complete, synced $totalSynced messages total');
      }
    } catch (e, stack) {
      Logger.print('ChatLogic — fetchHistoryMessages error: $e\n$stack');
    } finally {
      _isFetchingHistory = false;
    }
  }

  /// 延迟 300ms 后发送消息已读状态到服务端。
  /// 若 300ms 内页面关闭则取消发送。
  void _markMessagesRead() {
    _readTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final lastMsgId = await _messageDao.getMaxServerMsgId(convId);
        if (lastMsgId > 0) {
          final conv = await _db.conversationDao.getById(convId);
          final unreadCount = conv?.unreadCount ?? 0;

          _imController.updateMessagesStatus(
            convId: convId,
            count: unreadCount,
            lastMsgId: lastMsgId,
            status: 2, // 已读
          );
        }
      } catch (e) {
        Logger.print('ChatLogic — _markMessagesRead error: $e');
      }
    });
  }

  /// 点击对方头像：优先从本地数据库获取用户资料和好友关系，
  /// 二者缺一即从服务端拉取完整信息。
  Future<void> onPeerAvatarTap() async {
    final peerUid = targetUser?.uid ?? extractPeerUid(convId, currentUid);
    if (peerUid == null || peerUid.isEmpty) return;

    // 并行查询本地缓存：用户资料 + 好友关系
    final results = await Future.wait([
      _db.userProfileDao.getByUserId(peerUid),
      _db.friendDao.getByUserId(peerUid),
    ]);
    final localProfile = results[0] as UserProfile?;
    final localFriend = results[1] as Friend?;

    if (localProfile != null && localFriend != null) {
      // 本地资料和好友关系都有缓存，直接构造 UserFullInfo
      final fullInfo = UserFullInfo(
        uid: localProfile.userId,
        name: localProfile.name,
        alias: localFriend.alias ?? localProfile.alias,
        email: localProfile.email,
        avatarUrl: localProfile.avatarUrl,
        region: localProfile.region,
        gender: localProfile.gender,
        ex: localProfile.ex,
        friendStatus: localFriend.status,
        isStarred: localFriend.isStarred,
        isHidden: localFriend.isHidden,
      );
      AppNavigator.startUserProfilePanel(userInfo: fullInfo);
    } else {
      // 本地缓存不完整，从服务端拉取完整信息
      final fullInfo = await _imController.getUserFullInfo(
        uid: peerUid,
        from: currentUid,
      );
      AppNavigator.startUserProfilePanel(userInfo: fullInfo);
    }
  }

  /// 发送文本消息。
  Future<bool> sendTextMessage(String text) async {
    if (text.trim().isEmpty || convId.isEmpty) return false;
    isSending.value = true;

    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final toUid = targetUser?.uid ?? '';

      // 先写入本地（状态：发送中），获取自增 id
      final id = await _messageDao.insertFromNotification(
        conversationId: convId,
        fromUid: currentUid,
        toUid: toUid,
        content: text,
        contentType: 0,
        status: 0, // 发送中
        createTime: now,
      );

      // 更新会话的最后消息
      await _db.conversationDao.updateLastMessage(convId: convId, content: text);

      // 发送到服务端
      final serverMsgId = await _imController.sendMessage(
        convId: convId,
        toUid: toUid,
        content: text,
        contentType: 0,
        msgId: id,
      );

      if (serverMsgId != null) {
        // 更新为已发送，存储服务端消息 ID
        await _messageDao.updateServerMsgId(id, serverMsgId);
        await _messageDao.updateStatus(id, 1);
        Logger.print('ChatLogic — message sent: $id');
      } else {
        // 发送失败
        await _messageDao.updateStatus(id, 3);
        Logger.print('ChatLogic — message send failed: $id');
      }

      return serverMsgId != null;
    } catch (e) {
      Logger.print('ChatLogic — sendTextMessage error: $e');
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// 发送图片消息。
  Future<bool> sendImageMessage(String filePath) async {
    if (filePath.isEmpty || convId.isEmpty) return false;
    isSending.value = true;

    try {
      // 上传图片
      final url = await _imController.uploadFile(filePath);
      if (url == null) {
        Logger.print('ChatLogic — image upload failed');
        isSending.value = false;
        return false;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final toUid = targetUser?.uid ?? '';

      // 先写入本地（状态：发送中），获取自增 id
      final id = await _messageDao.insertFromNotification(
        conversationId: convId,
        fromUid: currentUid,
        toUid: toUid,
        content: url,
        contentType: 1, // 图片
        status: 0,
        createTime: now,
      );

      // 更新会话的最后消息
      await _db.conversationDao.updateLastMessage(convId: convId, content: '[图片]');

      // 发送图片消息到服务端
      final serverMsgId = await _imController.sendMessage(
        convId: convId,
        toUid: toUid,
        content: url,
        contentType: 1,
        msgId: id,
      );

      if (serverMsgId != null) {
        await _messageDao.updateServerMsgId(id, serverMsgId);
        await _messageDao.updateStatus(id, 1);
      } else {
        await _messageDao.updateStatus(id, 3);
      }

      return serverMsgId != null;
    } catch (e) {
      Logger.print('ChatLogic — sendImageMessage error: $e');
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// 重发失败消息。
  Future<bool> resendMessage(Message msg) async {
    await _messageDao.updateStatus(msg.id, 0); // 回到发送中
    final serverMsgId = await _imController.sendMessage(
      convId: convId,
      toUid: msg.toUid ?? '',
      content: msg.content ?? '',
      contentType: msg.contentType,
      msgId: msg.id,
    );
    if (serverMsgId != null) {
      await _messageDao.updateServerMsgId(msg.id, serverMsgId);
      await _messageDao.updateStatus(msg.id, 1);
      // 更新会话的最后消息
      final displayContent = msg.contentType == 1 ? '[图片]' : (msg.content ?? '');
      await _db.conversationDao.updateLastMessage(convId: convId, content: displayContent);
    } else {
      await _messageDao.updateStatus(msg.id, 3);
    }
    return serverMsgId != null;
  }

  /// 清除当前会话未读计数。
  Future<void> clearUnread() async {
    await _db.conversationDao.updateUnreadCount(convId, 0);
  }

  @override
  void onClose() {
    _readTimer?.cancel();
    _subscription?.cancel();
    clearUnread();
    super.onClose();
  }
}
