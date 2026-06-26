import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/styles/text_styles.dart';
import '../../../../common/utils/time_utils.dart';
import 'process_apply_logic.dart';

class ProcessApplyPage extends StatelessWidget {
  const ProcessApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProcessApplyLogic logic = Get.find<ProcessApplyLogic>();
    final item = logic.requestData;
    final profile = item.fromProfile;
    final uid = logic.isOutgoing ? item.request.friendId : item.request.uid;
    final name = profile?.name ?? uid;
    final avatarUrl = profile?.avatarUrl ?? '';
    final message = item.request.message ?? '';
    final timeStr = TimeUtils.formatRelativeTime(item.request.createTime);

    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('好友申请详情'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // ---- 用户信息卡片 ----
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.c_FFFFFF,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: avatarUrl.isNotEmpty
                          ? Image.network(
                              avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  _buildAvatarPlaceholder(),
                            )
                          : _buildAvatarPlaceholder(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name, Email, Region
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                style: AppTextStyles.ts_0C1C33_14sp.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildGenderIcon(profile?.gender),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _buildProfileItem(Icons.email_outlined, profile?.email),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // ---- 申请详情卡片 ----
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.c_FFFFFF,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('验证消息', message),
                  const SizedBox(height: 12),
                  _buildInfoRow('申请时间', timeStr),
                  const SizedBox(height: 12),
                  _buildStatusRow(logic),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ---- 操作按钮 ----
            Obx(() {
              final processing = logic.isProcessing.value;
              // 只有收到的待处理申请才显示操作按钮
              if (logic.isOutgoing ||
                  logic.requestData.request.status != 0) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        label: '拒绝',
                        textColor: AppColors.c_666666,
                        bgColor: const Color(0xFFE0E3E8),
                        isLoading: processing,
                        onTap: logic.reject,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildActionButton(
                        label: '同意',
                        textColor: AppColors.c_FFFFFF,
                        bgColor: AppColors.c_0089FF,
                        isLoading: processing,
                        onTap: logic.accept,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: AppTextStyles.ts_8E9AB0_12sp,
          ),
        ),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '—',
            style: AppTextStyles.ts_8E9AB0_12sp,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String? text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.c_8E9AB0),
        const SizedBox(width: 6),
        Text(
          (text != null && text.isNotEmpty) ? text : '—',
          style: AppTextStyles.ts_8E9AB0_12sp,
        ),
      ],
    );
  }

  Widget _buildGenderIcon(int? gender) {
    if (gender == null || gender <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(
        gender == 1 ? Icons.male : Icons.female,
        size: 20,
        color: gender == 1 ? AppColors.c_0089FF : const Color(0xFFFF6B9D),
      ),
    );
  }

  Widget _buildStatusRow(ProcessApplyLogic logic) {
    final isOutgoing = logic.isOutgoing;
    final status = logic.requestData.request.status;
    String statusText;
    Color statusColor;

    if (isOutgoing) {
      switch (status) {
        case 0:
          statusText = '等待通过';
          statusColor = AppColors.c_8E9AB0;
          break;
        case 1:
          statusText = '已同意';
          statusColor = const Color(0xFF07C160);
          break;
        case 2:
          statusText = '已拒绝';
          statusColor = const Color(0xFFFF3B30);
          break;
        default:
          statusText = '';
          statusColor = AppColors.c_8E9AB0;
      }
    } else {
      switch (status) {
        case 0:
          statusText = '待通过';
          statusColor = const Color(0xFFFF9500);
          break;
        case 1:
          statusText = '已同意';
          statusColor = const Color(0xFF07C160);
          break;
        case 2:
          statusText = '已拒绝';
          statusColor = const Color(0xFFFF3B30);
          break;
        default:
          statusText = '';
          statusColor = AppColors.c_8E9AB0;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 64,
          child: Text(
            '状态',
            style: AppTextStyles.ts_8E9AB0_12sp,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              fontSize: 12,
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color textColor,
    required Color bgColor,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.c_0089FF,
                ),
              )
            : Text(
                label,
                style: const TextStyle(fontSize: 15),
              ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.c_0089FF_opacity10,
      child: const Icon(
        Icons.person,
        size: 40,
        color: AppColors.c_0089FF,
      ),
    );
  }

}
