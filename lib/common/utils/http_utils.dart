import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config.dart';
import '../models/server_resp.dart';
import 'logger.dart';

/// 全局 Dio 实例，由 [HttpUtils.init] 初始化后可用。
final dio = Dio();

/// HTTP 基础接口封装。
///
/// 使用方式：
/// ```dart
/// // main.dart 中初始化
/// AppConfig.init(() async {
///   HttpUtils.init();
///   runApp(const IMClientApp());
/// });
///
/// // 业务中调用
/// final data = await HttpUtils.post('/user/login', data: {...});
/// ```
class HttpUtils {
  HttpUtils._();

  // ============================================================
  // 初始化
  // ============================================================

  /// 初始化 Dio 实例：基地址、超时、拦截器。
  /// 应在 [AppConfig.init] 之后调用。
  static void init() {
    dio.options.baseUrl = AppConfig.gateServerUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // 请求拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        Logger.print('HTTP ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          Logger.print('HTTP ${response.statusCode} ${response.requestOptions.uri}');
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        Logger.print('HTTP ERROR ${e.type} ${e.message}');
        return handler.next(e);
      },
    ));
  }

  // ============================================================
  // 请求方法
  // ============================================================

  /// POST 请求。
  ///
  /// 返回 [ServerResp.data]，失败时抛出错误。
  static Future<dynamic> post(
    String path, {
    dynamic data,
    bool showErrorToast = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      data ??= {};
      options ??= Options();
      final result = await dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      final resp = ServerResp.fromJson(result.data!);
      if (resp.isSuccess) {
        return resp.data;
      }
      // 业务错误
      if (showErrorToast) {
        _showError(ServerError.getMsg(resp.errCode));
      }
      return Future.error((resp.errCode, ServerError.getMsg(resp.errCode)));
    } on DioException catch (e) {
      final msg = '${e.type}: ${e.message}';
      if (showErrorToast) _showError(msg);
      return Future.error(msg);
    } catch (e) {
      if (showErrorToast) _showError(e.toString());
      return Future.error(e);
    }
  }

  /// GET 请求。
  static Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool showErrorToast = false,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      options ??= Options();
      final result = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      final resp = ServerResp.fromJson(result.data!);
      if (resp.isSuccess) {
        return resp.data;
      }
      if (showErrorToast) {
        _showError(ServerError.getMsg(resp.errCode));
      }
      return Future.error((resp.errCode, ServerError.getMsg(resp.errCode)));
    } on DioException catch (e) {
      final msg = '${e.type}: ${e.message}';
      if (showErrorToast) _showError(msg);
      return Future.error(msg);
    } catch (e) {
      if (showErrorToast) _showError(e.toString());
      return Future.error(e);
    }
  }

  /// 文件上传。
  static Future<String> upload(
    String path, {
    required String filePath,
    String? fileName,
    String fieldName = 'file',
  }) async {
    final name = fileName ?? filePath.split('/').last;
    final bytes = await File(filePath).readAsBytes();
    final mf = MultipartFile.fromBytes(bytes, filename: name);
    final formData = FormData.fromMap({
      fieldName: mf,
    });
    final resp = await dio.post<Map<String, dynamic>>(path, data: formData);
    final result = ServerResp.fromJson(resp.data!);
    if (result.isSuccess) {
      return result.data.toString();
    }
    return Future.error(ServerError.getMsg(result.errCode));
  }

  // ============================================================
  // 私有
  // ============================================================

  static void _showError(String msg) {
    Logger.print('HTTP Error: $msg');
  }
}
