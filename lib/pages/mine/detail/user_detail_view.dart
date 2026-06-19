import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../routes/app_navigator.dart';
import 'user_detail_logic.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage({super.key});

  final UserDetailLogic logic = Get.find<UserDetailLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('个人信息'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  /// 信息列表
  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // ---- 头像 ----
          Obx(() => _buildAvatarRow()),
          _divider(),
          Obx(() => _buildInfoRow(
                label: '昵称',
                value: logic.imLogic.userInfo.value.name ?? '未设置',
                editable: true,
                onTap: () async {
                  await AppNavigator.startNameEdit();
                  logic.refreshFromUserInfo();
                },
              )),
          _divider(),
          Obx(() => _buildInfoRow(
                label: '邮箱',
                value: logic.imLogic.userInfo.value.email ?? '未设置',
                editable: true,
                onTap: () async {
                  await AppNavigator.startEmailEdit();
                  logic.refreshFromUserInfo();
                },
              )),
        ],
      ),
    );
  }

  /// 头像行
  Widget _buildAvatarRow() {
    final avatarUrl = logic.imLogic.userInfo.value.avatarUrl ?? '';
    return InkWell(
      onTap: () async {
        await AppNavigator.startAvatarEdit();
        logic.refreshFromUserInfo();
      },
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text('头像', style: AppTextStyles.ts_0C1C33_14sp),
            const Spacer(),
            // 小头像预览
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.c_0089FF_opacity10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: avatarUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, e, s) => _defaultMiniAvatar(),
                      ),
                    )
                  : _defaultMiniAvatar(),
            ),
            const SizedBox(width: 8),
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

  Widget _defaultMiniAvatar() {
    return const Icon(Icons.person, size: 28, color: AppColors.c_0089FF);
  }

  /// 单行信息
  Widget _buildInfoRow({
    required String label,
    required String value,
    bool editable = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: editable ? onTap : null,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              child: Text(
                label,
                style: AppTextStyles.ts_0C1C33_14sp,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.c_8E9AB0,
                ),
              ),
            ),
            if (editable) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.c_8E9AB0,
              ),
            ],
          ],
        ),
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
