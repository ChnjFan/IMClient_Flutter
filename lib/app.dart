import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/controller/im_controller.dart';
import 'routes/app_pages.dart';
import 'widgets/app_view.dart';

class IMClientApp extends StatelessWidget {
  const IMClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      builder: (locale) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        translations: _AppTranslations(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: const Locale('zh', 'CN'),
        locale: locale ?? const Locale('zh', 'CN'),
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],
        getPages: AppPages.routes,
        initialBinding: InitBinding(),
        initialRoute: AppRoutes.splash,
        theme: _buildTheme(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey.shade50,
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue,
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
        barBackgroundColor: Colors.white,
        applyThemeToAll: true,
      ),
    );
  }
}

/// Simple translations stub (Chinese only for now).
class _AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {},
        'en_US': {},
      };
}

/// Global initial bindings — registers core controllers that are
/// needed app-wide (lazy, created on first `Get.find`).
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMController>(() => IMController(), fenix: true);
  }
}
