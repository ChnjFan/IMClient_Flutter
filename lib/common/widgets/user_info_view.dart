import 'package:flutter/material.dart';
import '../res/images.dart';
import '../styles/colors.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({
    super.key,
    required this.nickname,
    required this.email,
    this.avatarUrl = '',
    this.onTap,
  });

  final String nickname;
  final String email;
  final String avatarUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 头像
            _buildAvatar(),
            const SizedBox(width: 18),
            // 昵称 + 邮箱
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nickname.isNotEmpty ? nickname : '昵称',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.c_0C1C33,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email.isNotEmpty ? email : '邮箱',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.c_8E9AB0,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.c_8E9AB0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.c_0089FF_opacity10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: avatarUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, e, s) => const Icon(
                  AppImages.mineTabSel,
                  size: 30,
                  color: AppColors.c_0089FF,
                ),
              ),
            )
          : const Icon(
              AppImages.mineTabSel,
              size: 30,
              color: AppColors.c_0089FF,
            ),
    );
  }
}
