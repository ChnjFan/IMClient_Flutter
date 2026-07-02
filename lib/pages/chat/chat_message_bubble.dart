import 'dart:io';
import 'package:flutter/material.dart';
import '../../common/db/database.dart';
import '../../common/styles/colors.dart';

/// 聊天消息气泡组件。
///
/// 支持文本和图片两种类型，以及发送中/已发送/失败/已读等状态。
class ChatMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMine;
  final String? myAvatarUrl;
  final String? peerAvatarUrl;
  final VoidCallback? onResend;
  final VoidCallback? onImageTap;
  final VoidCallback? onMyAvatarTap;
  final VoidCallback? onPeerAvatarTap;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isMine,
    this.myAvatarUrl,
    this.peerAvatarUrl,
    this.onResend,
    this.onImageTap,
    this.onMyAvatarTap,
    this.onPeerAvatarTap,
  });

  static const double _avatarSize = 42;

  Color get _bubbleColor =>
      isMine ? AppColors.c_0089FF : AppColors.c_FFFFFF;

  Color get _textColor =>
      isMine ? AppColors.c_FFFFFF : AppColors.c_0C1C33;

  @override
  Widget build(BuildContext context) {
    final isImage = message.contentType == 1;
    final isFailed = message.status == 3;
    final isSending = message.status == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 对方头像（左侧）
          if (!isMine) _buildAvatar(peerAvatarUrl, onTap: onPeerAvatarTap),
          if (!isMine) const SizedBox(width: 8),
          // 发送状态指示器（消息气泡左侧）
          if (isMine) _buildStatusIndicator(isFailed, isSending),
          if (isMine) const SizedBox(width: 6),
          // 消息内容
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.55,
              ),
              decoration: BoxDecoration(
                color: _bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMine ? 16 : 4),
                  topRight: Radius.circular(isMine ? 4 : 16),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child:
                  isImage ? _buildImageContent() : _buildTextContent(),
            ),
          ),
          // 自己的头像（右侧）
          if (isMine) const SizedBox(width: 8),
          if (isMine) _buildAvatar(myAvatarUrl, onTap: onMyAvatarTap),
        ],
      ),
    );
  }

  /// 发送状态指示器：发送中显示转圈，失败显示错误图标。
  Widget _buildStatusIndicator(bool isFailed, bool isSending) {
    if (isSending) {
      return const SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          color: AppColors.c_8E9AB0,
        ),
      );
    }
    if (isFailed) {
      return GestureDetector(
        onTap: onResend,
        child: const Icon(Icons.error_outline,
            size: 14, color: AppColors.c_FF381F),
      );
    }
    return const SizedBox.shrink();
  }

  static const BorderRadius _avatarRadius = BorderRadius.all(Radius.circular(8));

  Widget _buildAvatar(String? url, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _avatarSize,
        height: _avatarSize,
        decoration: BoxDecoration(
          borderRadius: _avatarRadius,
          border: Border.all(
            color: AppColors.c_F0F2F6,
            width: 0.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: url != null && url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _defaultAvatar(),
              )
            : _defaultAvatar(),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.c_F0F2F6,
        borderRadius: _avatarRadius,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          color: AppColors.c_0089FF_opacity10,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: const Icon(
          Icons.person,
          size: 22,
          color: AppColors.c_0089FF,
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        message.content ?? '',
        style: TextStyle(
          fontSize: 15,
          color: _textColor,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildImageContent() {
    final content = message.content ?? '';
    return GestureDetector(
      onTap: onImageTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 180,
          height: 180,
          child: content.startsWith('http')
              ? Image.network(
                  content,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: AppColors.c_8E9AB0,
                  ),
                )
              : Image.file(
                  File(content),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: AppColors.c_8E9AB0,
                  ),
                ),
        ),
      ),
    );
  }
}
