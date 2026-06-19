import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'logger.dart';

import '../models/msg_id.dart';

/// TCP 连接状态。
enum TcpStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

/// 全局 TCP 长连接客户端实例，App 启动时即可用，
/// 登录后调用 [tcpClient.connect] 建立连接。
final tcpClient = TcpClient._();

/// TCP 长连接管理。
///
/// 消息格式（二进制）：
///   [2 字节 MsgId] [2 字节 DataLen] [DataLen 字节 Data]
///
/// 使用方式：
/// ```dart
/// tcpClient.onMessage = (msgId, data) => print('收到 msgId=$msgId');
/// tcpClient.onStatusChanged = (s) => print('状态: $s');
/// await tcpClient.connect('192.168.1.1', 8080);
/// tcpClient.sendJson(1001, {'key': 'value'});
/// ```
class TcpClient {
  TcpClient._();
  Socket? _socket;
  StreamSubscription<Uint8List>? _subscription;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;

  /// 重连间隔（秒）
  int reconnectInterval = 5;

  /// 最大重连次数，0 表示无限
  int maxReconnectAttempts = 0;

  /// 心跳间隔（秒），0 表示不发送心跳
  int heartbeatInterval = 30;

  /// 上次发送消息的时间
  DateTime _lastSendTime = DateTime.now();

  /// 当前重连次数
  int _reconnectAttempts = 0;
  bool _isReconnecting = false;

  /// 目标地址和端口
  String? _host;
  int? _port;

  /// 连接状态
  TcpStatus _status = TcpStatus.disconnected;
  TcpStatus get status => _status;

  /// 消息回调: msgId + 原始数据
  void Function(int msgId, Uint8List data)? onMessage;

  /// 状态变更回调
  void Function(TcpStatus status)? onStatusChanged;

  /// 错误回调
  void Function(dynamic error)? onError;

  /// 重连成功后回调（用于重新发送认证消息）
  void Function()? onReconnected;

  /// 是否已连接
  bool get isConnected => _status == TcpStatus.connected;

  /// 连接到服务器。
  Future<void> connect(String host, int port) async {
    _host = host;
    _port = port;
    await _doConnect();
  }

  Future<void> _doConnect() async {
    if (_host == null || _port == null) return;

    _setStatus(TcpStatus.connecting);

    try {
      _socket = await Socket.connect(
        _host!,
        _port!,
        timeout: const Duration(seconds: 10),
      );
      _socket!.setOption(SocketOption.tcpNoDelay, true);

      _reconnectAttempts = 0;
      _setStatus(TcpStatus.connected);
      Logger.print('TCP connected to $_host:$_port');

      _startHeartbeat();
      _startListening();

      // 重连成功后回调（发送认证消息）
      if (_isReconnecting) {
        _isReconnecting = false;
        onReconnected?.call();
      }
    } catch (e) {
      Logger.print('TCP connect failed: $e');
      _setStatus(TcpStatus.disconnected);
      _tryReconnect();
      onError?.call(e);
    }
  }

  // ============================================================
  // 接收（二进制帧解析）
  // ============================================================

  final List<int> _recvBuffer = [];

  void _startListening() {
    _subscription?.cancel();
    _recvBuffer.clear();

    _subscription = _socket!.listen(
      (data) {
        Logger.print('TCP raw recv: ${data.length} bytes');
        _recvBuffer.addAll(data);
        _parseFrames();
      },
      onError: (e) {
        Logger.print('TCP error: $e');
        onError?.call(e);
      },
      onDone: () {
        Logger.print('TCP onDone');
        _onDisconnected();
      },
      cancelOnError: true,
    );
  }

