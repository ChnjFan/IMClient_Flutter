import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/db/database.dart';
import '../../../core/controller/im_controller.dart';

class AliasEditLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  final AppDatabase db = Get.find<AppDatabase>();

  late final TextEditingController aliasCtrl;
  late final FocusNode aliasFocus;

  final RxBool hasChanged = false.obs;
  final RxBool hasText = false.obs;

  String _originalAlias = '';
  String _friendId = '';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _friendId = args['friendId'] as String? ?? '';
      _originalAlias = (args['alias'] as String? ?? '').trim();
    }
    aliasCtrl = TextEditingController(text: _originalAlias);
    aliasFocus = FocusNode();
    hasText.value = _originalAlias.isNotEmpty;
  }

  void onTextChanged(String text) {
    final t = text.trim();
    hasChanged.value = t != _originalAlias;
    hasText.value = t.isNotEmpty;
  }

  void onClear() {
    aliasCtrl.clear();
    aliasFocus.requestFocus();
  }

  @override
  void onClose() {
    aliasCtrl.dispose();
    aliasFocus.dispose();
    super.onClose();
  }

  Future<void> save() async {
    final newAlias = aliasCtrl.text.trim();
    if (newAlias == _originalAlias) {
      Get.back();
      return;
    }

    // 发送更新好友信息请求到服务端
    final success = await imLogic.updateFriend(friendId: _friendId, alias: newAlias);
    if (!success) {
      AppToast.error('更新备注失败');
      return;
    }

    // 更新本地数据库
    await db.friendDao.updateAlias(_friendId, newAlias);

    Get.back(result: newAlias);
  }
}
