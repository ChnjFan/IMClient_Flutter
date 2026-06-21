import 'dart:async';
import 'package:get/get.dart';
import '../../../common/db/database.dart';
import '../../../common/db/daos/friend_request_dao.dart';
import '../../../common/utils/logger.dart';
import '../../../core/controller/im_controller.dart';

class FriendApplysLogic extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();
  late final FriendRequestDao _requestDao;
  final IMController imLogic = Get.find<IMController>();

  final requests = <FriendRequestWithProfile>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<FriendRequestWithProfile>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _requestDao = _db.friendRequestDao;
    final userId = imLogic.userInfo.value.userID ?? '';
    if (userId.isNotEmpty) {
      // 1. 先订阅本地数据库变化
      _subscription = _requestDao
          .watchIncomingWithProfile(userId)
          .listen(
            (list) {
              requests.value = list;
              isLoading.value = false;
            },
            onError: (_) {
              isLoading.value = false;
            },
          );

      // 2. 再向服务端拉取最新申请列表
      _fetchFromServer(userId);
    } else {
      isLoading.value = false;
    }
  }

  /// 向服务端请求好友申请列表并同步到本地数据库。
  Future<void> _fetchFromServer(String userId) async {
    try {
      final sinceId = await _requestDao.getMaxId();
      final list = await imLogic.fetchFriendApplys(sinceId: sinceId);
      if (list.isNotEmpty) {
        await _requestDao.syncIncomingFromServer(userId, list, sinceId: sinceId);
      }
    } catch (e) {
      Logger.print('FriendApplysLogic — fetchFromServer error: $e');
    }
  }

  /// 同意好友申请。
  Future<void> accept(FriendRequestWithProfile item) async {
    final success = await imLogic.acceptFriend(fromUid: item.request.fromUid);
    if (success) {
      await _requestDao.handle(item.request.id, true);
      requests.refresh();
    } else {
      Get.snackbar('操作失败', '同意好友申请失败，请稍后重试');
    }
  }

  /// 拒绝好友申请。
  Future<void> reject(FriendRequestWithProfile item) async {
    final success = await imLogic.rejectFriend(fromUid: item.request.fromUid);
    if (success) {
      await _requestDao.handle(item.request.id, false);
      requests.refresh();
    } else {
      Get.snackbar('操作失败', '拒绝好友申请失败，请稍后重试');
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
