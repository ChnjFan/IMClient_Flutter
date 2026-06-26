# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在本仓库中工作时提供指导。

## 常用命令

```bash
# 代码生成 — 修改 tables.dart、database.dart 注解或 DAO 文件后必须执行
dart run build_runner build

# 静态分析
flutter analyze

# 调试运行
flutter run

# 构建 Android APK（release）
flutter build apk --release

# 构建 iOS
flutter build ios --release

# 运行单个测试
flutter test test/path/to/file_test.dart
```

## 项目架构

### 技术栈
- **Flutter** + **GetX**：状态管理、依赖注入、路由
- **Drift** (`^2.21.0`)：本地 SQLite 数据库
- **Dio**：HTTP 网络请求
- **原生 TCP Socket** (`dart:io`)：IM 消息通信，自定义二进制协议

### 启动流程

1. `main()` → `AppConfig.init()` — 初始化 `Storage`（SharedPreferences）、`AppDatabase`（Drift）、`IMController`、`HttpUtils`
2. `AppConfig.init()` 将 `AppDatabase` 和 `IMController` 通过 `Get.put(..., permanent: true)` 注册为 GetX 全局永久单例
3. `IMClientApp`（`app.dart`）组装 `GetMaterialApp`，加载 `AppPages.routes`，初始路由 `/splash`
4. `SplashLogic` 查询 `AppDatabase.credentialDao` 中是否有缓存的登录凭证 → 有则走 `IMController.login()` 自动登录，无则跳转 `/login`

### 页面模式（GetX）

每个页面遵循三层结构 + 一个绑定文件：

```
lib/pages/<功能模块>/
  <模块>_binding.dart   # GetX Bindings — lazyPut 注入 Controller
  <模块>_logic.dart     # GetX Controller — 业务逻辑，Rx 响应式状态
  <模块>_view.dart      # Flutter Widget — UI 视图
```

- **Binding**：`Get.lazyPut(() => XxxLogic())` — 首次 `Get.find()` 时才创建。注意本项目不用 `fenix: true`，Controller 创建后一直存活直到手动 `Get.delete()`。
- **Logic**：继承 `GetxController`，持有 `.obs` 响应式状态，实现 `onInit()`/`onClose()` 生命周期。页面间通过 `Get.arguments` 接收参数，通过 `Get.back(result: value)` 返回结果。
- **View**：使用 `Obx(() => ...)` 响应式重建 UI。
- 所有页面跳转统一走 `AppNavigator` 静态方法，底层封装 `Get.toNamed`/`Get.offAllNamed`。

### 路由系统

- 路径常量定义：`lib/routes/app_routes.dart`
- 路由表：`lib/routes/app_pages.dart`（映射路径 → 页面 + 绑定）
- 导航入口：`lib/routes/app_navigator.dart`（全部页面跳转的唯一入口）

**AppNavigator 约定**：需要接收页面返回值的导航方法，返回 `Future<T?>?`，如 `startNameEdit()`。调用方可以 `await` 获取编辑结果。不需要返回值的方法返回 `void`，如 `startLogin()`。

### 模型层

- `UserInfo`（`lib/common/models/user/user_info.dart`）— 基础用户信息（uid、name、alias、email、avatarUrl）
- `UserFullInfo` 继承 `UserInfo` — 补充 phone、gender、birthday、signature、region、selfIntro、friendStatus、createTime 等
- `getShowName()` 方法定义在 `UserInfo` 中，优先级：**alias > name > uid**
- `LoginCertificate` — TCP 连接所需的凭证（userId、chatToken、server IP/Port）
- `ServerResp` — TCP 应答的通用封装（isSuccess、data、errCode）
- `MsgId`（`lib/common/models/msg_id.dart`）— 全部消息 ID 常量，按类别分段：登录/注册(1xxx)、好友(2xxx)、用户资料(21xx)、聊天(3xxx)、会话(4xxx)、系统(5xxx)

### 网络层（双通道）

