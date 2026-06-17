import 'package:flutter/foundation.dart';

/// Simple logger that prints only in debug mode.
class Logger {
  static void print(String message, {bool onlyConsole = false}) {
    if (kDebugMode) {
      debugPrint('[IMClient] $message');
    }
  }
}
