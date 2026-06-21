import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_navigator.dart';
import '../../../common/models/user/user_full_info.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import 'user_profile_panel_logic.dart';

class UserProfilePanelPage extends StatelessWidget {
  UserProfilePanelPage({super.key});

  final UserProfilePanelLogic logic = Get.find<UserProfilePanelLogic>();

  @override
  Widget build(BuildContext context) {
    final user = logic.userFullInfo;

    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: Text(user.getShowName()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // ---- 头像 & 名称 ----
            _buildAvatarSection(user),
            const SizedBox(height: 24),
            // ---- 信息卡片 ----
            _buildInfoCard(user),
            const SizedBox(height: 32),
            // ---- 操作按钮 ----
            _buildActionButton(user),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(UserFullInfo user) {
    final avatarUrl = user.avatarUrl ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: avatarUrl.isNotEmpty
                  ? Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildAvatarPlaceholder(),
                    )
                  : _buildAvatarPlaceholder(),
            ),
          ),
          const SizedBox(width: 16),
          // 名称 & ID
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.getShowName(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c_0C1C33,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(user.genderIcon, size: 18, color: user.genderColor),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '地区：${(user.region != null && user.region!.isNotEmpty) ? user.region! : '未知'}',
                  style: AppTextStyles.ts_8E9AB0_12sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(UserFullInfo user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('昵称', user.name ?? '未设置'),
          _divider(),
          _buildInfoRow('邮箱', user.email ?? '未设置'),
          _divider(),
          _buildInfoRow('手机号', user.phone ?? '未设置'),
          _divider(),
          _buildInfoRow('备注', user.remark ?? '未设置'),
          _divider(),
          _buildInfoRow('个性签名', user.signature ?? '未设置'),
          _divider(),
          _buildInfoRow('个人简介', user.selfIntro ?? '未设置'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(label, style: AppTextStyles.ts_0C1C33_14sp),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: AppColors.c_8E9AB0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(UserFullInfo user) {
    final isFriend = user.friendStatus == 1;

    if (isFriend) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildButton(
              icon: Icons.chat_bubble_outline,
              text: '发送消息',
              onPressed: () {
                // TODO: 跳转到聊天页面
              },
              fullWidth: true,
            ),
            const SizedBox(height: 12),
            _buildButton(
              icon: Icons.videocam_outlined,
              text: '音视频通话',
              onPressed: () {
                // TODO: 发起音视频通话
              },
              fullWidth: true,
            ),
          ],
        ),
      );
    }

    return _buildButton(
      icon: Icons.person_add_alt_outlined,
      text: '添加好友',
      onPressed: () => AppNavigator.startApplyFriend(userInfo: user),
      fullWidth: true,
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool fullWidth = false,
  }) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.c_0089FF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.c_FFFFFF),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: AppColors.c_FFFFFF),
          ),
        ],
      ),
    );

    if (fullWidth) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 48,
        child: button,
      );
    }

    return SizedBox(height: 48, child: button);
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.c_0089FF_opacity10,
      child: const Icon(
        Icons.person,
        size: 48,
        color: AppColors.c_0089FF,
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.c_F0F2F6,
    );
  }
}
