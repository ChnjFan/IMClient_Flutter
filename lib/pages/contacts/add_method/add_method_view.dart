import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../routes/app_navigator.dart';
import 'add_method_logic.dart';

class AddMethodPage extends StatelessWidget {
  AddMethodPage({super.key});

  final AddMethodLogic logic = Get.find<AddMethodLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('添加方式'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // ---- 精确查找 ----
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.c_FFFFFF,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.person_search_rounded,
                  title: '搜索好友',
                  subtitle: '通过 ID / 手机号 / 邮箱查找',
                  onTap: () => AppNavigator.startSearchFriend(),
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.qr_code_scanner_rounded,
                  title: '扫一扫',
                  subtitle: '扫描二维码名片',
                  onTap: () {
                    // TODO: 打开扫码页
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.contacts_rounded,
                  title: '手机联系人',
                  subtitle: '从通讯录添加好友',
                  onTap: () {
                    // TODO: 读取手机联系人
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ---- 群聊相关 ----
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.c_FFFFFF,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.group_add_rounded,
                  title: '添加群聊',
                  subtitle: '通过群号或二维码加入群聊',
                  onTap: () {
                    // TODO: 跳转添加群聊页
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.create_new_folder_rounded,
                  title: '创建群聊',
                  subtitle: '创建一个新的群组',
                  onTap: () {
                    // TODO: 跳转创建群聊页
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.c_0089FF_opacity10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: AppColors.c_0089FF),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.ts_0C1C33_14sp,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.ts_8E9AB0_12sp,
                    overflow: TextOverflow.ellipsis,
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

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 68,
      endIndent: 16,
      color: AppColors.c_F0F2F6,
    );
  }
}
