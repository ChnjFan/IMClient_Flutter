import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // 17sp semi-bold, primary blue
  static const ts_0089FF_17sp_semibold = TextStyle(
    color: AppColors.c_0089FF,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  // 12sp, grey
  static const ts_8E9AB0_12sp = TextStyle(
    color: AppColors.c_8E9AB0,
    fontSize: 12,
  );

  // 12sp, primary blue
  static const ts_0089FF_12sp = TextStyle(
    color: AppColors.c_0089FF,
    fontSize: 12,
  );

  // 14sp
  static const ts_0C1C33_14sp = TextStyle(
    color: AppColors.c_0C1C33,
    fontSize: 14,
  );

  // 10sp semi-bold
  static const ts_0089FF_10sp_semibold = TextStyle(
    color: AppColors.c_0089FF,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}
