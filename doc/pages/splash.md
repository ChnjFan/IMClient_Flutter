# 启动加载页 (Splash)

## 概述

Splash 页是应用的启动画面，负责：
1. 显示品牌 Logo 和加载动画
2. 等待 IM SDK 初始化完成
3. 检查本地是否有已保存的登录凭据
4. 根据凭据存在与否决定跳转到登录页还是自动登录后进入主页

## 文件构成

| 文件 | 路径 | 职责 |
|------|------|------|
| View | [splash_view.dart](../../lib/pages/splash/splash_view.dart) | 纯 UI：渐变背景 + Logo + 加载指示器 |
| Logic | [splash_logic.dart](../../lib/pages/splash/splash_logic.dart) | 业务逻辑：SDK 初始化监听 + 自动登录 |
| Binding | [splash_binding.dart](../../lib/pages/splash/splash_binding.dart) | 依赖注入：`Get.lazyPut(SplashLogic)` |

## View 实现 ([splash_view.dart](../../lib/pages/splash/splash_view.dart))

### UI 结构

```
Container (渐变背景)
└── Stack (居中)
    ├── Icon (聊天气泡 Logo, 80px, 蓝色)
    └── Positioned (底部 120px)
        └── Column
            ├── CircularProgressIndicator (24px, 蓝色)
            └── Text (标语: "即时通讯，随时随地")
```

### 关键代码

```dart
class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final SplashLogic logic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.c_0089FF_opacity10, AppColors.c_FFFFFF_opacity0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 中心 Logo
          const Icon(AppImages.splashLogo, size: 80, color: AppColors.c_0089FF),
          // 底部加载指示器 + 标语
          const Positioned(
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24, height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.c_0089FF,
                  ),
                ),
                SizedBox(height: 12),
                Text('即时通讯，随时随地',
                  style: TextStyle(fontSize: 13, color: AppColors.c_8E9AB0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 设计要点

- **渐变背景**: 从蓝色(10%透明度)到完全透明的垂直渐变，与参考项目一致
- **无状态**: Splash 页是 `StatelessWidget`，状态由 `SplashLogic` 管理
- **依赖获取**: 通过 `Get.find<SplashLogic>()` 获取逻辑控制器（Binding 保证在此之前已注册）

---

## Logic 实现 ([splash_logic.dart](../../lib/pages/splash/splash_logic.dart))

### 逻辑流程

```
onInit()
  │
  ├── 订阅 IMController.initializedSubject
  │   └── SDK 已初始化 → _checkLoginState()
  │
  └── 如果 SDK 已经初始化 → 立即 _checkLoginState()

_checkLoginState()
  │
  ├── 等待 2 秒（让启动画面可见）
  │
  ├── 从 Storage 读取 userID 和 token
  │
  ├── 有凭据 → imLogic.login(uid, tkn)
  │   ├── 成功 → AppNavigator.startSplashToMain(isAutoLogin: true)
  │   └── 失败 → Storage.removeLoginCertificate()
  │            → AppNavigator.startLogin()
  │
  └── 无凭据 → AppNavigator.startLogin()
```

### 关键代码

```dart
class SplashLogic extends GetxController {
  final IMController imLogic = Get.find<IMController>();
  late StreamSubscription<bool> _initializedSub;

  @override
  void onInit() {
    super.onInit();
    // 监听 SDK 初始化
    _initializedSub = imLogic.initializedSubject.stream.listen((initialized) {
      if (initialized) _checkLoginState();
    });
    // 如果已初始化，立即检查
    if (imLogic.isInitialized) _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));  // 最小显示 2 秒

    final uid = await Storage.userID;
    final tkn = await Storage.token;

    if (uid != null && uid.isNotEmpty && tkn != null && tkn.isNotEmpty) {
      try {
        await imLogic.login(uid, tkn);
        AppNavigator.startSplashToMain(isAutoLogin: true);
      } catch (e) {
        await Storage.removeLoginCertificate();
        AppNavigator.startLogin();
      }
    } else {
      AppNavigator.startLogin();
    }
  }

  @override
  void onClose() {
    _initializedSub.cancel();  // 清理订阅
    super.onClose();
  }
}
```

### 设计要点

- **2 秒延迟**: 确保启动画面至少显示 2 秒，避免因快速加载导致的闪烁
- **流订阅**: 监听 `IMController.initializedSubject` 而非轮询，事件驱动
- **容错**: 自动登录失败时清除无效凭据并跳转登录页
- **资源清理**: `onClose()` 中取消流订阅，防止内存泄漏

---

## Binding 实现 ([splash_binding.dart](../../lib/pages/splash/splash_binding.dart))

```dart
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashLogic());
  }
}
```

使用 `Get.lazyPut` 惰性创建控制器——只有在首次 `Get.find<SplashLogic>()` 时才实例化。

---

## 导航分支

| 条件 | 导航方法 | 目标路由 | 导航栈 |
|------|----------|----------|--------|
| 无存储凭据 | `AppNavigator.startLogin()` | `/login` | 清栈跳转 |
| 有凭据 + 自动登录成功 | `AppNavigator.startSplashToMain()` | `/home` | 替换跳转 |
| 有凭据 + 自动登录失败 | `AppNavigator.startLogin()` | `/login` | 清栈跳转 |

---

## 依赖关系

```
SplashPage (View)
  └── Get.find<SplashLogic>()
        ├── Get.find<IMController>()     # 全局控制器
        ├── Storage.userID / Storage.token  # 凭据读取
        └── AppNavigator.startLogin() / startSplashToMain()
```

---

## 与参考项目的差异

| 方面 | 参考项目 (openim-flutter-demo) | 本项目 |
|------|-------------------------------|--------|
| IM SDK | 真实 `flutter_openim_sdk` | `IMController` 桩（模拟 SDK） |
| Push 推送 | `Get.find<PushController>()` | 未实现 |
| 会话预加载 | `ConversationLogic.getConversationFirstPage()` | 未实现 |
| UI 缩放 | `flutter_screenutil` (`.w`, `.h` 扩展) | 未使用，直接硬编码尺寸 |
| Logo 图片 | `ImageRes.splashLogo.toImage` (资源图片) | Material Icon 占位 |
