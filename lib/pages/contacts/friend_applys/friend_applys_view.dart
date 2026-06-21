import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/db/daos/friend_request_dao.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import 'friend_applys_logic.dart';

class FriendApplysPage extends StatelessWidget {
  FriendApplysPage({super.key});

  final FriendApplysLogic logic = Get.find<FriendApplysLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('新的朋友'),
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

        if (logic.requests.isEmpty) {
          return _buildEmpty();
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemCount: logic.requests.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            final item = logic.requests[index];
            return _buildRequestItem(item);
          },
        );
      }),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_add_disabled_rounded,
            size: 64,
            color: AppColors.c_8E9AB0,
          ),
          SizedBox(height: 16),
          Text(
            '暂无好友申请',
            style: AppTextStyles.ts_8E9AB0_12sp,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem(FriendRequestWithProfile item) {
    final profile = item.fromProfile;
    final name = profile?.name ?? item.request.fromUid;
    final avatarUrl = profile?.avatarUrl ?? '';
    final message = item.request.message ?? '';
    final timeStr = _formatTime(item.request.createdAt);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // ---- 用户信息行 ----
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: avatarUrl.isNotEmpty
                        ? Image.network(
                            avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => _buildAvatarPlaceholder(),
                          )
                        : _buildAvatarPlaceholder(),
                  ),
                ),
                const SizedBox(width: 12),
                // Name & message
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: AppTextStyles.ts_0C1C33_14sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            timeStr,
                            style: AppTextStyles.ts_8E9AB0_12sp,
                          ),
                        ],
                      ),
                      if (message.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: AppTextStyles.ts_8E9AB0_12sp,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ---- 操作按钮 ----
          if (item.request.status == 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButton(
                    label: '拒绝',
                    textColor: AppColors.c_666666,
                    bgColor: AppColors.c_F0F2F6,
                    onTap: () => logic.reject(item),
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    label: '同意',
                    textColor: AppColors.c_FFFFFF,
                    bgColor: AppColors.c_0089FF,
                    onTap: () => logic.accept(item),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item.request.status == 1 ? '已同意' : '已拒绝',
                    style: AppTextStyles.ts_8E9AB0_12sp,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color textColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.c_0089FF_opacity10,
      child: const Icon(
        Icons.person,
        size: 28,
        color: AppColors.c_0089FF,
      ),
    );
  }

  /// 将毫秒时间戳格式化为展示文本。
  String _formatTime(int timestampMs) {
    if (timestampMs <= 0) return '';
    final now = DateTime.now();
    final dt = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    if (diff.inDays < 30) return '${diff.inDays}天前';

    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
