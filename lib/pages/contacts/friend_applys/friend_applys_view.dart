import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/db/daos/friend_request_dao.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../common/utils/time_utils.dart';
import '../../../routes/app_navigator.dart';
import 'friend_applys_logic.dart';

class FriendApplysPage extends StatelessWidget {
  const FriendApplysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FriendApplysLogic logic = Get.find<FriendApplysLogic>();

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

        return _buildList(logic.allRequests, logic);
      }),
    );
  }

  Widget _buildList(
      List<FriendRequestWithProfile> list, FriendApplysLogic logic) {
    if (list.isEmpty) {
      return _buildEmpty();
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: list.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final item = list[index];
        return _buildRequestItem(item, logic);
      },
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

  Widget _buildRequestItem(
      FriendRequestWithProfile item, FriendApplysLogic logic) {
    final isOutgoing = logic.isOutgoing(item);
    final profile = item.fromProfile;
    final uid = isOutgoing ? item.request.friendId : item.request.uid;
    final name = profile?.name ?? uid;
    final avatarUrl = profile?.avatarUrl ?? '';
    final message = item.request.message ?? '';
    final timeStr = TimeUtils.formatRelativeTime(item.request.createTime);

    return InkWell(
      onTap: () => AppNavigator.startProcessApply(item: item),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  style: AppTextStyles.ts_0C1C33_14sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _buildGenderIcon(profile?.gender),
                            ],
                          ),
                        ),
                        Text(
                          timeStr,
                          style: AppTextStyles.ts_8E9AB0_12sp,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: AppTextStyles.ts_8E9AB0_12sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          isOutgoing
                              ? _outgoingStatusText(item.request.status)
                              : _incomingStatusText(item.request.status),
                          style: AppTextStyles.ts_8E9AB0_12sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderIcon(int? gender) {
    if (gender == null || gender <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Icon(
        gender == 1 ? Icons.male_rounded : Icons.female_rounded,
        size: 16,
        color: gender == 1 ? AppColors.c_0089FF : const Color(0xFFFF6B9D),
      ),
    );
  }

  String _incomingStatusText(int status) {
    switch (status) {
      case 0:
        return '待通过';
      case 1:
        return '已同意';
      case 2:
        return '已拒绝';
      default:
        return '';
    }
  }

  String _outgoingStatusText(int status) {
    switch (status) {
      case 0:
        return '等待通过';
      case 1:
        return '已同意';
      case 2:
        return '已拒绝';
      default:
        return '';
    }
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

}
