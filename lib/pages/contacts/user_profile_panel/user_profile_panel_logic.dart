import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import 'package:imclient_flutter/common/db/database.dart';
import 'package:imclient_flutter/common/models/user/user_full_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/validators.dart';
import 'package:imclient_flutter/core/controller/im_controller.dart';

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

  /// 加载用户详细信息：从服务端查询并更新本地数据库。
  Future<void> _loadUserProfile() async {
    final args = Get.arguments;
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
        createTime: Value(Validators.parseTimeToMs(info.createTime)),
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
          createTime: Value(Validators.parseTimeToMs(info.createTime)),
        ),
      );
    }
  }
}
