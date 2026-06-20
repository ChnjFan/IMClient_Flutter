import 'dart:async';
import 'package:get/get.dart';
import 'package:imclient_flutter/routes/app_navigator.dart';
import 'package:imclient_flutter/common/models/login_certificate.dart';
import 'package:imclient_flutter/common/models/msg_id.dart';
import 'package:imclient_flutter/common/models/server_resp.dart';
import 'package:imclient_flutter/common/models/user/user_info.dart';
import 'package:imclient_flutter/common/utils/logger.dart';
import 'package:imclient_flutter/common/utils/storage.dart';
import 'package:imclient_flutter/common/utils/tcp_utils.dart';
import 'chat_tcp_client.dart';

enum IMSdkStatus {
  notInitialized,
  initializing,
  connecting,
  connectionSucceeded,
  connectionFailed,
  syncStart,
  syncProgress,
  syncEnded,
  syncFailed,
}

class IMSdkStatusInfo {
  final IMSdkStatus status;
  final int? progress;
  final bool reInstall;

  IMSdkStatusInfo({
    required this.status,
    this.progress,
    this.reInstall = false,
  });
}

/// IM SDK controller stub — manages SDK lifecycle, login/logout, and status streams.
/// In production this would wrap the real `flutter_openim_sdk`.
class IMController extends GetxController {
  // ---- Reactive status streams ----
  final initializedSubject = StreamController<bool>.broadcast();
  final imSdkStatusSubject = BehaviorSubject<IMSdkStatusInfo>.seeded(
    IMSdkStatusInfo(status: IMSdkStatus.notInitialized),
  );

  // ---- TCP 连接 ----
  final ChatTcpClient _tcp = ChatTcpClient();

  // ---- User info (reactive) ----
  /// 初始化为空 [UserInfo]，login() 成功后从 chatLoginRsp 更新其字段。
  final userInfo = UserInfo().obs;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  void onInit() {
    super.onInit();
    Logger.print('IMController onInit — initializing SDK...');
    _bindTcpCallbacks();
    _registerHandlers();
    _initSDK();
  }

  /// Simulate SDK initialization.
  Future<void> _initSDK() async {
    imSdkStatus(IMSdkStatus.initializing);

    _isInitialized = true;
    imSdkStatus(IMSdkStatus.connectionSucceeded);
    if (!initializedSubject.isClosed) initializedSubject.add(true);

    Logger.print('IMController — SDK initialized');
  }

  /// 用户登录逻辑：建立 TCP 连接，发送 chatLoginReq，等待 chatLoginRsp 应答。
  /// 成功无返回值，失败抛异常并断开 TCP。
  Future<void> login(LoginCertificate cert) async {
    Logger.print('IMController — logging in userID: ${cert.userId} server: ${cert.chatServerIp}:${cert.chatServerPort}');
    imSdkStatus(IMSdkStatus.connecting);

    try {
      // 建立 TCP 长连接
      await _tcp.connect(cert);

      // 发送 chatLoginReq，等待 chatLoginRsp 应答
      final resp = await _tcp.sendRequest(
        MsgId.chatLoginReq,
        MsgId.chatLoginRsp,
        {'uid': cert.userId, 'token': cert.chatToken},
      );

      if (resp == null || !resp.isSuccess) {
        throw Exception('chat login failed');
      }
      // 从聊天服务器登录应答中提取用户资料
      userInfo.value = UserInfo.fromJson(resp.data);
    } catch (e) {
      _tcp.disconnect();
      imSdkStatus(IMSdkStatus.connectionFailed);
      Logger.print('IMController — login failed: $e');
      rethrow;
    }

    imSdkStatus(IMSdkStatus.syncStart);
    imSdkStatus(IMSdkStatus.syncEnded);
    Logger.print('IMController — login success');
  }

