import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imclient_flutter/routes/app_navigator.dart';
import 'package:imclient_flutter/common/res/strings.dart';
import 'package:imclient_flutter/common/styles/colors.dart';
import 'package:imclient_flutter/core/controller/im_controller.dart';

class LogoutView extends StatelessWidget {
  LogoutView({super.key});

  final IMController imLogic = Get.find<IMController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLogoutDialog(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            AppStrings.logout,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.c_FF381F,
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: AppColors.c_FFFFFF,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                AppStrings.confirmLogout,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.c_8E9AB0,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: AppColors.c_F0F2F6),
              GestureDetector(
                onTap: () => _logout(),
                child: const SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(
                      AppStrings.logout,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.c_FF381F,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.c_F0F2F6),
              GestureDetector(
                onTap: () => Get.back(),
                child: const SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(
                      AppStrings.cancel,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.c_0C1C33,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 退出逻辑
  void _logout() {
    Get.back();
    imLogic.logout();
    AppNavigator.startLogin();
  }
}
