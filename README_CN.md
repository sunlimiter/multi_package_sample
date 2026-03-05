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

### 目录说明

#### `app`
Flutter 应用程序的主工程。它充当协调器，集成所有功能模块和基础设施。包含最少的业务逻辑，主要负责依赖注入 (DI) 配置和顶级路由。

#### `features/`
每个功能模块分为 `api` (接口层) 和 `impl` (实现层)。
- **`auth`**: 处理用户登录、注册及身份验证状态。
- **`home`**: 登录后的主要用户界面。
- **`message`**: 消息和通知功能。
- **`profile`**: 用户账户管理和设置。
- **`splash`**: 初始加载和导航逻辑。

#### `infrastructure/`
整个项目通用的共享库。
- **`common`**: 通用工具类、基类等与业务无关的逻辑。
- **`network`**: 对 `dio` 的健壮封装，支持拦截器（如自动添加 Token）。
- **`session`**: 使用 `shared_preferences` 管理持久化用户数据和应用状态。

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
