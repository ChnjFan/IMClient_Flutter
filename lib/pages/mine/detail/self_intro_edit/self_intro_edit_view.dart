import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/widgets/touch_close_soft_keyboard.dart';
import 'self_intro_edit_logic.dart';

class SelfIntroEditPage extends StatelessWidget {
  SelfIntroEditPage({super.key});

  final SelfIntroEditLogic logic = Get.find<SelfIntroEditLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F0F2F6,
      appBar: AppBar(
        title: const Text('修改个人简介'),
        leadingWidth: 64,
        leading: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Text('取消', style: TextStyle(fontSize: 16, color: AppColors.c_333333)),
          ),
        ),
        actions: [
          Obx(() {
            final active = logic.hasChanged.value;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: active ? () => logic.save() : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.c_0089FF : AppColors.c_E8EAEF,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '完成',
                    style: TextStyle(
                      fontSize: 14,
                      color: active ? AppColors.c_FFFFFF : AppColors.c_999999,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: TouchCloseSoftKeyboard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              TextField(
                controller: logic.ctrl,
                focusNode: logic.focus,
                autofocus: true,
                maxLines: 5,
                maxLength: 200,
                onChanged: logic.onTextChanged,
                contextMenuBuilder: (context, editableTextState) {
                  return AdaptiveTextSelectionToolbar.editableText(
                    editableTextState: editableTextState,
                  );
                },
                style: const TextStyle(fontSize: 15, color: AppColors.c_333333),
                decoration: InputDecoration(
                  hintText: '请输入个人简介',
                  hintStyle: const TextStyle(fontSize: 15, color: AppColors.c_999999),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.c_E8EAEF),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.c_E8EAEF),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.c_0089FF),
                  ),
                ),
              ),
              Positioned(
                right: 0, top: 0, bottom: 0,
                child: Obx(() {
                  if (!logic.hasText.value) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: logic.onClear,
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Icon(Icons.cancel, size: 20, color: AppColors.c_8E9AB0),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
