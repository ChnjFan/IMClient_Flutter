import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/message_dao.dart';
import '../../common/models/user/user_info.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';

class ChatLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final IMController _imController = Get.find<IMController>();
  late final MessageDao _messageDao;

  // 由路由参数注入
  late final String convId;
  UserInfo? targetUser;

  final messages = <Message>[].obs;
  final convCreateTime = 0.obs;
  final isLoading = true.obs;
  final isSending = false.obs;
  final isRefreshing = false.obs;

  StreamSubscription<List<Message>>? _subscription;
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
  Future<void> _fetchHistoryMessages() async {
    if (_isFetchingHistory) return;
    _isFetchingHistory = true;

    try {
      final servMsgId = await _messageDao.getMaxServerMsgId(convId);
      Logger.print('ChatLogic — fetching history since $servMsgId for conv $convId');

      final list = await _imController.fetchHistoryMessages(
        convId: convId,
        msgId: servMsgId,
      );

      if (list.isNotEmpty) {
        await _messageDao.insertFromHistoryMaps(list);
        Logger.print('ChatLogic — synced ${list.length} history messages');
      }
    } catch (e, stack) {
      Logger.print('ChatLogic — fetchHistoryMessages error: $e\n$stack');
    } finally {
      _isFetchingHistory = false;
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
        await _messageDao.updateStatus(id, 2);
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
        await _messageDao.updateStatus(id, 2);
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
      await _messageDao.updateStatus(msg.id, 2);
    }
    return serverMsgId != null;
  }

  /// 清除当前会话未读计数。
  Future<void> clearUnread() async {
    await _db.conversationDao.updateUnreadCount(convId, 0);
  }

  @override
  void onClose() {
    _subscription?.cancel();
    clearUnread();
    super.onClose();
  }
}
