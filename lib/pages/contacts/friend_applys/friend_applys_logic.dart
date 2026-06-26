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

  /// 合并后的全部好友申请（收到 + 发出），按 createTime 降序排列。
  final allRequests = <FriendRequestWithProfile>[].obs;
  final isLoading = true.obs;

  StreamSubscription<List<FriendRequestWithProfile>>? _incomingSub;
  StreamSubscription<List<FriendRequestWithProfile>>? _outgoingSub;

  List<FriendRequestWithProfile> _incoming = [];
  List<FriendRequestWithProfile> _outgoing = [];
  bool _incomingLoaded = false;
  bool _outgoingLoaded = false;

  @override
  void onInit() {
    super.onInit();
    _requestDao = _db.friendRequestDao;
    final userId = imLogic.userInfo.value.uid ?? '';
    if (userId.isNotEmpty) {
      // 订阅本地数据库变化（全部状态：待处理 / 已同意 / 已拒绝）
      _incomingSub = _requestDao
          .watchAllIncomingWithProfile(userId)
          .listen((list) {
            _incoming = list;
            _incomingLoaded = true;
            _merge();
          });

      _outgoingSub = _requestDao
          .watchAllOutgoingWithProfile(userId)
          .listen((list) {
            _outgoing = list;
            _outgoingLoaded = true;
            _merge();
          });

      // 向服务端拉取最新申请列表
      _fetchFromServer(userId);
    } else {
      isLoading.value = false;
    }
  }

  /// 将收到和发出的申请合并，按时间倒序排列。
  void _merge() {
    final merged = <FriendRequestWithProfile>[..._incoming, ..._outgoing];
    merged.sort((a, b) => b.request.createTime.compareTo(a.request.createTime));
    allRequests.value = merged;
    if (_incomingLoaded && _outgoingLoaded) {
      isLoading.value = false;
    }
  }

  /// 向服务端请求好友申请列表并同步到本地数据库。
  Future<void> _fetchFromServer(String userId) async {
    try {
      final sinceUpdateTime = await _requestDao.getMaxUpdateTime();
      final list = await imLogic.fetchFriendApplys(sinceUpdateTime: sinceUpdateTime);
      if (list.isNotEmpty) {
        await _requestDao.syncFromServer(userId, list, sinceUpdateTime: sinceUpdateTime);
      }
    } catch (e) {
      Logger.print('FriendApplysLogic — fetchFromServer error: $e');
    }
  }

  /// 判断是否为当前用户发出的申请。
  bool isOutgoing(FriendRequestWithProfile item) {
    final currentUid = imLogic.userInfo.value.uid ?? '';
    return item.request.uid == currentUid;
  }

  /// 同意好友申请。成功返回 true。
  Future<bool> accept(FriendRequestWithProfile item) async {
    final success = await imLogic.acceptFriend(fromUid: item.request.uid);
    if (success) {
      await _requestDao.handle(item.request.id, true);
      return true;
    }
    return false;
  }

  /// 拒绝好友申请。成功返回 true。
  Future<bool> reject(FriendRequestWithProfile item) async {
    final success = await imLogic.rejectFriend(fromUid: item.request.uid);
    if (success) {
      await _requestDao.handle(item.request.id, false);
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    _incomingSub?.cancel();
    _outgoingSub?.cancel();
    super.onClose();
  }
}
