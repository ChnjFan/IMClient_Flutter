import 'package:get/get.dart';
import 'package:imclient_flutter/common/models/user/user_full_info.dart';

class UserProfilePanelLogic extends GetxController {
  late final UserFullInfo userFullInfo;

  @override
  void onInit() {
    super.onInit();
    userFullInfo = Get.arguments as UserFullInfo;
  }
}
