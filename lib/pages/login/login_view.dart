import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/res/strings.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/input_box.dart';
import '../../common/widgets/touch_close_soft_keyboard.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginLogic logic = Get.find<LoginLogic>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TouchCloseSoftKeyboard(
        isGradientBg: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 88),
              // Login background illustration
              SvgPicture.asset(
                AppImages.loginBackground,
                width: 280,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              // Input area
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    _buildInputArea(),
                    const SizedBox(height: 46),
                    Obx(() => PrimaryButton(
                          text: AppStrings.login,
                          enabled: logic.enabled.value,
                          onTap: logic.login,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              // Register link
              Text.rich(
                TextSpan(
                  text: AppStrings.noAccountYet,
                  style: AppTextStyles.ts_8E9AB0_12sp,
                  children: [
                    TextSpan(
                      text: AppStrings.registerNow,
                      style: AppTextStyles.ts_0089FF_12sp,
                      recognizer: TapGestureRecognizer()
                        ..onTap = logic.registerNow,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Version info
              Obx(() => Text(
                    logic.versionInfo.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.c_999999,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Email input
        InputBox.account(
          label: '',
          hintText: AppStrings.plsEnterEmail,
          controller: logic.emailCtrl,
          focusNode: logic.emailFocus,
          keyBoardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 8),
        // Password input
        Obx(() => InputBox.password(
              label: '',
              hintText: AppStrings.plsEnterPassword,
              controller: logic.pwdCtrl,
              focusNode: logic.pwdFocus,
              obscureText: logic.obscureText.value,
              onToggleObscure: () =>
                  logic.obscureText.value = !logic.obscureText.value,
            )),
        const SizedBox(height: 10),
        // Forget password
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: logic.forgetPassword,
            child: Text(
              AppStrings.forgetPassword,
              style: AppTextStyles.ts_8E9AB0_12sp,
            ),
          ),
        ),
      ],
    );
  }
}
