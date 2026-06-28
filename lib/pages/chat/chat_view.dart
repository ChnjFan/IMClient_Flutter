import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imclient_flutter/common/res/strings.dart';
import 'package:imclient_flutter/common/styles/text_styles.dart';
import '../../common/models/user/user_info.dart';
import '../../common/styles/colors.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import '../conversation/conversation_logic.dart';
import 'chat_input_bar.dart';
import 'chat_message_bubble.dart';
import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ChatLogic>();
    final targetUser = logic.targetUser;

    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // TODO: 跳转到用户资料页
          },
          child: Text(
            targetUser?.getShowName() ?? '聊天',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.c_0C1C33,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: _buildMessageList(logic),
          ),
          // 底部输入栏
          ChatInputBar(logic: logic),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatLogic logic) {
    return Obx(() {
      if (logic.isLoading.value) {
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.c_0089FF,
            ),
          ),
        );
      }

      if (logic.messages.isEmpty) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final timeStr = ConversationLogic.formatTime(logic.convCreateTime.value);
                  if (timeStr.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      timeStr,
                      style: AppTextStyles.ts_8E9AB0_12sp,
                    ),
                  );
                }),
                const Text(
                  AppStrings.newConversation,
                  style: AppTextStyles.ts_8E9AB0_12sp,
                ),
              ],
            ),
          ),
        );
      }

      final myAvatarUrl = Get.find<IMController>().userInfo.value.avatarUrl;
      final peerAvatarUrl = logic.targetUser?.avatarUrl;

      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: logic.messages.length,
        itemBuilder: (context, index) {
          final msg = logic.messages[index];
          final isMine = msg.fromUid == logic.currentUid;
          return ChatMessageBubble(
            message: msg,
            isMine: isMine,
            myAvatarUrl: myAvatarUrl,
            peerAvatarUrl: peerAvatarUrl,
            onResend: msg.status == 2 ? () => logic.resendMessage(msg) : null,
            onImageTap: msg.contentType == 1
                ? () => _previewImage(context, msg.content ?? '')
                : null,
            onMyAvatarTap: () => AppNavigator.startUserDetail(),
            onPeerAvatarTap: logic.targetUser != null
                ? () => AppNavigator.startUserProfilePanel(userInfo: logic.targetUser)
                : null,
          );
        },
      );
    });
  }

  void _previewImage(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: imageUrl.startsWith('http')
                ? Image.network(imageUrl, fit: BoxFit.contain)
                : Image.file(File(imageUrl), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
