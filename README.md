# Harmony Flutter Demo

华为鸿蒙 Flutter 开发演示项目

## 项目简介

这是一个配置完整的 Flutter 项目，支持华为鸿蒙 (HarmonyOS) 平台开发。项目展示了如何在 Flutter 应用中集成鸿蒙原生能力。

## 功能特性

- ✅ Flutter 多平台支持（Android、iOS、Web、Windows、Linux、macOS）
- ✅ 鸿蒙平台配置
- ✅ Platform Channel 原生通信
- ✅ 鸿蒙功能演示（设备信息、通知、权限等）
- ✅ 完整的项目结构和文档

## 快速开始

### 1. 环境要求

- Flutter SDK 3.9.2 或更高版本
- DevEco Studio（用于鸿蒙开发）
- Node.js 16.0 或更高版本

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行应用

```bash
# 运行 Flutter 应用
flutter run

# 或在 DevEco Studio 中打开 ohos 目录
```

## 项目结构

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
├── android/                    # Android 平台
├── ios/                        # iOS 平台
├── HARMONYOS_SETUP.md         # 详细配置指南
├── QUICK_START.md             # 快速开始指南
└── pubspec.yaml               # 依赖配置
```

## 文档

### 快速开始
- [快速开始指南](QUICK_START.md) - 快速上手指南
- [鸿蒙配置指南](HARMONYOS_SETUP.md) - 详细的配置说明

### 开发协作
- [开发工作流程](DEVELOPMENT_WORKFLOW.md) - **如何通过对话框指导 AI 编写代码**
- [快速指令参考](QUICK_COMMANDS.md) - 常用指令模板
- [AI 编程指南](AI_CODING_GUIDE.md) - AI 协作指南

### GitHub 和团队协作
- [GitHub 上传指南](GITHUB_UPLOAD_GUIDE.md) - 如何上传到 GitHub
- [GitHub 设置指南](GITHUB_SETUP.md) - 仓库设置说明
- [团队协作指南](TEAM_COLLABORATION.md) - 团队协作流程
- [贡献指南](CONTRIBUTING.md) - 如何贡献代码

### 华为文档
- [华为文档说明](docs/HUAWEI_DOCS/README.md) - 文档目录说明
- [如何添加文档](docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md) - 文档添加方法

## 开发说明

### Flutter 开发

主要开发工作在 `lib/` 目录下进行，使用标准的 Flutter 开发流程。

### 鸿蒙原生开发

在 `ohos/` 目录下进行鸿蒙原生开发，使用 DevEco Studio 打开此目录。

### Platform Channel 通信

项目使用 Platform Channel 实现 Flutter 与鸿蒙原生代码的通信：

- Flutter 端：`lib/services/harmony_bridge.dart`
- 鸿蒙端：`ohos/entry/src/main/ets/utils/HarmonyBridgePlugin.ets`

## 功能演示

应用包含以下功能演示：

1. **设备信息获取** - 获取鸿蒙设备信息
2. **通知功能** - 显示原生通知
3. **权限请求** - 请求系统权限
4. **分布式能力** - 调用鸿蒙分布式能力

## 注意事项

1. **平台支持**: 标准的 Flutter SDK 可能不直接支持鸿蒙平台，可能需要使用华为提供的 Flutter for HarmonyOS 版本
2. **依赖配置**: 鸿蒙专属依赖需要根据实际情况配置，参考 `pubspec.yaml` 中的注释
3. **开发工具**: 建议使用 DevEco Studio 进行鸿蒙原生开发

## 资源链接

- [华为开发者官网](https://developer.harmonyos.com/)
- [Flutter 官方文档](https://flutter.dev/)
- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/documentation/)

## 许可证

本项目仅用于学习和演示目的。

## 贡献

欢迎提交 Issue 和 Pull Request！

---

**祝您开发愉快！** 🎉
