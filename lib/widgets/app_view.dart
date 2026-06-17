import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/controller/app_controller.dart';

/// App shell widget.
/// Wraps the app in [GetBuilder] for [AppController] and handles
/// foreground/background detection via a simple listener.
class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required this.builder,
  });

  final Widget Function(Locale? locale) builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (ctrl) => _AppLifecycleWatcher(
        onForegroundGained: () => ctrl.runningBackground(false),
        onForegroundLost: () => ctrl.runningBackground(true),
        child: builder(null),
      ),
    );
  }
}

/// Listens to widget lifecycle to detect foreground/background transitions.
class _AppLifecycleWatcher extends StatefulWidget {
  const _AppLifecycleWatcher({
    required this.child,
    this.onForegroundGained,
    this.onForegroundLost,
  });

  final Widget child;
  final VoidCallback? onForegroundGained;
  final VoidCallback? onForegroundLost;

  @override
  State<_AppLifecycleWatcher> createState() => _AppLifecycleWatcherState();
}

class _AppLifecycleWatcherState extends State<_AppLifecycleWatcher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onForegroundGained?.call();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        widget.onForegroundLost?.call();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
