import 'package:get/get.dart';
import '../../../common/models/user/user_full_info.dart';
import '../../../component/toast.dart';
import '../../../core/controller/im_controller.dart';

/// 好友添加权限选项。
enum FriendPermission {
  deny(0, '禁止添加'),
  verify(1, '需要验证'),
  allow(2, '直接添加');

  final int value;
  final String label;
  const FriendPermission(this.value, this.label);

  static FriendPermission fromValue(int? v) {
    if (v == 0) return FriendPermission.deny;
    if (v == 2) return FriendPermission.allow;
    return FriendPermission.verify;
  }
}

class SettingLogic extends GetxController {
  final IMController _imLogic = Get.find<IMController>();

  UserFullInfo get fullInfo => _imLogic.userFullInfo.value;

  /// 好友添加权限。
  FriendPermission get friendPermission =>
      FriendPermission.fromValue(fullInfo.privacyFriend);

  /// 陌生人私信是否开启（0=禁止，非0=允许）。
  bool get strangerChatEnabled => (fullInfo.privacyChat ?? 0) != 0;

  /// 黑名单是否开启。
  bool get blacklistEnabled => (fullInfo.privacyBlacklist ?? 0) == 1;

  /// 更新好友添加权限。
  Future<void> setFriendPermission(FriendPermission perm) async {
    final uid = fullInfo.uid ?? '';
    final success = await _imLogic.updateUserInfo(
      uid: uid,
      privacyFriend: perm.value,
    );
    if (!success) {
      AppToast.error('更新好友添加权限失败');
    }
  }

  /// 切换陌生人私信开关。
  Future<void> toggleStrangerChat(bool on) async {
    final uid = fullInfo.uid ?? '';
    final success = await _imLogic.updateUserInfo(
      uid: uid,
      privacyChat: on ? 1 : 0,
    );
    if (!success) {
      AppToast.error('更新陌生人私信设置失败');
    }
  }

  /// 切换黑名单开关。
  Future<void> toggleBlacklist(bool on) async {
    final uid = fullInfo.uid ?? '';
    final success = await _imLogic.updateUserInfo(
      uid: uid,
      privacyBlacklist: on ? 1 : 0,
    );
    if (!success) {
      AppToast.error('更新黑名单设置失败');
    }
  }
}
