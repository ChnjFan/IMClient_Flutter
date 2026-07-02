import 'package:get/get.dart';
import 'user_profile_panel_logic.dart';

class UserProfilePanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfilePanelLogic());
  }
}
