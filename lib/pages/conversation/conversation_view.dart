import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/db/database.dart';
import '../../common/models/user/user_info.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../core/controller/im_controller.dart';
import '../../routes/app_navigator.dart';
import '../chat/chat_logic.dart';
import 'conversation_logic.dart';

class ConversationPage extends StatelessWidget {
  ConversationPage({super.key});

  final ConversationLogic logic = Get.find<ConversationLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.home),
      ),
      body: Obx(() {
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

        if (logic.conversations.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: logic.conversations.length,
          separatorBuilder: (_, _) => const Divider(
            height: 1,
            indent: 72,
            endIndent: 16,
            color: AppColors.c_F0F2F6,
          ),
          itemBuilder: (context, index) {
            final conv = logic.conversations[index];
            return _buildConversationItem(conv);
          },
        );
      }),
    );
  }

  Widget _buildConversationItem(Conversation conv) {
    final hasUnread = conv.unreadCount > 0;
    final isMuted = conv.isMute == 1;

    return InkWell(
      onTap: () {
        final currentUid = Get.find<IMController>().userInfo.value.uid ?? '';
        final peerUid = ChatLogic.extractPeerUid(conv.conversationId, currentUid);
        final targetUser = UserInfo(
          uid: peerUid,
          name: conv.title,
          avatarUrl: conv.avatarUrl,
        );
        AppNavigator.startChat(convId: conv.conversationId, targetUser: targetUser);
      },
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.c_FFFFFF,
        child: Row(
          children: [
            // 头像 + 未读角标
            _buildAvatarWithBadge(conv.avatarUrl, conv.type,
                hasUnread: hasUnread, unreadCount: conv.unreadCount),
            const SizedBox(width: 12),
            // 标题/时间 + 最后消息/免打扰
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 第一行：标题 + 时间
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv.title ?? conv.conversationId,
                          style: AppTextStyles.ts_0C1C33_14sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ConversationLogic.formatTime(conv.lastMsgTime),
                        style: AppTextStyles.ts_8E9AB0_12sp,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // 第二行：最后消息 + 免打扰图标
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv.lastMsg ?? '',
                          style: AppTextStyles.ts_8E9AB0_12sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isMuted) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.block_rounded,
                          size: 14,
                          color: AppColors.c_8E9AB0,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarWithBadge(String? avatarUrl, int type,
      {bool hasUnread = false, int unreadCount = 0}) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 头像
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.c_0089FF_opacity10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              type == 1 ? Icons.group_rounded : Icons.person_rounded,
              size: 28,
              color: AppColors.c_0089FF,
            ),
          ),
          // 未读角标（头像右上角）
          if (hasUnread)
            Positioned(
              right: -4,
              top: -4,
              child: _buildUnreadBadge(unreadCount),
            ),
        ],
      ),
    );
  }

  Widget _buildUnreadBadge(int count) {
    return Container(
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.c_0089FF_opacity10,
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无消息',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.c_8E9AB0,
            ),
          ),
        ],
      ),
    );
  }
}
