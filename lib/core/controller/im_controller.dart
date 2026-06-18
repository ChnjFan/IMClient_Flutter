import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../../common/models/login_certificate.dart';
import '../../common/models/msg_id.dart';
import '../../common/models/server_resp.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/storage.dart';
import '../../common/utils/tcp_utils.dart';

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

  // ---- User info ----
  final userID = ''.obs;
  final nickname = ''.obs;
  final email = ''.obs;
  final token = ''.obs;

  Completer<bool>? _loginCompleter;
  LoginCertificate? _cert;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  void onInit() {
    super.onInit();
    Logger.print('IMController onInit — initializing SDK...');

    _initSDK();
  }

  /// Simulate SDK initialization.
  Future<void> _initSDK() async {
    imSdkStatus(IMSdkStatus.initializing);

    // Simulate async init delay
    await Future.delayed(const Duration(milliseconds: 500));

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

    userID.value = cert.userId;
    token.value = cert.chatToken;
    nickname.value = cert.nickname;
    email.value = cert.email;

    _cert = cert;

    // 每次连接前重新绑定回调，防止被意外清空
    tcpClient
      ..onMessage = _onTcpMessage
      ..onReconnected = _onReconnected
      ..onStatusChanged = (status) {
        Logger.print('TCP status: $status');
        if (status == TcpStatus.disconnected) {
          imSdkStatus(IMSdkStatus.connectionFailed);
        }
      }
      ..onError = (e) {
        Logger.print('TCP error: $e');
      };

    _registerHandlers();


    try {
      // 建立 TCP 长连接
      final port = int.tryParse(cert.chatServerPort) ?? 0;
      await tcpClient.connect(cert.chatServerIp, port);

      // 发送 chatLoginReq，等待应答
      tcpClient.sendJson(MsgId.chatLoginReq, {
        'uid': cert.userId,
        'token': cert.chatToken,
      });

      _loginCompleter = Completer<bool>();
      final ok = await _loginCompleter!.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () => false,
      );
      _loginCompleter = null;

      if (!ok) {
        throw Exception('chat login failed');
      }
    } catch (e) {
      tcpClient.disconnect();
      _loginCompleter = null;
      imSdkStatus(IMSdkStatus.connectionFailed);
      Logger.print('IMController — login failed: $e');
      rethrow;
    }

    imSdkStatus(IMSdkStatus.syncStart);
    imSdkStatus(IMSdkStatus.syncEnded);
    Logger.print('IMController — login success');
  }

  /// msgId → 回调，外部可注册自定义处理。
  final Map<int, void Function(ServerResp)> _handlers = {};

  /// 注册自定义消息处理器。
  void onMsg(int msgId, void Function(ServerResp) handler) {
    _handlers[msgId] = handler;
  }

  void _onTcpMessage(int msgId, Uint8List data) {
    ServerResp resp;
    try {
      final json = jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
      resp = ServerResp.fromJson(json);
    } catch (_) {
      resp = ServerResp(errCode: -1);
    }

    final handler = _handlers[msgId];
    if (handler != null) {
      handler(resp);
    } else {
      Logger.print('IMController — unhandled msgId=$msgId');
    }
  }

  void _registerHandlers() {
    _handlers[MsgId.chatLoginRsp] = _onChatLoginRsp;
    _handlers[MsgId.notifyAddFriend] = _onNotifyAddFriend;
    _handlers[MsgId.notifyFriendAuth] = _onNotifyFriendAuth;
    _handlers[MsgId.notifyChatMsg] = _onNotifyChatMsg;
    _handlers[MsgId.heartbeatRsp] = _onHeartbeatRsp;
  }

  void _onReconnected() {
    if (_cert == null) return;
    Logger.print('IMController — reconnected, re-sending chatLoginReq');
    tcpClient.sendJson(MsgId.chatLoginReq, {
      'uid': _cert!.userId,
      'token': _cert!.chatToken,
    });
  }

  void _onChatLoginRsp(ServerResp resp) {
    if (resp.isSuccess) {
      Logger.print('IMController — chat login success');
    } else {
      Logger.print('IMController — chat login failed: ${ServerError.getMsg(resp.errCode)}');
      imSdkStatus(IMSdkStatus.connectionFailed);
    }
    _loginCompleter?.complete(resp.isSuccess);
  }

  void _onNotifyAddFriend(ServerResp resp) =>
      Logger.print('IMController — friend request from: ${resp.get('fromUid')}');

  void _onNotifyFriendAuth(ServerResp resp) =>
      Logger.print('IMController — friend auth result from: ${resp.get('fromUid')}');

  void _onNotifyChatMsg(ServerResp resp) =>
      Logger.print('IMController — new message from: ${resp.get('fromUid')}');

  void _onHeartbeatRsp(ServerResp resp) =>
      Logger.print('IMController — heartbeat response received');

  /// 登出：断开 TCP 并清除状态。
  Future<void> logout() async {
    Logger.print('IMController — logging out');
    tcpClient.disconnect();
    userID.value = '';
    token.value = '';
    nickname.value = '';
    email.value = '';
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
