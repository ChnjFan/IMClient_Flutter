import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/im_controller.dart';

class UserDetailLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController nameCtrl;
  late final TextEditingController emailCtrl;

  @override
  void onInit() {
    super.onInit();
    final info = imLogic.userInfo.value;
    nameCtrl = TextEditingController(text: info.name ?? '');
    emailCtrl = TextEditingController(text: info.email ?? '');
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.onClose();
  }

  /// Sync controllers from userInfo after returning from edit pages.
  void refreshFromUserInfo() {
    final info = imLogic.userInfo.value;
    nameCtrl.text = info.name ?? '';
    emailCtrl.text = info.email ?? '';
  }
}
