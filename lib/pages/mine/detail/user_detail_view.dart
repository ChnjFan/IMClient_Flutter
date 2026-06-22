import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../component/gender_picker.dart';
import '../../../component/date_picker.dart';
import '../../../component/region_picker.dart';
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
            _buildBasicSection(),
            const SizedBox(height: 12),
            _buildDetailSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 基础信息卡片
  // ============================================================
  Widget _buildBasicSection() {
    return _buildCard(children: [
      Obx(() => _buildAvatarRow()),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '昵称',
            value: logic.fullInfo.name ?? '未设置',
            editable: true,
            onTap: () async {
              await AppNavigator.startNameEdit();
              logic.refreshFromUserInfo();
            },
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '邮箱',
            value: logic.fullInfo.email ?? '未设置',
            editable: true,
            onTap: () async {
              await AppNavigator.startEmailEdit();
              logic.refreshFromUserInfo();
            },
          )),
    ]);
  }

  // ============================================================
  // 详细资料卡片
  // ============================================================
  Widget _buildDetailSection() {
    return _buildCard(children: [
      Obx(() => _buildInfoRow(
            label: '手机号',
            value: logic.fullInfo.phone ?? '未设置',
            editable: true,
            onTap: () async { await AppNavigator.startPhoneEdit(); logic.refreshFromUserInfo(); },
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '性别',
            value: logic.genderText(logic.fullInfo.gender),
            editable: true,
            onTap: () => GenderPicker.show(selected: logic.fullInfo.gender, onSelected: (v) => logic.updateField('性别', v.toString())),
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '生日',
            value: logic.fullInfo.birthday ?? '未设置',
            editable: true,
            onTap: () => DatePicker.show(title: '选择生日', initialDate: logic.fullInfo.birthday, onSelected: (v) => logic.updateField('生日', v)),
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '地区',
            value: logic.fullInfo.region ?? '未设置',
            editable: true,
            onTap: () => RegionPicker.show(selected: logic.fullInfo.region, onSelected: (v) => logic.updateField('地区', v)),
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '个性签名',
            value: logic.fullInfo.signature ?? '未设置',
            editable: true,
            onTap: () async { await AppNavigator.startSignatureEdit(); logic.refreshFromUserInfo(); },
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '个人简介',
            value: logic.fullInfo.selfIntro ?? '未设置',
            editable: true,
            onTap: () async { await AppNavigator.startSelfIntroEdit(); logic.refreshFromUserInfo(); },
          )),
      _divider(),
      Obx(() => _buildInfoRow(
            label: '注册时间',
            value: logic.formatTime(logic.fullInfo.createTime),
          )),
    ]);
  }

  // ============================================================
  // 通用组件
  // ============================================================

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildAvatarRow() {
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.c_0089FF_opacity10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: logic.fullInfo.avatarUrl != null &&
                      logic.fullInfo.avatarUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        logic.fullInfo.avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, e, s) => _defaultMiniAvatar(),
                      ),
                    )
                  : _defaultMiniAvatar(),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.c_8E9AB0),
          ],
        ),
      ),
    );
  }

  Widget _defaultMiniAvatar() {
    return const Icon(Icons.person, size: 28, color: AppColors.c_0089FF);
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    bool editable = false,
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
              width: 72,
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
            if (editable) ...[
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, size: 20, color: AppColors.c_8E9AB0),
            ],
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1, indent: 16, endIndent: 16, color: AppColors.c_F0F2F6,
    );
  }

}
