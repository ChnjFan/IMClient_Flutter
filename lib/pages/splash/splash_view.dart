import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/res/images.dart';
import '../../common/styles/colors.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  // Get.find is safe here because SplashBinding lazy-puts SplashLogic
  final SplashLogic logic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.c_0089FF_opacity10, AppColors.c_FFFFFF_opacity0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo
          const Icon(
            AppImages.splashLogo,
            size: 80,
            color: AppColors.c_0089FF,
          ),
          // Loading indicator at bottom
          const Positioned(
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.c_0089FF,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '即时通讯，随时随地',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.c_8E9AB0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
