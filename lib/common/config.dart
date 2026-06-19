import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../core/controller/im_controller.dart';
import 'utils/logger.dart';
import 'utils/storage.dart';
import 'utils/http_utils.dart';
import 'db/database.dart';

/// 全局应用配置类。
///
/// 负责：
/// - 应用启动初始化（平台绑定、存储路径、系统 UI 风格）
/// - 设计尺寸常量（UI 适配基准）
/// - 服务端地址配置（预留 IM SDK 接入）
class AppConfig {
  AppConfig._();

  final appDatabase = AppDatabase();

  // ============================================================
  // 初始化
  // ============================================================

  /// 应用启动时调用，完成所有必要的初始化工作后执行 [runApp]。
  static Future<void> init(Future<void> Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();

    // 获取缓存路径
    try {
      final dir = await getApplicationDocumentsDirectory();
      cachePath = '${dir.path}/';
    } catch (e) {
      Logger.print('Failed to get cache path: $e');
      cachePath = '/';
    }

    // 初始化本地存储
    await Storage.init();
    // 初始化本地数据库
    final db = AppDatabase();
    // 将数据库实例放入 GetX 依赖管理中，设置为永久实例
    Get.put<AppDatabase>(db, permanent: true);
    // 将 IMController 注册为全局永久单例（避免 route scope 导致多实例）
    Get.put<IMController>(IMController(), permanent: true);
    // 初始化 http 客户端
    HttpUtils.init();

    await runApp();

    // 锁定竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // 设置状态栏样式
    final brightness =
        Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    // 获取应用信息
    try {
      final info = await PackageInfo.fromPlatform();
      appName = info.appName;
      appVersion = info.version;
      buildNumber = info.buildNumber;
    } catch (_) {
      appName = 'IMClient';
      appVersion = '1.0.0';
      buildNumber = '1';
    }
  }

  // ============================================================
  // 应用信息
  // ============================================================

  /// 应用名称
  static late String appName;

  /// 应用版本号
  static late String appVersion;

  /// 构建号
  static late String buildNumber;

  /// 缓存目录路径
  static late String cachePath;

  // ============================================================
  // UI 设计常量
  // ============================================================

  /// 设计稿宽度 (iPhone X)
  static const double uiW = 375.0;

  /// 设计稿高度 (iPhone X)
  static const double uiH = 812.0;

  /// 全局文字缩放系数（1.0 表示不缩放）
  static const double textScaleFactor = 1.0;

  // ============================================================
  // 服务端配置（预留 IM SDK 接入时使用）
  // ============================================================

  /// 默认服务器地址
  static const String _defaultHost = '127.0.0.1';

  /// 是否为 IP 地址
  static bool get _isIP =>
      RegExp(r'((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)')
          .hasMatch(serverHost);

  /// 服务器地址（优先使用 Storage 中的配置，否则使用默认值）
  static String get serverHost {
    final stored = Storage.getServerHostSync();
    return stored ?? _defaultHost;
  }

  /// 网关地址
  static String get gateServerUrl {
    final stored = Storage.getServerConfigSync()?['gateServerUrl'] as String?;
    return stored ??
        (_isIP ? 'http://$_defaultHost:8080' : 'https://$_defaultHost/gateway');
  }

  // ============================================================
  // 业务常量
  // ============================================================

  /// 发现页路由
  static const String discoverPageURL = 'discover';

  /// 允许非好友发送消息
  static const String allowSendMsgNotFriend = '1';
}
