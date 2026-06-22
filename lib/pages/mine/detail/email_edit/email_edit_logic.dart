import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/controller/im_controller.dart';

class EmailEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController emailCtrl;
  late final FocusNode emailFocus;

  final RxBool hasChanged = false.obs;
  final RxBool hasText = false.obs;

  String _originalEmail = '';

  @override
  void onInit() {
    super.onInit();
    _originalEmail = (imLogic.userInfo.value.email ?? '').trim();
    emailCtrl = TextEditingController(text: _originalEmail);
    emailFocus = FocusNode();
    hasText.value = _originalEmail.isNotEmpty;
  }

  void onTextChanged(String text) {
    final t = text.trim();
    hasChanged.value = t != _originalEmail;
    hasText.value = t.isNotEmpty;
  }

  void onClear() {
    emailCtrl.clear();
    emailFocus.requestFocus();
  }

  /// 校验邮箱格式
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    emailFocus.dispose();
    super.onClose();
  }

  Future<void> save() async {
    final email = emailCtrl.text.trim();
    if (email.isEmpty) {
      AppToast.show('邮箱不能为空');
      return;
    }
    if (!_isValidEmail(email)) {
      AppToast.show('请输入正确的邮箱格式');
      return;
    }

    String uid = imLogic.userInfo.value.uid ?? '';
    final success = await imLogic.updateUserInfo(uid: uid, email: email);
    if (!success) {
      AppToast.error('更新邮箱失败');
      return;
    }
    Get.back(result: email);
  }
}
