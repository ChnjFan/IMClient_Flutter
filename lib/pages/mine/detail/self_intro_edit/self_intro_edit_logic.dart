import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../component/toast.dart';
import '../../../../core/controller/im_controller.dart';

class SelfIntroEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController ctrl;
  late final FocusNode focus;

  final RxBool hasChanged = false.obs;
  final RxBool hasText = false.obs;

  String _original = '';

  @override
  void onInit() {
    super.onInit();
    _original = (imLogic.userFullInfo.value.selfIntro ?? '').trim();
    ctrl = TextEditingController(text: _original);
    focus = FocusNode();
    hasText.value = _original.isNotEmpty;
  }

  void onTextChanged(String text) {
    final t = text.trim();
    hasChanged.value = t != _original;
    hasText.value = t.isNotEmpty;
  }

  void onClear() {
    ctrl.clear();
    focus.requestFocus();
  }

  @override
  void onClose() {
    ctrl.dispose();
    focus.dispose();
    super.onClose();
  }

  Future<void> save() async {
    final selfIntro = ctrl.text.trim();
    String uid = imLogic.userInfo.value.uid ?? '';
    final success = await imLogic.updateUserInfo(uid: uid, selfIntro: selfIntro);
    if (!success) {
      AppToast.error('更新自我介绍失败');
      return;
    }
    Get.back(result: selfIntro);
  }
}
