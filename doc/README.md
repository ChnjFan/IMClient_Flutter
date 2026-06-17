# IMClient Flutter — 项目文档

## 项目简介

IMClient Flutter 是一个即时通讯（IM）移动客户端项目，使用 **Flutter** 框架和 **GetX** 状态管理库构建。当前实现包含应用的加载启动页（Splash）、登录页（Login）和主页框架（Home）。

## 文档目录

| 文档 | 说明 |
|------|------|
| [architecture.md](architecture.md) | 架构设计、目录结构、分层说明 |
| [getx-patterns.md](getx-patterns.md) | GetX 框架在项目中的使用模式 |
| [routing.md](routing.md) | 路由系统、页面注册、导航方法 |
| [common-layer.md](common-layer.md) | 公共层：资源、样式、工具类、通用组件 |
| [pages/splash.md](pages/splash.md) | 启动加载页实现 |
| [pages/login.md](pages/login.md) | 登录页实现 |
| [pages/home.md](pages/home.md) | 主页框架实现 |

## 技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| Flutter | ≥3.11.5 | UI 框架 |
| Dart | ≥3.11.5 | 编程语言 |
| get | ^4.6.13 | 路由管理 + 状态管理 + 依赖注入 |
| shared_preferences | ^2.3.0 | 本地键值存储（凭据持久化） |
| package_info_plus | ^10.1.0 | 获取应用版本信息 |
| path_provider | ^2.1.1 | 获取设备文件路径 |
| rxdart | ^0.28.0 | 响应式流处理 |

## 参考项目

本项目目录结构和实现方式参照 [openim-flutter-demo](https://github.com/openimsdk/openim-flutter-demo)：

- **目录结构**: 每个页面拆分为 `view`（UI）、`logic`（业务逻辑/控制器）、`binding`（依赖注入）三个文件
- **GetX 模式**: 使用 `GetMaterialApp`、`GetPage`、`Bindings`、`GetxController`、`.obs` 响应式变量、`Obx` 响应式 UI
- **导航管理**: 通过 `AppNavigator` 集中管理所有页面跳转
- **命名风格**: 颜色/样式常量使用 `c_`/`ts_` 前缀（与参考项目一致）

## 快速开始

```bash
# 安装依赖
flutter pub get

# 运行静态分析
flutter analyze

# 运行应用
flutter run
```