**HTTP**（`lib/common/apis.dart` + `lib/common/utils/http_utils.dart`）：
- REST 接口调用：登录、注册、重置密码、验证码
- `ApiService` 静态方法 → `HttpUtils`（Dio 封装）→ 服务器

**TCP**（`lib/core/controller/chat_tcp_client.dart` + `lib/common/utils/tcp_utils.dart`）：
- 持久 Socket 长连接，承载 IM 即时消息通信
- 二进制消息格式：`[2 字节 MsgId] [2 字节 DataLen] [DataLen 字节 JSON]`
- **请求/应答模式**：`sendRequest(reqMsgId, rspMsgId, data)` 返回 `Future<ServerResp?>`
- **通知模式**（发后即忘）：`sendNotify(msgId, data)`
- 全局单例：`tcpUtils.dart` 中的 `tcpClient`
- `IMController` 封装 `ChatTcpClient`，提供高层 IM 方法（登录、拉取好友列表、申请列表、更新好友信息等）

### 数据库层（Drift）

**表定义** 在 `lib/common/db/tables.dart`：
- `UserCredentials` — 登录凭证缓存（仅维护一条记录）
- `UserProfiles` — 用户资料缓存（自己和联系人）
- `Friends` — 已确认的好友关系
- `FriendRequests` — 待处理的好友申请
- `Conversations` — 最近会话列表
- `Messages` — 按会话缓存的消息
- `AppSettings` — 键值对配置存储

**DAO** 在 `lib/common/db/daos/` — 每个 DAO 通过 `@DriftAccessor` 注解关联对应的表。修改表定义或 DAO 后，运行 `dart run build_runner build` 重新生成 `.g.dart` 文件。

**重要**：重新设计表结构之前，先删除所有 `.g.dart` 文件，再执行 `build_runner` 重新生成，禁止直接修改、读取所有 `*.g.dart` 文件。每个 DAO 均提供 `clear()` 方法用于调试时清空整表。

### 核心控制器

- `IMController`（`lib/core/controller/im_controller.dart`）— IM SDK 生命周期管理，登录/登出，好友操作，TCP 状态流。注册为 GetX 全局永久单例。`logout()` 会清空全部 7 张数据库表（调试用）。
- `AppController`（`lib/core/controller/app_controller.dart`）— 应用前后台切换检测
- `ChatTcpClient`（`lib/core/controller/chat_tcp_client.dart`）— TCP 消息路由、重连、心跳。内部维护 `_handlers`（永久）和 `_pendingRequests`（一次性 Completer）两套消息回调。

### 可复用组件（`lib/component/`）

- `Toast` — 轻提示工具（`AppToast.show(msg)` / `AppToast.error(msg)`）
- `GenderPicker` — 性别选择器 BottomSheet
- `DatePicker` — 日期选择器 BottomSheet
- `RegionPicker` — 地区选择器 BottomSheet

### 关键约定

- **时间字段**（`createTime`、`updateTime`、`sendTime`）：数据库中以 `int` 毫秒时间戳存储；服务端返回的时间字符串通过 `Validators.parseTimeToMs()` 转换
- **服务端 ID**：使用服务端返回的 `id` 字段，存为可空 int（来自服务端的数据不使用自增主键）
- **增量同步**：DAO 提供 `getMaxId()` 方法（表空时返回 0）和 `syncFromServer(list, {int sinceId = 0})` 方法。`sinceId == 0` 时为全量同步（先清表再插入）
- **Stream 驱动 UI 更新**：DAO 查询通过 `.watch()` 返回 `Stream<List<T>>`，GetX Controller 中用 `RxList` 消费
- **联表查询**：DAO 提供 `watchXxxWithProfile()` 方法，通过左连接 `UserProfiles` 表获取头像、昵称等展示信息
- **好友列表过滤**：好友列表渲染时必须过滤掉当前登录用户自己（`userId != currentUid`）
- **UserProfilePanel 参数**：跨页面传递用户信息时，如果已有完整 `UserFullInfo` 对象应该直接传入（避免重复请求服务端），仅当只有 `userId` 字符串时才从服务端拉取
