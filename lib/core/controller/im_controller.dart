import 'dart:async';
import 'package:get/get.dart';
import '../../common/utils/logger.dart';
import '../../common/utils/storage.dart';

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
  final faceURL = ''.obs;
  final token = ''.obs;

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
    initializedSubject.add(true);

    Logger.print('IMController — SDK initialized');
  }

  /// Simulate user login.
  Future<bool> login(String uid, String tkn) async {
    try {
      Logger.print('IMController — logging in userID: $uid');
      imSdkStatus(IMSdkStatus.connecting);

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      userID.value = uid;
      token.value = tkn;

      imSdkStatus(IMSdkStatus.syncStart);
      await Future.delayed(const Duration(milliseconds: 300));
      imSdkStatus(IMSdkStatus.syncEnded);

      Logger.print('IMController — login success');
      return true;
    } catch (e) {
      Logger.print('IMController — login failed: $e');
      imSdkStatus(IMSdkStatus.connectionFailed);
      return false;
    }
  }

  /// Simulate logout.
  Future<void> logout() async {
    Logger.print('IMController — logging out');
    userID.value = '';
    token.value = '';
    nickname.value = '';
    faceURL.value = '';
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
    _controller.add(event);
  }

  void listen(void Function(T event) onData) {
    _controller.stream.listen(onData);
  }

  void close() {
    _controller.close();
  }
}
