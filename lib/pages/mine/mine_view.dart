import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../common/res/strings.dart';
import '../../routes/app_navigator.dart';
import '../../common/widgets/user_info_view.dart';
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
            Obx(() => UserInfoView(
                  nickname: logic.nickname,
                  email: logic.email,
                  avatarUrl: logic.avatarUrl,
                  onTap: () => logic.fetchUserDetail(),
                )),
            const SizedBox(height: 24),
            // ---- 菜单项 ----
            _buildMenuSection(context),
            const Spacer(),
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
            onTap: () => AppNavigator.startSetting(),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: AppStrings.about,
            onTap: () => AppNavigator.startAbout(),
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

}
