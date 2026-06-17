import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/res/strings.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/input_box.dart';
import '../../common/widgets/touch_close_soft_keyboard.dart';
import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterLogic logic = Get.find<RegisterLogic>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TouchCloseSoftKeyboard(
        isGradientBg: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 88),
              // Register background illustration
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
                    // Register button
                    Obx(() => PrimaryButton(
                          text: '注册',
                          enabled: logic.enabled.value,
                          onTap: logic.register,
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
