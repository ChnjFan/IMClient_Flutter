import 'package:imclient_flutter/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imclient_flutter/common/models/user/user_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/core/controller/im_controller.dart';

class ApplyFriendLogic extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();

  final message = ''.obs;
  final charCount = 0.obs;
  final isLoading = false.obs;

  late final UserInfo targetUser;
  final IMController imLogic = Get.find<IMController>();

  @override
  void onInit() {
    super.onInit();
    targetUser = Get.arguments as UserInfo;
  }

  static const int _maxLength = 125;

  Future<void> onSend() async {
    String text = messageController.text.trim();
    if (text.isEmpty) return;
    if (isLoading.value) return;
    if (text.length > _maxLength) {
      text = text.substring(0, _maxLength);
    }

    isLoading.value = true;
    try {
      final success = await imLogic.addFriend(
        uid: targetUser.uid ?? '',
        reason: text,
      );
      if (success) {
        Get.back(result: true);
        AppToast.success('好友申请已发送');
      } else {
        AppToast.error('好友申请发送失败，请稍后重试');
      }
    } catch (e) {
      Logger.print('ApplyFriend — send error: $e');
      AppToast.error('好友申请发送失败，请稍后重试');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    messageFocusNode.dispose();
    super.onClose();
  }
}