  Future<bool> updateUserInfo({
    required String uid,
    String? name,
    String? email,
    String? avatarUrl
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.updateUserInfoReq,
      MsgId.updateUserInfoRsp,
      {
        'uid': uid,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
      },
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — updateUserInfo failed: ${resp?.errCode}');
      return false;
    }

    final updated = userInfo.value;
    if (name != null) updated.name = name;
    if (email != null) updated.email = email;
    if (avatarUrl != null) updated.avatarUrl = avatarUrl;
    userInfo.refresh();
    return true;
  }

  Future<UserInfo> searchUserInfo({
    String? email,
    String? nickname,
  }) async {
    final resp = await _tcp.sendRequest(
      MsgId.searchUserReq,
      MsgId.searchUserRsp,
      {'email': email, 'name': nickname},
    );

    if (resp == null || !resp.isSuccess) {
      Logger.print('IMController — searchUserInfo failed: ${resp?.errCode}');
      throw Exception('search user info failed');
    }

    return UserInfo.fromJson(resp.data);
  }

  void _bindTcpCallbacks() {
    _tcp.onStatusChanged = (status) {
      Logger.print('TCP status: $status');
      if (status == TcpStatus.disconnected) {
        imSdkStatus(IMSdkStatus.connectionFailed);
      }
    };
  }

  void _registerHandlers() {
    _tcp.registerHandler(MsgId.chatLoginRsp, _onChatLoginRsp);
    _tcp.registerHandler(MsgId.notifyAddFriend, _onNotifyAddFriend);
    _tcp.registerHandler(MsgId.notifyFriendAuth, _onNotifyFriendAuth);
    _tcp.registerHandler(MsgId.notifyChatMsg, _onNotifyChatMsg);
    _tcp.registerHandler(MsgId.heartbeatRsp, _onHeartbeatRsp);
    _tcp.registerHandler(MsgId.offline, _onOffline);
  }

  void _onChatLoginRsp(ServerResp resp) {
    if (resp.isSuccess) {
      Logger.print('IMController — chat login success');
    } else {
      Logger.print('IMController — chat login failed: ${ServerError.getMsg(resp.errCode)}');
      imSdkStatus(IMSdkStatus.connectionFailed);
    }
  }

  void _onNotifyAddFriend(ServerResp resp) =>
      Logger.print('IMController — friend request from: ${resp.get('fromUid')}');

  void _onNotifyFriendAuth(ServerResp resp) =>
      Logger.print('IMController — friend auth result from: ${resp.get('fromUid')}');

  void _onNotifyChatMsg(ServerResp resp) =>
      Logger.print('IMController — new message from: ${resp.get('fromUid')}');

  void _onHeartbeatRsp(ServerResp resp) =>
      Logger.print('IMController — heartbeat response received');
  
  void _onOffline(ServerResp resp) {
      Logger.print('IMController — offline notification received');
      logout();
      AppNavigator.startLogin();
  }

  /// 登出：断开 TCP 并清除状态。
  Future<void> logout() async {
    Logger.print('IMController — logging out');
    _tcp.disconnect();
    _isInitialized = false;
    imSdkStatus(IMSdkStatus.notInitialized);
    await Storage.removeLoginCertificate();
  }

  void imSdkStatus(IMSdkStatus status, {int? progress, bool reInstall = false}) {
    imSdkStatusSubject.add(
      IMSdkStatusInfo(status: status, progress: progress, reInstall: reInstall),
    );
  }

  @override
  void onClose() {
    initializedSubject.close();
    imSdkStatusSubject.close();
    super.onClose();
  }
}

/// Explicitly typed BehaviorSubject (RxDart) for SDK status stream.
class BehaviorSubject<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  BehaviorSubject.seeded(T seedValue) {
    _value = seedValue;
  }

  T? _value;
  T? get value => _value;
  T? get values => _value;

  Stream<T> get stream => _controller.stream;

  void add(T event) {
    _value = event;
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void listen(void Function(T event) onData) {
    _controller.stream.listen(onData);
  }

  void close() {
    _controller.close();
  }
}
