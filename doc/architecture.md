# 架构设计

## 目录结构

```
lib/
├── main.dart                          # 应用入口 (runZonedGuarded + runApp)
├── app.dart                           # GetMaterialApp 配置 (主题/国际化/路由/全局绑定)
│
├── common/                            # 公共层 — 所有页面共享
│   ├── res/                           #   资源常量
│   │   ├── gaps.dart                  #     间距常量 (vGap4, hGap8…)
│   │   ├── images.dart                #     图标引用 (Material Icons 占位)
│   │   └── strings.dart               #     UI 字符串 (中文)
│   ├── styles/                        #   样式常量
│   │   ├── colors.dart                #     颜色调色板 (c_0089FF…)
│   │   └── text_styles.dart           #     预定义文本样式
│   ├── utils/                         #   工具类
│   │   ├── logger.dart                #     调试日志 (仅开发模式)
│   │   └── storage.dart               #     SharedPreferences 封装
│   └── widgets/                       #   通用 UI 组件
│       ├── button.dart                #     主操作按钮 (渐变 + 禁用态)
│       ├── input_box.dart             #     输入框 (账号/密码/验证码)
│       └── touch_close_soft_keyboard.dart # 点击外部收起键盘
│
├── core/                              # 核心控制器层
│   └── controller/
│       ├── app_controller.dart        #   应用生命周期 (前后台/版本信息)
│       └── im_controller.dart         #   IM SDK 桩 (初始化/登录/登出/状态流)
│
├── routes/                            # 路由层
│   ├── app_routes.dart                #   路由名称常量 (part of app_pages)
│   ├── app_pages.dart                 #   GetPage 路由表定义
│   └── app_navigator.dart             #   集中式导航辅助类
│
├── widgets/                           # 应用级组件
│   └── app_view.dart                  #   应用壳 (生命周期监听 + AppController)
│
└── pages/                             # 页面层 (GetX 三件套模式)
    ├── splash/                        #   启动加载页
    │   ├── splash_view.dart           #     UI
    │   ├── splash_logic.dart          #     业务逻辑 (自动登录检查)
    │   └── splash_binding.dart        #     依赖注入
    ├── login/                         #   登录页
    │   ├── login_view.dart            #     UI (三标签页表单)
    │   ├── login_logic.dart           #     业务逻辑 (验证/模拟登录)
    │   └── login_binding.dart         #     依赖注入
    └── home/                          #   主页框架
        ├── home_view.dart             #     UI (底部导航 + IndexedStack)
        ├── home_logic.dart            #     业务逻辑 (标签页切换)
        └── home_binding.dart          #     依赖注入
```

## 分层架构

```
┌──────────────────────────────────────┐
│            Pages (页面层)             │
│   splash / login / home              │  ← UI + 业务逻辑 + 依赖注入
├──────────────────────────────────────┤
│         Routes (路由层)               │  ← 路由名 → 页面映射 + 导航方法
├──────────────────────────────────────┤
│      Core Controllers (核心层)        │  ← 应用级状态 (IM/生命周期)
├──────────────────────────────────────┤
│         Common (公共层)               │  ← 资源/样式/工具/通用组件
└──────────────────────────────────────┘
```

## GetX 页面模式 (三件套)

每个页面严格遵循三个文件的分工：

| 文件 | 角色 | 基类 | 职责 |
|------|------|------|------|
| `*_view.dart` | **UI** | `StatelessWidget` | 纯 UI 渲染，不含业务逻辑。通过 `Get.find<Logic>()` 获取控制器，用 `Obx()` 订阅响应式状态。 |
| `*_logic.dart` | **逻辑** | `GetxController` | 业务逻辑、表单验证、数据请求、状态管理。用 `.obs` 声明响应式变量。 |
| `*_binding.dart` | **注入** | `Bindings` | 注册控制器到 GetX 的依赖注入容器，使用 `Get.lazyPut` 实现惰性创建。 |

## 数据流

```
用户操作
    │
    ▼
View (UI) ───调用方法──► Logic (GetxController)
                              │
                              ├── 修改 .obs 变量 ──► Obx() 自动刷新 UI
                              ├── 调用 Storage (持久化)
                              ├── 调用 IMController (核心业务)
                              └── 调用 AppNavigator (页面跳转)
```

## 导航流

```
App 启动
   │
   v
Splash 页 ──有凭据──► 自动登录 ──成功──► Home 页
   │                       │
   │                       └──失败──► Login 页
   │
   └──无凭据──► Login 页 ──登录成功──► Home 页
```

## 依赖注入层次

1. **全局注册** (`app.dart` → `InitBinding`)：`IMController`（`fenix: true`，应用整个生命周期存在）
2. **页面级注册** (每个页面的 `*Binding`)：各自的 `Logic` 控制器，通过 `Get.lazyPut` 在首次访问时创建
3. **通过路由注册** (`app_pages.dart`)：`GetPage` 定义绑定与页面的关联关系
