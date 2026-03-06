# Multi-Package Flutter Sample (组件化开发示例项目)

这是一个使用 Melos 构建的多包 (Multi-package) Flutter 项目示例。该项目遵循清理架构原则，将业务功能和基础设施拆分为独立且可复用的包。

[English Documentation (README.md)](./README.md)

---

## 项目结构

工作区由 [Melos](https://melos.invert.dev/) 管理，组织为三个主要目录：

```text
.
├── app                  # 应用程序主入口
├── features             # 业务功能模块
│   ├── auth             # 身份验证（登录/注册）
│   ├── home             # 主页/仪表板
│   ├── message          # 消息/通知
│   ├── profile          # 用户个人资料与设置
│   └── splash           # 启动页流转
└── infrastructure       # 核心共享基础库
    ├── common           # 共享工具类与常量
    ├── network          # 基于 Dio 的网络层封装
    └── session          # 本地存储与会话管理
```

---

## 架构设计：接口与实现分离 (API & Impl)

本项目中的每个业务模块都拆分为两个包：`api` (接口层) 和 `impl` (实现层)。这种设计模式带来了以下核心优势：

1.  **高度解耦**：其他模块仅依赖于 `api` 层（接口），使得特性的具体实现细节对外部隐藏，且易于替换。
2.  **编译效率提升**：对具体实现 (`impl`) 的修改不需要重新编译依赖该特性的其他模块，显著加快了增量构建速度。
3.  **依赖隔离**：`api` 包保持极致轻量，依赖极少。这防止了“依赖膨胀”，避免小模块无意中引入庞大的传递依赖。
4.  **易于 Mock 测试**：在单元测试或集成测试中，Mock 业务行为变得非常简单——只需提供定义好的接口的 Mock 实现即可。

---

## MVI 架构与 Repository 模式

本项目使用 `flutter_bloc` 和 `freezed` 实现了 Model-View-Intent (MVI) 架构，以确保单向数据流和可预测的状态管理。

1. **Intent (意图)**：UI 组件将 `MviIntent`（用户交互或生命周期事件）分发给 Cubit。
2. **Model (状态)**：Cubit 处理 Intent，通过 `MviViewState`（通常是 `freezed` 数据类）更新不可变状态，并对外发射 (emit) 新状态。
3. **View (视图)**：UI 只负责纯粹地渲染接收到的最新的 `MviViewState`。
4. **Single Events (一次性事件)**：一次性的 UI 行为（如弹窗、Toast、路由跳转）通过独立的 `effectStream` 发送 `MviSingleEvent` 进行处理，与持续更新的 ViewState 状态解耦。

### Repository 模式与 SPI 设计

- **Repositories**：所有 Cubits 都与 Repository 交互，而不是直接调用网络或缓存工具类。Repository 将数据来源进行抽象。
- **跨模块 SPI**：我们利用 `get_it` 配合 `api`/`impl` 的包拆分，实现了类似 Java SPI 的模式。例如，`profile` 模块在刷新用户数据时，可以直接调用定义在 `auth_api` 的 `IAuthService` 接口。该接口由于在 `auth_impl` 模块中实现了注入，因此 `get_it` 能自动通过反射连接调用。这避免了特性实现层之间的模块强耦合。

---

## 目录说明

#### `app`
Flutter 应用程序的主工程。它充当协调器，集成所有功能模块和基础设施。包含最少的业务逻辑，主要负责依赖注入 (DI) 配置和顶级路由。

#### `features/`
- **`auth`**: 处理用户登录、注册及身份验证状态。
- **`home`**: 登录后的主要用户界面。
- **`message`**: 消息和通知功能。
- **`profile`**: 用户账户管理和设置。
- **`splash`**: 初始加载和导航逻辑。

#### `infrastructure/`
- **`common`**: 通用工具类、基类等与业务无关的逻辑。
- **`network`**: 对 `dio` 的健壮封装，支持拦截器（如自动添加 Token）。
- **`session`**: 使用 `shared_preferences` 管理持久化用户数据和应用状态。

---

## Mason 代码生成

本项目使用 [Mason](https://github.com/felangel/mason) 来保持创建新模块时的架构一致性。

### 生成新业务模块
要创建一个遵循 `api` + `impl` 模式的新业务模块，请运行：

```bash
mason make feature_module --name <你的模块名称>
```

这将自动生成标准的目录结构、`pubspec.yaml` 文件以及新模块的基础范本代码。

---

## 核心技术与特性

- **架构**: 多包工作区 (Multi-package Workspace)，接口与实现分离。
- **状态管理**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)。
- **依赖注入**: [get_it](https://pub.dev/packages/get_it) 与 [injectable](https://pub.dev/packages/injectable)。
- **多包管理**: 使用 [Melos](https://melos.invert.dev/) 进行跨包命令执行。
- **多环境支持**: 通过 `.env` 文件和 `dart-define` 支持 QA 和 Production 环境构建。
- **代码规范**: 在 `all_lint_rules.yaml` 中定义了严格的静态分析规则。

---

## 开发指南

### 前置条件

- [FVM](https://fvm.app/) (项目使用特定的 Flutter SDK 版本)
- [Melos](https://melos.invert.dev/) (通过 `dart pub global activate melos` 全局安装)
- [Mason](https://github.com/felangel/mason) (通过 `dart pub global activate mason_cli` 全局安装)

### 快速开始

1. **项目初始化 (Bootstrap)**:
   ```bash
   melos bootstrap
   ```

2. **生成代码 (DI/JSON)**:
   ```bash
   melos run generate
   ```

3. **代码检查 (Lint)**:
   ```bash
   melos run lint:all
   ```

### 项目构建

- **构建 QA 版本 APK**:
  ```bash
  melos run build:qa
  ```
- **构建生产 (Prod) 版本 APK**:
  ```bash
  melos run build:prod
  ```

---

## 参考与致谢

本项目参考了并部分引用了 [building-a-multi-package-project-with-flutter](https://engineer-journal.hashnode.dev/building-a-multi-package-project-with-flutter) 的部分实现。

感谢开源社区。
