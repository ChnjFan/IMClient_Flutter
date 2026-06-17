import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'common/utils/logger.dart';

void main() {
  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      Logger.print(
        'FlutterError: ${details.exception.toString()}, ${details.stack.toString()}',
      );
    };

    runApp(const IMClientApp());
  }, (error, stackTrace) {
    Logger.print(
      'Uncaught error: ${error.toString()}, ${stackTrace.toString()}',
      onlyConsole: true,
    );
  });
}
