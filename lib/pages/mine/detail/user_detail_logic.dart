import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/models/user/user_full_info.dart';
import '../../../component/toast.dart';
import '../../../core/controller/im_controller.dart';

class UserDetailLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();

  late final TextEditingController nameCtrl;
  late final TextEditingController emailCtrl;

  /// 用户完整信息
  UserFullInfo get fullInfo => imLogic.userFullInfo.value;

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

  /// 性别展示文本
  String genderText(int? gender) {
    switch (gender) {
      case 1: return '男';
      case 2: return '女';
      default: return '未设置';
    }
  }

  /// 格式化时间字符串展示
  String formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '未知';
    return timeStr;
  }

  /// 更新用户字段（本地 + 服务端）
  Future<void> updateField(String label, String value) async {
    String uid = imLogic.userInfo.value.uid ?? '';
    switch (label) {
      case '性别':
        final success = await imLogic.updateUserInfo(uid: uid, gender: int.tryParse(value) ?? 0);
        if (!success) {
          AppToast.error('更新性别失败');
          return;
        }
        break;
      case '生日':
        final success = await imLogic.updateUserInfo(uid: uid, birthday: value);
        if (!success) {
          AppToast.error('更新生日失败');
          return;
        }
        break;
      case '地区':
        final success = await imLogic.updateUserInfo(uid: uid, region: value);
        if (!success) {
          AppToast.error('更新地区失败');
          return;
        }
        break;
      default:
        return;
    }
  }
}
