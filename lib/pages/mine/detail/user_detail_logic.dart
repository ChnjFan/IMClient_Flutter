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
    _fetchFullInfo();
  }

  /// 从服务端拉取用户完整信息，保证每次进入页面都有最新数据。
  Future<void> _fetchFullInfo() async {
    final uid = imLogic.userInfo.value.uid;
    if (uid == null || uid.isEmpty) return;
    try {
      final freshInfo = await imLogic.getUserFullInfo(uid: uid, from: uid);
      imLogic.userFullInfo.value = freshInfo;
    } catch (_) {
      // 拉取失败则使用 IMController 中已有的缓存
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.onClose();
  }

  /// 从服务端重新拉取完整用户信息并同步控制器。
  ///
  /// 从编辑页返回后调用，确保所有字段展示最新数据。
  Future<void> refreshFromUserInfo() async {
    await _fetchFullInfo();
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
