import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/controller/im_controller.dart';

class NameEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController nameCtrl;
  late final FocusNode nameFocus;

  final RxBool hasChanged = false.obs;
  final RxBool hasText = false.obs;

  String _originalName = '';

  @override
  void onInit() {
    super.onInit();
    _originalName = (imLogic.userInfo.value.name ?? '').trim();
    nameCtrl = TextEditingController(text: _originalName);
    nameFocus = FocusNode();
    hasText.value = _originalName.isNotEmpty;
  }

  void onTextChanged(String text) {
    final t = text.trim();
    hasChanged.value = t != _originalName;
    hasText.value = t.isNotEmpty;
  }

  void onClear() {
    nameCtrl.clear();
    nameFocus.requestFocus();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    nameFocus.dispose();
    super.onClose();
  }

  Future<void> save() async {
    final newName = nameCtrl.text.trim();
    if (newName.isEmpty) {
      Get.snackbar('', '昵称不能为空', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    String uid = imLogic.userInfo.value.userID ?? '';
    final success = await imLogic.updateUserInfo(uid: uid, name: newName);
    if (!success) {
      Get.snackbar('', '更新昵称失败', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.back(result: newName);
  }
}
