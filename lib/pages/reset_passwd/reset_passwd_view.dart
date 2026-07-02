import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/res/strings.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/input_box.dart';
import '../../common/widgets/touch_close_soft_keyboard.dart';
import 'reset_passwd_logic.dart';

class ResetPasswdPage extends StatelessWidget {
  ResetPasswdPage({super.key});

  final ResetPasswdLogic logic = Get.find<ResetPasswdLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('重置密码'),
      ),
      body: TouchCloseSoftKeyboard(
        isGradientBg: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Background illustration
              SvgPicture.asset(
                AppImages.registerBackground,
                width: 280,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    // Email
                    InputBox.account(
                      label: '',
                      hintText: AppStrings.plsEnterEmail,
                      controller: logic.emailCtrl,
                      focusNode: null,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    // Verification code
                    InputBox.verificationCode(
                      label: '',
                      hintText: AppStrings.plsEnterVerificationCode,
                      controller: logic.codeCtrl,
                      onSendVerificationCode: logic.getVerificationCode,
                    ),
                    const SizedBox(height: 16),
                    // Password
                    Obx(() => InputBox.password(
                          label: '',
                          hintText: AppStrings.plsEnterPassword,
                          controller: logic.pwdCtrl,
                          focusNode: null,
                          obscureText: logic.obscureText.value,
                          onToggleObscure: () =>
                              logic.obscureText.value = !logic.obscureText.value,
                        )),
                    const SizedBox(height: 16),
                    // Confirm password
                    Obx(() => InputBox.password(
                          label: '',
                          hintText: '请确认密码',
                          controller: logic.confirmPwdCtrl,
                          focusNode: null,
                          obscureText: logic.obscureText.value,
                          onToggleObscure: () =>
                              logic.obscureText.value = !logic.obscureText.value,
                        )),
                    const SizedBox(height: 46),
                    // Reset button
                    Obx(() => PrimaryButton(
                          text: '重置密码',
                          enabled: logic.enabled.value,
                          onTap: logic.resetPassword,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
