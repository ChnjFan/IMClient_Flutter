import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../common/res/strings.dart';
import '../../routes/app_navigator.dart';
import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final MineLogic logic = Get.find<MineLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // ---- 头像 & 用户信息 ----
            _buildUserHeader(),
            const SizedBox(height: 24),
            // ---- 菜单项 ----
            _buildMenuSection(context),
            const Spacer(),
            // ---- 退出登录 ----
            _buildLogoutButton(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  /// 头像 + 昵称 + 邮箱区域
  Widget _buildUserHeader() {
    return GestureDetector(
      onTap: () => AppNavigator.startUserDetail(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 头像
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.c_0089FF_opacity10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                AppImages.mineTabSel,
                size: 30,
                color: AppColors.c_0089FF,
              ),
            ),
            const SizedBox(width: 18),
            // 昵称 + 邮箱
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Text(
                        logic.nickname.isNotEmpty ? logic.nickname : '昵称',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c_0C1C33,
                        ),
                      )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        logic.email.isNotEmpty ? logic.email : '邮箱',
                        style: AppTextStyles.ts_8E9AB0_12sp,
                      )),
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

  /// 菜单列表
  Widget _buildMenuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: AppStrings.settings,
            onTap: () {
              // TODO: 跳转设置页
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: AppStrings.about,
            onTap: () {
              // TODO: 跳转关于页
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.c_0C1C33),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.ts_0C1C33_14sp,
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

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 50,
      endIndent: 16,
      color: AppColors.c_F0F2F6,
    );
  }

  /// 退出登录按钮
  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () => _showLogoutDialog(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            AppStrings.logout,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.c_FF381F,
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                AppStrings.confirmLogout,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.c_8E9AB0,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: AppColors.c_F0F2F6),
              GestureDetector(
                onTap: () {
                  Get.back();
                  logic.logout();
                },
                child: const SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(
                      AppStrings.logout,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.c_FF381F,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.c_F0F2F6),
              GestureDetector(
                onTap: () => Get.back(),
                child: const SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(
                      AppStrings.cancel,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.c_0C1C33,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
