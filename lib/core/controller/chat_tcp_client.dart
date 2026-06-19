import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import '../../common/models/login_certificate.dart';
import '../../common/models/msg_id.dart';
import '../../common/models/server_resp.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/tcp_utils.dart';

/// TCP 长连接管理器 — 在 [TcpClient] 之上封装消息路由、重连认证和状态监控。
///
/// 两种发送模式：
/// - **请求/应答**：[sendRequest] 发送消息并等待指定应答 msgId，返回应答结果。
/// - **通知**：[sendNotify] 发送消息后不等待应答（fire-and-forget）。
///
/// 使用方式：
/// ```dart
/// final conn = ChatTcpClient();
/// conn.registerHandler(MsgId.notifyChatMsg, (resp) { ... });
/// await conn.connect(cert);
///
/// // 请求/应答
/// final resp = await conn.sendRequest(MsgId.chatLoginReq, MsgId.chatLoginRsp, {...});
///
/// // 通知
/// conn.sendNotify(MsgId.heartbeatReq, {});
///
/// conn.disconnect();
/// ```
class ChatTcpClient {
  final TcpClient _tcpClient = tcpClient;

  /// 消息处理器: msgId → handler（永久注册，每次收到消息都触发）
  final Map<int, void Function(ServerResp)> _handlers = {};

  /// 待应答的请求: rspMsgId → Completer（一次性，收到应答后自动移除）
  final Map<int, Completer<ServerResp?>> _pendingRequests = {};

  /// 重连时用于重发登录请求
  LoginCertificate? _cert;

  ChatTcpClient() {
    _tcpClient.onMessage = _onMessage;
    _tcpClient.onReconnected = _onReconnected;
    _tcpClient.onStatusChanged = _onStatusChanged;
    _tcpClient.onError = _onError;
  }

  // ============================================================
  // 公开 API
  // ============================================================

  /// 注册消息处理器（永久有效，每次收到对应 msgId 都触发）。
  void registerHandler(int msgId, void Function(ServerResp) handler) {
    _handlers[msgId] = handler;
  }

  /// 连接到服务器（不发送登录请求）。
  Future<void> connect(LoginCertificate cert) async {
    _cert = cert;
    final port = int.tryParse(cert.chatServerPort) ?? 0;
    await _tcpClient.connect(cert.chatServerIp, port);
  }

  /// 发送请求消息并等待指定应答。
  ///
  /// [reqMsgId] 请求消息 ID
  /// [rspMsgId] 期望的应答消息 ID
  /// [data] 请求数据
  /// [timeout] 超时时间，默认 10 秒
  ///
  /// 返回应答 [ServerResp]，超时返回 null。
  Future<ServerResp?> sendRequest(
    int reqMsgId,
    int rspMsgId,
    Map<String, dynamic> data, {
    Duration timeout = const Duration(seconds: 10),
  }) {
    _tcpClient.sendJson(reqMsgId, data);

    final completer = Completer<ServerResp?>();
    _pendingRequests[rspMsgId] = completer;

    return completer.future.timeout(timeout, onTimeout: () {
      _pendingRequests.remove(rspMsgId);
      Logger.print('ChatTcpClient — sendRequest timeout: req=$reqMsgId rsp=$rspMsgId');
      return null;
    });
  }

  /// 发送通知消息（无需等待应答）。
  void sendNotify(int msgId, Map<String, dynamic> data) {
    _tcpClient.sendJson(msgId, data);
  }

  /// 断开连接。
  void disconnect() {
    _cert = null;
    _cancelPendingRequests();
    _tcpClient.disconnect();
  }

  /// 是否已连接。
  bool get isConnected => _tcpClient.isConnected;

  /// 当前连接状态。
  TcpStatus get status => _tcpClient.status;

  // ============================================================
  // 回调注册（供外部监听）
  // ============================================================

  /// 连接状态变更回调。
  void Function(TcpStatus status)? onStatusChanged;

  // ============================================================
  // 内部回调
  // ============================================================

  void _onMessage(int msgId, Uint8List data) {
    ServerResp resp;
    try {
      final json = jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
      resp = ServerResp.fromJson(json);
    } catch (_) {
      resp = ServerResp(errCode: -1);
    }

    // 1. 优先检查是否有等待该应答的请求
    final completer = _pendingRequests.remove(msgId);
    if (completer != null && !completer.isCompleted) {
      completer.complete(resp);
    }

    // 2. 触发已注册的永久处理器（不影响请求/应答流程）
    final handler = _handlers[msgId];
    if (handler != null) {
      Logger.print('ChatTcpClient — handle msgId=$msgId, errCode=${resp.errCode}');
      handler(resp);
    } else if (completer == null) {
      Logger.print('ChatTcpClient — unhandled msgId=$msgId');
    }
  }

  void _onReconnected() {
    if (_cert == null) return;
    Logger.print('ChatTcpClient — reconnected, re-sending chatLoginReq');
    _tcpClient.sendJson(MsgId.chatLoginReq, {
      'uid': _cert!.userId,
      'token': _cert!.chatToken,
    });
  }

  void _onStatusChanged(TcpStatus status) {
    onStatusChanged?.call(status);
  }

  void _onError(dynamic error) {
    Logger.print('ChatTcpClient — TCP error: $error');
  }

  void _cancelPendingRequests() {
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.complete(ServerResp(errCode: -1));
      }
    }
    _pendingRequests.clear();
  }
}
