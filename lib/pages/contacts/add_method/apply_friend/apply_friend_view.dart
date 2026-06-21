import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/styles/text_styles.dart';
import '../../../../common/widgets/touch_close_soft_keyboard.dart';
import 'apply_friend_logic.dart';

class ApplyFriendPage extends StatelessWidget {
  ApplyFriendPage({super.key});

  final ApplyFriendLogic logic = Get.find<ApplyFriendLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('添加好友'),
        actions: [
          Obx(() {
            final canSend = logic.message.value.isNotEmpty && !logic.isLoading.value;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: canSend ? () => logic.onSend() : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    '发送',
                    style: TextStyle(
                      fontSize: 15,
                      color: canSend ? AppColors.c_0089FF : AppColors.c_8E9AB0,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: TouchCloseSoftKeyboard(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // ---- 申请留言输入区 ----
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.c_FFFFFF,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: logic.messageController,
                    focusNode: logic.messageFocusNode,
                    autofocus: true,
                    maxLines: 5,
                    minLines: 3,
                    maxLength: 125,
                    buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                    style: const TextStyle(fontSize: 14, color: AppColors.c_333333),
                    decoration: InputDecoration(
                      hintText: '请输入申请留言',
                      hintStyle: AppTextStyles.ts_8E9AB0_12sp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    onChanged: (_) {
                      logic.message.value = logic.messageController.text.trim();
                      logic.charCount.value = logic.messageController.text.length;
                    },
                  ),
                  // 字符计数
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 12),
                    child: Obx(() {
                      final count = logic.charCount.value;
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$count/125',
                          style: TextStyle(
                            fontSize: 12,
                            color: count > 125 ? AppColors.c_FF381F : AppColors.c_8E9AB0,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
