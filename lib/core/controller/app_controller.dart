import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../common/utils/logger.dart';

/// App lifecycle controller.
/// Handles foreground/background transitions, version info,
/// and global app state.
class AppController extends GetxController {
  var isRunningBackground = false;
  final versionInfo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Logger.print('AppController onInit');
  }

  @override
  void onReady() {
    super.onReady();
    _getPackageInfo();
  }

  Future<void> runningBackground(bool run) async {
    Logger.print('App running background: $run');
    isRunningBackground = run;
  }

  Future<void> _getPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      versionInfo.value = '${info.appName} ${info.version}+${info.buildNumber}';
    } catch (_) {
      versionInfo.value = 'IMClient 1.0.0+1';
    }
  }

}
