import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutLogic extends GetxController {
  final RxMap<String, String> info = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    try {
      final pkg = await PackageInfo.fromPlatform();

      info.assignAll({
        '应用名称': pkg.appName,
        '版本号': pkg.version,
        '构建号': pkg.buildNumber,
        '包名': pkg.packageName,
      });
    } catch (_) {}

    // 平台信息
    final plat = kIsWeb ? 'Web' : '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
    info['运行平台'] = plat;
    info['Flutter 版本'] = 'Flutter 3.x (stable)';
    info['Dart 版本'] = 'Dart 3.x';
  }
}
