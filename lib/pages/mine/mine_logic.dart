import 'package:imclient_flutter/component/toast.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import '../../common/db/database.dart';
import '../../common/models/user/user_info.dart';
import '../../common/models/user/user_full_info.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/time_utils.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';

class MineLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  final AppDatabase dbLogic = Get.find<AppDatabase>();

  String get nickname => imLogic.userInfo.value.name ?? '';
  String get email => imLogic.userInfo.value.email ?? '';
  String get avatarUrl => imLogic.userInfo.value.avatarUrl ?? '';

  @override
  void onInit() {
    super.onInit();
    _loadFromLocalDB();
  }

  /// 从本地 DB 加载自己的用户资料到内存（isSelf=true）。
  Future<void> _loadFromLocalDB() async {
    final selfProfile = await dbLogic.userProfileDao.getSelf();
    if (selfProfile != null) {
      imLogic.userInfo.value = UserInfo(
        uid: selfProfile.userId,
        name: selfProfile.name,
        alias: selfProfile.alias,
        email: selfProfile.email,
        avatarUrl: selfProfile.avatarUrl,
        ex: selfProfile.ex,
      );
    }
  }

  /// 点击头像区域：优先从 DB 加载已有数据；
  /// 若无缓存则发送 searchUserReq 从服务端获取，存储到 DB 后跳转。
  Future<void> fetchUserDetail() async {
    try {
      final selfProfile = await dbLogic.userProfileDao.getSelf();
      if (selfProfile != null) {
        _updateLocalCache(selfProfile);
      } else {
        final uid = imLogic.userInfo.value.uid;
        if (uid != null && uid.isNotEmpty) {
          final freshInfo = await imLogic.getUserFullInfo(uid: uid, from: uid);
          imLogic.userInfo.value = freshInfo;
          imLogic.userFullInfo.value = freshInfo;
          // 同步到本地数据库 UserProfiles 表（自己的信息，isSelf=true）
          await _saveToLocalDB(freshInfo);
        }
      }
    } catch (e) {
      Logger.print('MineLogic — fetchUserDetail failed: $e');
      AppToast.error('获取用户信息失败，显示本地缓存');
    }
    AppNavigator.startUserDetail();
  }

  /// 将自己的用户信息写入 UserProfiles 表。
  Future<void> _saveToLocalDB(dynamic info) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final createTime = TimeUtils.parseServerTime(info.createTime) ?? now;
    await dbLogic.userProfileDao.upsert(
      UserProfilesCompanion(
        userId: Value(info.uid?.toString() ?? ''),
        name: Value(info.name),
        alias: Value(info.alias),
        email: Value(info.email),
        avatarUrl: Value(info.avatarUrl),
        ex: Value(info.ex),
        isSelf: const Value(true),
        updateTime: Value(now),
        createTime: Value(createTime),
      ),
    );
  }
  
  void _updateLocalCache(UserProfile selfProfile) {
    imLogic.userInfo.value = UserInfo(
        uid: selfProfile.userId,
        name: selfProfile.name,
        alias: selfProfile.alias,
        email: selfProfile.email,
        avatarUrl: selfProfile.avatarUrl,
        ex: selfProfile.ex,
      );
      imLogic.userFullInfo.value = UserFullInfo(
        uid: selfProfile.userId,
        name: selfProfile.name,
        alias: selfProfile.alias,
        email: selfProfile.email,
        avatarUrl: selfProfile.avatarUrl,
        ex: selfProfile.ex,
      );
  }
}