  /// 从缓冲区解析完整帧: [MsgId 2B][DataLen 2B][Data]
  void _parseFrames() {
    while (_recvBuffer.length >= 4) {
      final bytes = Uint8List.fromList(_recvBuffer);
      final data = ByteData.sublistView(bytes);

      final msgId = data.getUint16(0, Endian.big);
      final dataLen = data.getUint16(2, Endian.big);

      if (_recvBuffer.length < 4 + dataLen) {
        Logger.print('TCP recv: incomplete frame, need $dataLen have ${_recvBuffer.length - 4}');
        return;
      }

      _recvBuffer.removeRange(0, 4);
      final payload = Uint8List.fromList(_recvBuffer.sublist(0, dataLen));
      _recvBuffer.removeRange(0, dataLen);

      Logger.print('TCP recv: msgId=$msgId len=$dataLen');
      if (onMessage != null) {
        onMessage!(msgId, payload);
      } else {
        Logger.print('TCP recv: onMessage is null, dropping msgId=$msgId');
      }
    }
  }

  // ============================================================
  // 发送
  // ============================================================

  /// 发送原始字节（自动添加帧头）。
  void send(int msgId, Uint8List data) {
    if (!isConnected || _socket == null) return;

    try {
      final header = ByteData(4)
        ..setUint16(0, msgId, Endian.big)
        ..setUint16(2, data.length, Endian.big);

      // header + data 合并为一次写入，避免 tcpNoDelay 下分成两个 TCP 包
      final packet = Uint8List(4 + data.length);
      packet.setRange(0, 4, header.buffer.asUint8List());
      packet.setRange(4, packet.length, data);
      _socket!.add(packet);
      _lastSendTime = DateTime.now();
      Logger.print('TCP send: msgId=$msgId len=${data.length}');
    } catch (e) {
      Logger.print('TCP send error: $e');
      onError?.call(e);
    }
  }

  /// 发送 JSON 消息（自动序列化并添加帧头）。
  void sendJson(int msgId, Map<String, dynamic> json) {
    send(msgId, Uint8List.fromList(utf8.encode(jsonEncode(json))));
  }

  // ============================================================
  // 连接管理
  // ============================================================

  /// 断开连接。
  void disconnect() {
    _stopHeartbeat();
    _stopReconnect();
    _subscription?.cancel();
    _subscription = null;
    _socket?.destroy();
    _socket = null;
    _recvBuffer.clear();
    _setStatus(TcpStatus.disconnected);
    Logger.print('TCP disconnected');
  }

  void _onDisconnected() {
    _stopHeartbeat();
    _subscription?.cancel();
    _subscription = null;
    _socket = null;
    _recvBuffer.clear();

    if (_status == TcpStatus.connected) {
      _setStatus(TcpStatus.disconnected);
      Logger.print('TCP connection lost');
      _tryReconnect();
    }
  }

  // ============================================================
  // 心跳
  // ============================================================

  void _startHeartbeat() {
    _stopHeartbeat();
    if (heartbeatInterval <= 0) return;

    _lastSendTime = DateTime.now();
    _heartbeatTimer = Timer.periodic(
      Duration(seconds: heartbeatInterval),
      (_) {
        final elapsed = DateTime.now().difference(_lastSendTime).inSeconds;
        if (elapsed >= heartbeatInterval - 1) {
          Logger.print('TCP heartbeat — idle ${elapsed}s, sending ping');
          send(MsgId.heartbeatReq, Uint8List(0));
        } else {
          Logger.print('TCP heartbeat — skip, last send ${elapsed}s ago');
        }
      },
    );
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  // ============================================================
  // 重连
  // ============================================================

  void _tryReconnect() {
    if (_reconnectTimer != null) return;
    if (maxReconnectAttempts > 0 && _reconnectAttempts >= maxReconnectAttempts) {
      Logger.print('TCP max reconnect attempts reached');
      return;
    }

    _isReconnecting = true;
    _reconnectAttempts++;
    _setStatus(TcpStatus.reconnecting);

    final delay = reconnectInterval + Random().nextInt(5);
    Logger.print('TCP reconnecting in ${delay}s (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(Duration(seconds: delay), () {
      _reconnectTimer = null;
      _doConnect();
    });
  }

  void _stopReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;
  }

  // ============================================================
  // 内部
  // ============================================================

  void _setStatus(TcpStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      onStatusChanged?.call(newStatus);
    }
  }

  /// 释放所有资源。
  void dispose() {
    disconnect();
  }
}
