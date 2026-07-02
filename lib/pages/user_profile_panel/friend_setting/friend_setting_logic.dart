import 'package:get/get.dart';
import '../../../component/toast.dart';
import '../user_profile_panel_logic.dart';

class FriendSettingLogic extends GetxController {
  final UserProfilePanelLogic _panelLogic = Get.find<UserProfilePanelLogic>();

  String get friendId => _panelLogic.userFullInfo.value?.uid ?? '';

  bool get isStarred => (_panelLogic.userFullInfo.value?.isStarred ?? 0) == 1;
  bool get isBlacklisted => (_panelLogic.userFullInfo.value?.friendStatus ?? 0) == 2;
  bool get isBlocked => (_panelLogic.userFullInfo.value?.friendStatus ?? 0) == 4;
  bool get isHidden => (_panelLogic.userFullInfo.value?.isHidden ?? 0) == 1;

  Future<void> toggleStar() async {
    await _panelLogic.toggleStar();
    update();
    AppToast.show(isStarred ? '已设为星标好友' : '已取消星标');
  }

  Future<void> toggleBlacklist() async {
    await _panelLogic.toggleBlacklist();
    update();
    AppToast.show(isBlacklisted ? '已加入黑名单' : '已移除黑名单');
  }

  Future<void> toggleBlock() async {
    await _panelLogic.toggleBlock();
    update();
    AppToast.show(isBlocked ? '已屏蔽好友消息' : '已取消屏蔽');
  }

  Future<void> toggleHidden() async {
    await _panelLogic.toggleHidden();
    update();
    AppToast.show(isHidden ? '已隐藏好友' : '已取消隐藏');
  }

  Future<void> deleteContact() async {
    await _panelLogic.deleteContact();
  }
}
