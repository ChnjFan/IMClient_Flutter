import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/controller/im_controller.dart';

class PhoneEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController phoneCtrl;
  late final FocusNode phoneFocus;

  final RxBool hasChanged = false.obs;
  final RxBool hasText = false.obs;

  String _originalPhone = '';

  @override
  void onInit() {
    super.onInit();
    _originalPhone = (imLogic.userFullInfo.value.phone ?? '').trim();
    phoneCtrl = TextEditingController(text: _originalPhone);
    phoneFocus = FocusNode();
    hasText.value = _originalPhone.isNotEmpty;
  }

  void onTextChanged(String text) {
    final t = text.trim();
    hasChanged.value = t != _originalPhone;
    hasText.value = t.isNotEmpty;
  }

  void onClear() {
    phoneCtrl.clear();
    phoneFocus.requestFocus();
  }

  @override
  void onClose() {
    phoneCtrl.dispose();
    phoneFocus.dispose();
    super.onClose();
  }

  Future<void> save() async {
    final phone = phoneCtrl.text.trim();
    if (phone.isEmpty) {
      AppToast.show('手机号不能为空');
      return;
    }

    String uid = imLogic.userInfo.value.uid ?? '';
    final success = await imLogic.updateUserInfo(uid: uid, phone: phone);
    if (!success) {
      AppToast.error('更新手机号失败');
      return;
    }

    Get.back(result: phone);
  }
}
