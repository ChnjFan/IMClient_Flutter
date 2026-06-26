import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import 'package:imclient_flutter/common/db/database.dart';
import 'package:imclient_flutter/common/models/user/user_full_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/time_utils.dart';
import 'package:imclient_flutter/component/toast.dart';
import 'package:imclient_flutter/core/controller/im_controller.dart';
import 'package:imclient_flutter/routes/app_navigator.dart';

class UserProfilePanelLogic extends GetxController {
  final IMController _imController = Get.find<IMController>();
  final AppDatabase _db = Get.find<AppDatabase>();

  final isLoading = true.obs;
  final loadError = ''.obs;
  final userFullInfo = Rx<UserFullInfo?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  /// 加载用户详细信息：优先使用传入的 [UserFullInfo]，否则从服务端查询。
  Future<void> _loadUserProfile() async {
    final args = Get.arguments;

    // 如果调用方已经传入了完整的 UserFullInfo，直接使用，避免重复请求
    if (args is UserFullInfo) {
      userFullInfo.value = args;
      isLoading.value = false;
      await _syncToLocalDB(args);
      return;
    }

    final String? uid = _extractUid(args);

    if (uid == null || uid.isEmpty) {
      loadError.value = '参数错误';
      isLoading.value = false;
      return;
    }

    try {
      final fromUid = _imController.userInfo.value.uid;
      final info = await _imController.getUserFullInfo(
        uid: uid,
        from: fromUid ?? '',
      );
      userFullInfo.value = info;

      // 将查询到的用户信息更新到本地数据库
      await _syncToLocalDB(info);
    } catch (e) {
      Logger.print('UserProfilePanelLogic — loadUserProfile error: $e');
      loadError.value = '加载失败';
    } finally {
      isLoading.value = false;
    }
  }

  /// 从 arguments 中提取用户 ID，兼容 [String] 和 [UserFullInfo] 两种类型。
  String? _extractUid(dynamic args) {
    if (args is String) return args;
    if (args is UserFullInfo) return args.uid;
    return null;
  }

  /// 将服务端查询到的用户信息同步到本地数据库。
  Future<void> _syncToLocalDB(UserFullInfo info) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // 更新 user_profiles 表
    await _db.userProfileDao.upsert(
      UserProfilesCompanion(
        userId: Value(info.uid ?? ''),
        name: Value(info.name),
        alias: Value(info.alias),
        email: Value(info.email),
        avatarUrl: Value(info.avatarUrl),
        region: Value(info.region),
        gender: Value(info.gender ?? 0),
        isSelf: const Value(false),
        updateTime: Value(now),
        createTime: Value(TimeUtils.parseServerTime(info.createTime) ?? 0),
      ),
    );

    // 更新 friends 表的备注（如果好友关系存在）
    if (info.friendStatus != null && info.friendStatus! > 0) {
      await _db.friendDao.upsert(
        FriendsCompanion(
          userId: Value(info.uid ?? ''),
          alias: Value(info.alias),
          status: Value(info.friendStatus ?? 1),
          updateTime: Value(now),
          createTime: Value(TimeUtils.parseServerTime(info.createTime) ?? 0),
        ),
      );
    }
  }

  /// 跳转到备注编辑页面，返回后更新本地状态。
  Future<void> goAliasEdit() async {
    final user = userFullInfo.value;
    if (user == null) return;

    final uid = user.uid ?? '';
    final newAlias = await AppNavigator.startAliasEdit(
      friendId: uid,
      alias: user.alias ?? '',
    );

    if (newAlias is String && newAlias.isNotEmpty && newAlias != user.alias) {
      user.alias = newAlias;
      userFullInfo.refresh();
    }
  }

  // ---- 好友设置操作 ----

  Future<void> toggleStar() async {
    final user = userFullInfo.value;
    if (user == null) return;
    final uid = user.uid ?? '';
    final newVal = (user.isStarred ?? 0) == 1 ? 0 : 1;
    final success = await _imController.updateFriend(friendId: uid, isStarred: newVal);
    if (success) {
      user.isStarred = newVal;
      _updateLocalFriendField(uid, isStarred: newVal);
      userFullInfo.refresh();
    } else {
      AppToast.error('操作失败');
    }
  }

  Future<void> toggleBlock() async {
    final user = userFullInfo.value;
    if (user == null) return;
    final uid = user.uid ?? '';
    final isBlocked = (user.friendStatus ?? 0) == 4;
    final newStatus = isBlocked ? 1 : 4;
    final success = await _imController.updateFriend(friendId: uid, status: newStatus);
    if (success) {
      user.friendStatus = newStatus;
      await _db.friendDao.updateStatus(uid, newStatus);
      userFullInfo.refresh();
    } else {
      AppToast.error('操作失败');
    }
  }

  Future<void> toggleHidden() async {
    final user = userFullInfo.value;
    if (user == null) return;
    final uid = user.uid ?? '';
    final newVal = (user.isHidden ?? 0) == 1 ? 0 : 1;
    final success = await _imController.updateFriend(friendId: uid, isHidden: newVal);
    if (success) {
      user.isHidden = newVal;
      _updateLocalFriendField(uid, isHidden: newVal);
      userFullInfo.refresh();
    } else {
      AppToast.error('操作失败');
    }
  }

  Future<void> toggleBlacklist() async {
    final user = userFullInfo.value;
    if (user == null) return;
    final uid = user.uid ?? '';
    final isBlacklisted = (user.friendStatus ?? 0) == 2;
    final newStatus = isBlacklisted ? 1 : 2;
    final success = await _imController.updateFriend(friendId: uid, status: newStatus);
    if (success) {
      user.friendStatus = newStatus;
      await _db.friendDao.updateStatus(uid, newStatus);
      userFullInfo.refresh();
    } else {
      AppToast.error('操作失败');
    }
  }

  Future<void> deleteContact() async {
    final user = userFullInfo.value;
    if (user == null) return;
    final uid = user.uid ?? '';
    final success = await _imController.deleteFriend(friendId: uid);
    if (success) {
      await _db.friendDao.deleteByUserId(uid);
      AppToast.success('已删除联系人');
      Get.back();
    } else {
      AppToast.error('删除失败');
    }
  }

  /// 更新本地 Friends 表中的单个字段。
  Future<void> _updateLocalFriendField(
    String userId, {
    int? isStarred,
    int? isHidden,
  }) async {
    if (isStarred != null) await _db.friendDao.updateIsStarred(userId, isStarred);
    if (isHidden != null) await _db.friendDao.updateIsHidden(userId, isHidden);
  }

  // ---- getters ----

  bool get isFriend => (userFullInfo.value?.friendStatus ?? 0) == 1;

  bool get isBlacklisted => (userFullInfo.value?.friendStatus ?? 0) == 2;
}
