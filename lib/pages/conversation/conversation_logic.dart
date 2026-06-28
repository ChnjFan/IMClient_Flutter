import 'dart:async';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/db/daos/conversation_dao.dart';
import '../../common/utils/logger.dart';
import '../../core/controller/im_controller.dart';
import '../home/home_logic.dart';

class ConversationLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  final IMController _imController = Get.find<IMController>();
  late final ConversationDao _conversationDao;

  final conversations = <Conversation>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<Conversation>>? _subscription;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    _conversationDao = _db.conversationDao;
    _subscription = _conversationDao.watchAll().listen(
      (list) {
        conversations.value = list;
        isLoading.value = false;
        if (list.isNotEmpty) {
          Logger.print(
            'ConversationLogic — watch emitted ${list.length} conversations. '
            'First: convId=${list.first.conversationId}, lastMsg=${list.first.lastMsg}',
          );
        }
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
    _fetchConversationListFromServer();

    // 每次切换到消息 tab 时向服务端拉取最新会话列表
    final homeLogic = Get.find<HomeLogic>();
    ever<int>(homeLogic.index, (idx) {
      if (idx == 0) _fetchConversationListFromServer();
    });
  }

  /// 从服务端拉取会话列表并同步到本地数据库。
  Future<void> _fetchConversationListFromServer() async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      Logger.print('ConversationLogic — fetching conversation list from server');
      final list = await _imController.fetchConversationList();
      Logger.print('ConversationLogic — server returned ${list.length} conversations');
      if (list.isNotEmpty) {
        await _conversationDao.syncFromServerMaps(list);
        Logger.print('ConversationLogic — synced ${list.length} conversations from server');
      }
    } catch (e, stack) {
      Logger.print('ConversationLogic — fetchConversationList error: $e\n$stack');
      isLoading.value = false;
    } finally {
      _isFetching = false;
    }
  }

  /// 格式化消息时间为展示字符串。
  ///
  /// [ms] 毫秒时间戳。规则：
  /// - 今天 → HH:mm
  /// - 昨天 → "昨天"
  /// - 今年内 → MM-dd
  /// - 更早 → yyyy-MM-dd
  static String formatTime(int? ms) {
    if (ms == null) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(dt.year, dt.month, dt.day);

    if (msgDay == today) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    if (msgDay == yesterday) {
      return '昨天';
    }
    if (dt.year == now.year) {
      return '${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    }
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
