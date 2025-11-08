# Harmony Flutter Demo

<div align="center">

![HarmonyOS](https://img.shields.io/badge/HarmonyOS-4.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.35.7-blue)
![License](https://img.shields.io/badge/License-MIT-green)

**华为鸿蒙 Flutter 开发演示项目**

一个配置完整的 Flutter 项目，支持华为鸿蒙 (HarmonyOS) 平台开发，展示如何在 Flutter 应用中集成鸿蒙原生能力。

[快速开始](#-快速开始) • [文档](#-文档) • [团队协作](#-团队协作) • [贡献指南](CONTRIBUTING.md)

</div>

---

## ✨ 功能特性

- ✅ **Flutter 多平台支持** - Android、iOS、Web、Windows、Linux、macOS
- ✅ **鸿蒙平台配置** - 完整的 HarmonyOS 项目结构
- ✅ **Platform Channel 通信** - Flutter 与鸿蒙原生代码无缝通信
- ✅ **AI 辅助开发** - 配置 Cursor 使用鸿蒙文档和约束规则
- ✅ **团队协作支持** - GitHub 工作流、Issue 模板、PR 模板
- ✅ **完整文档** - 开发指南、配置说明、最佳实践

---

## 🚀 快速开始

### 环境要求

- **Flutter SDK**: 3.9.2 或更高版本
- **DevEco Studio**: 华为鸿蒙官方 IDE（推荐版本 4.0 或更高）
- **Node.js**: 16.0 或更高版本（用于 ArkTS 编译）

### 安装步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/Hjjjkh/harmony_flutter_demo.git
   cd harmony_flutter_demo
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **检查环境**
   ```bash
   # Windows
   .\scripts\check_environment.ps1
   .\scripts\check_sdk.ps1
   
   # Linux/macOS
   ./scripts/check_environment.sh
   ```

4. **运行应用**
   ```bash
   # 运行 Flutter 应用
   flutter run
   
   # 或在 DevEco Studio 中打开 ohos 目录
   ```

---

## 📁 项目结构

```
harmony_flutter_demo/
├── lib/                          # Flutter Dart 代码
│   ├── main.dart                # 应用主入口
│   ├── pages/                   # 页面
│   │   └── harmony_demo_page.dart
│   └── services/                # 服务
│       └── harmony_bridge.dart  # 鸿蒙桥接服务
├── ohos/                        # 鸿蒙平台配置
│   ├── AppScope/               # 应用级配置
│   ├── entry/                  # 入口模块
│   │   └── src/main/
│   │       ├── ets/           # ArkTS 代码
│   │       └── resources/     # 资源文件
│   └── build-profile.json5    # 构建配置
├── docs/                        # 文档目录
│   ├── CURSOR_HARMONYOS_GUIDE.md  # Cursor 精通鸿蒙开发指南
│   ├── GITHUB_GUIDE.md        # GitHub 使用指南
│   ├── SETUP_GUIDE.md         # 环境配置指南
│   ├── SDK_CHECK.md           # SDK 检查指南
│   └── HUAWEI_DOCS/           # 华为文档目录
│       ├── README.md
│       ├── HOW_TO_ADD_DOCS.md
│       └── constraints/       # 约束规则
├── scripts/                     # 脚本工具
│   ├── check_environment.ps1  # 环境检查
│   ├── check_sdk.ps1          # SDK 检查
│   └── quick_start.ps1        # 快速启动菜单
├── android/                    # Android 平台
├── ios/                        # iOS 平台
└── pubspec.yaml               # 依赖配置
```

---

## 📚 文档

### 🎯 核心文档

- **[快速开始指南](QUICK_START.md)** - 快速上手指南
- **[鸿蒙配置指南](HARMONYOS_SETUP.md)** - 详细的配置说明
- **[Cursor 精通鸿蒙开发指南](docs/CURSOR_HARMONYOS_GUIDE.md)** - ⭐ **如何配置 Cursor 使用鸿蒙文档和约束规则**

### 💻 开发协作

- **[开发工作流程](DEVELOPMENT_WORKFLOW.md)** - **如何通过对话框指导 AI 编写代码**
- **[快速指令参考](QUICK_COMMANDS.md)** - 常用指令模板
- **[AI 编程指南](AI_CODING_GUIDE.md)** - AI 协作指南

### 🤝 团队协作

- **[GitHub 使用指南](docs/GITHUB_GUIDE.md)** - GitHub 协作流程
- **[团队协作指南](TEAM_COLLABORATION.md)** - 团队协作最佳实践
- **[贡献指南](CONTRIBUTING.md)** - 如何贡献代码

### ⚙️ 环境配置

- **[环境配置指南](docs/SETUP_GUIDE.md)** - 完整的环境配置说明
- **[SDK 检查指南](docs/SDK_CHECK.md)** - SDK 检查方法

### 📖 华为文档

- **[华为文档说明](docs/HUAWEI_DOCS/README.md)** - 文档目录说明
- **[如何添加文档](docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md)** - 文档添加方法

### 📋 项目信息

- **[项目总结](docs/PROJECT_SUMMARY.md)** - 项目概述和已完成工作

---

## 🎯 如何使用 Cursor 开发鸿蒙应用

### 1. 配置 Cursor 文档知识库

在 Cursor 设置中添加鸿蒙官方文档：

```
https://developer.harmonyos.com/cn/documentation/
```

使用 `@ohos` 引用鸿蒙知识库。

### 2. 配置 CursorRules

使用项目中的约束规则文件作为 CursorRules，确保生成的代码符合 ArkTS 规范。

详细说明请参考：[Cursor 精通鸿蒙开发指南](docs/CURSOR_HARMONYOS_GUIDE.md)

### 3. 通过对话框编写代码

直接在对话框中描述需求，AI 会自动编写代码：

```
添加一个用户登录页面，包含用户名和密码输入框
```

---

## 🔧 开发说明

### Flutter 开发

主要开发工作在 `lib/` 目录下进行，使用标准的 Flutter 开发流程。

### 鸿蒙原生开发

在 `ohos/` 目录下进行鸿蒙原生开发，使用 DevEco Studio 打开此目录。

### Platform Channel 通信

项目使用 Platform Channel 实现 Flutter 与鸿蒙原生代码的通信：

- **Flutter 端**: `lib/services/harmony_bridge.dart`
- **鸿蒙端**: `ohos/entry/src/main/ets/utils/HarmonyBridgePlugin.ets`

---

## 🎨 功能演示

应用包含以下功能演示：

1. **设备信息获取** - 获取鸿蒙设备信息
2. **通知功能** - 显示原生通知
3. **权限请求** - 请求系统权限
4. **分布式能力** - 调用鸿蒙分布式能力

---

## 🤝 团队协作

### 工作流程

1. **创建 Issue** - 描述问题或功能
2. **创建分支** - 从 `main` 创建功能分支
3. **开发** - 编写代码（可以使用 Cursor AI 辅助）
4. **提交 PR** - 创建 Pull Request
5. **代码审查** - 团队成员审查
6. **合并** - 审查通过后合并

详细说明请参考：[团队协作指南](TEAM_COLLABORATION.md)

---

## 📝 注意事项

1. **平台支持**: 标准的 Flutter SDK 不直接支持鸿蒙平台，本项目使用混合开发方式（Flutter UI + 鸿蒙原生）
2. **依赖配置**: 鸿蒙专属依赖需要根据实际情况配置，参考 `pubspec.yaml` 中的注释
3. **开发工具**: 建议使用 DevEco Studio 进行鸿蒙原生开发，使用 Cursor 进行 Flutter 开发

---

## 🔗 资源链接

- [华为开发者官网](https://developer.harmonyos.com/)
- [Flutter 官方文档](https://flutter.dev/)
- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/documentation/)
- [Cursor 官方文档](https://cursor.sh/docs)
- [harmony-cursor-rules 项目](https://github.com/skindhu/harmony-cursor-rules) - 自动化生成 CursorRules

---

## 📄 许可证

本项目仅用于学习和演示目的。

---

## 🙏 致谢

- [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) - 感谢提供 Cursor 配置方法
- 华为鸿蒙开发团队 - 感谢提供优秀的开发平台

---

## 💬 贡献

欢迎提交 Issue 和 Pull Request！

- [贡献指南](CONTRIBUTING.md)
- [团队协作指南](TEAM_COLLABORATION.md)

---

<div align="center">

**祝您开发愉快！** 🎉

Made with ❤️ for HarmonyOS Development

</div>
