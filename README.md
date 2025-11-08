# Harmony Flutter Demo

<div align="center">

![HarmonyOS](https://img.shields.io/badge/HarmonyOS-4.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.35.7-blue)
![License](https://img.shields.io/badge/License-MIT-green)

**团队协作开发鸿蒙应用 | 使用 Cursor AI 辅助开发**

一个配置完整的 Flutter + HarmonyOS 混合开发项目，支持团队协作，利用 Cursor AI 提升开发效率。

[快速开始](#-快速开始) • [团队协作](#-团队协作) • [Cursor 配置](#-cursor-配置) • [贡献指南](CONTRIBUTING.md)

</div>

---

## 🎯 项目定位

本项目旨在：

- ✅ **团队协作开发鸿蒙应用** - 提供完整的项目结构和协作流程
- ✅ **利用 Cursor AI 提升效率** - 配置 Cursor 使用鸿蒙文档和约束规则
- ✅ **赚取开发者激励** - 通过团队协作和高效开发获得华为开发者激励

---

## ✨ 功能特性

- ✅ **Flutter + HarmonyOS 混合开发** - Flutter UI + 鸿蒙原生能力
- ✅ **Platform Channel 通信** - Flutter 与鸿蒙原生代码无缝通信
- ✅ **Cursor AI 辅助开发** - 配置 Cursor 使用鸿蒙文档和约束规则
- ✅ **团队协作支持** - GitHub 工作流、Issue 模板、PR 模板
- ✅ **完整文档** - 开发指南、配置说明、最佳实践
- ✅ **自动化脚本** - 环境检查、SDK 检查、快速启动

---

## 🚀 快速开始

### 环境要求

- **Flutter SDK**: 3.9.2 或更高版本
- **DevEco Studio**: 华为鸿蒙官方 IDE（推荐版本 4.0 或更高）
- **Node.js**: 16.0 或更高版本（用于 ArkTS 编译）
- **Cursor**: AI 代码编辑器（推荐）

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
   ```

4. **配置 Cursor**（可选但推荐）
   - 参考 [Cursor 配置指南](#-cursor-配置)
   - 让 AI 更好地理解鸿蒙开发规范

5. **开始开发**
   ```bash
   # 运行 Flutter 应用
   flutter run
   
   # 或在 DevEco Studio 中打开 ohos 目录进行鸿蒙原生开发
   ```

---

## 💻 Cursor 配置

### 为什么需要配置 Cursor？

Cursor 等 AI 工具在生成鸿蒙代码时，由于缺乏足够的训练语料，经常生成不符合规范的代码。通过配置，可以让 Cursor 更好地理解鸿蒙开发规范。

### 配置步骤

#### 1. 配置文档知识库

在 Cursor 设置中添加鸿蒙官方文档：

1. 打开 Cursor 设置
2. 找到 "Documentation" 或 "Knowledge Base" 设置
3. 添加文档 URL：`https://developer.harmonyos.com/cn/documentation/`
4. 自定义名称：`ohos`

使用方式：在对话中使用 `@ohos` 引用鸿蒙知识库。

#### 2. 配置 CursorRules

使用项目中的约束规则文件作为 CursorRules：

1. 在项目根目录创建 `.cursorrules` 文件
2. 将 `docs/HUAWEI_DOCS/constraints/` 目录下的规则内容添加到 `.cursorrules`
3. 配置规则应用范围（可选）

#### 3. 使用自动化工具（推荐）

参考开源项目 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules)：

- 自动爬取华为官方文档
- 自动生成 CursorRules 文件
- 支持按模块生成规则

**项目地址**: https://github.com/skindhu/harmony-cursor-rules

### 详细配置指南

- [Cursor 精通鸿蒙开发指南](docs/CURSOR_HARMONYOS_GUIDE.md) - 完整的配置方法和原理说明

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
│   ├── CURSOR_HARMONYOS_GUIDE.md  # Cursor 配置指南（参考）
│   ├── GITHUB_GUIDE.md        # GitHub 使用指南
│   ├── SETUP_GUIDE.md         # 环境配置指南
│   └── HUAWEI_DOCS/           # 华为文档目录
│       ├── README.md
│       ├── HOW_TO_ADD_DOCS.md
│       └── constraints/       # 约束规则（用于 CursorRules）
├── scripts/                     # 脚本工具
│   ├── check_environment.ps1  # 环境检查
│   ├── check_sdk.ps1          # SDK 检查
│   └── quick_start.ps1        # 快速启动菜单
├── android/                    # Android 平台
├── ios/                        # iOS 平台
└── pubspec.yaml               # 依赖配置
```

---

## 🤝 团队协作

### 工作流程

1. **创建 Issue** - 描述问题或功能需求
2. **创建分支** - 从 `main` 创建功能分支
3. **开发** - 使用 Cursor AI 辅助编写代码
4. **提交 PR** - 创建 Pull Request
5. **代码审查** - 团队成员审查
6. **合并** - 审查通过后合并

### 使用 Cursor 协作开发

团队成员可以通过 Cursor 的 AI 功能：

- **对话式编程** - 在对话框中描述需求，AI 自动生成代码
- **代码审查** - AI 辅助代码审查和优化
- **文档查询** - 使用 `@ohos` 查询鸿蒙开发文档
- **规范检查** - CursorRules 自动检查代码规范

### 详细指南

- [团队协作指南](TEAM_COLLABORATION.md) - 团队协作最佳实践
- [开发工作流程](DEVELOPMENT_WORKFLOW.md) - 如何使用 Cursor 进行开发
- [贡献指南](CONTRIBUTING.md) - 如何贡献代码
- [GitHub 使用指南](docs/GITHUB_GUIDE.md) - GitHub 协作流程

---

## 🔧 开发说明

### Flutter 开发

主要开发工作在 `lib/` 目录下进行，使用标准的 Flutter 开发流程。

**使用 Cursor**：
```
添加一个用户登录页面，包含用户名和密码输入框
```

### 鸿蒙原生开发

在 `ohos/` 目录下进行鸿蒙原生开发，使用 DevEco Studio 打开此目录。

**使用 Cursor**：
```
在鸿蒙端实现相机功能，通过 Platform Channel 返回图片数据
```

### Platform Channel 通信

项目使用 Platform Channel 实现 Flutter 与鸿蒙原生代码的通信：

- **Flutter 端**: `lib/services/harmony_bridge.dart`
- **鸿蒙端**: `ohos/entry/src/main/ets/utils/HarmonyBridgePlugin.ets`

---

## 📚 文档

### 核心文档

- **[快速开始指南](QUICK_START.md)** - 快速上手指南
- **[鸿蒙配置指南](HARMONYOS_SETUP.md)** - 详细的配置说明
- **[开发工作流程](DEVELOPMENT_WORKFLOW.md)** - 如何使用 Cursor 进行开发

### 团队协作

- **[团队协作指南](TEAM_COLLABORATION.md)** - 团队协作最佳实践
- **[贡献指南](CONTRIBUTING.md)** - 如何贡献代码
- **[GitHub 使用指南](docs/GITHUB_GUIDE.md)** - GitHub 协作流程

### 环境配置

- **[环境配置指南](docs/SETUP_GUIDE.md)** - 完整的环境配置说明
- **[SDK 检查指南](docs/SDK_CHECK.md)** - SDK 检查方法

### 参考资源

- **[Cursor 精通鸿蒙开发指南](docs/CURSOR_HARMONYOS_GUIDE.md)** - Cursor 配置方法和原理（参考）
- **[harmony-cursor-rules 项目](https://github.com/skindhu/harmony-cursor-rules)** - 自动化生成 CursorRules 的工具
- **[华为文档说明](docs/HUAWEI_DOCS/README.md)** - 如何添加和管理华为文档

---

## 🎨 功能演示

应用包含以下功能演示：

1. **设备信息获取** - 获取鸿蒙设备信息
2. **通知功能** - 显示原生通知
3. **权限请求** - 请求系统权限
4. **分布式能力** - 调用鸿蒙分布式能力

---

## 💰 开发者激励

本项目支持团队协作开发，通过以下方式获得华为开发者激励：

- ✅ 完成鸿蒙应用开发
- ✅ 参与华为开发者活动
- ✅ 提交优质应用
- ✅ 团队协作贡献

更多信息请访问：[华为开发者官网](https://developer.harmonyos.com/)

---

## 📝 注意事项

1. **平台支持**: 标准的 Flutter SDK 不直接支持鸿蒙平台，本项目使用混合开发方式（Flutter UI + 鸿蒙原生）
2. **依赖配置**: 鸿蒙专属依赖需要根据实际情况配置，参考 `pubspec.yaml` 中的注释
3. **开发工具**: 建议使用 DevEco Studio 进行鸿蒙原生开发，使用 Cursor 进行 Flutter 开发
4. **Cursor 配置**: 配置 Cursor 可以显著提升开发效率，建议参考配置指南

---

## 🔗 资源链接

### 官方资源
- [华为开发者官网](https://developer.harmonyos.com/)
- [Flutter 官方文档](https://flutter.dev/)
- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/documentation/)

### 工具和参考
- [Cursor 官方文档](https://cursor.sh/docs)
- [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) - 自动化生成 CursorRules 的工具（非本项目）

---

## 📄 许可证

本项目仅用于学习和演示目的。

---

## 🙏 致谢

- [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) - 感谢提供 Cursor 配置方法和工具
- 华为鸿蒙开发团队 - 感谢提供优秀的开发平台

---

## 💬 贡献

欢迎提交 Issue 和 Pull Request！

- [贡献指南](CONTRIBUTING.md)
- [团队协作指南](TEAM_COLLABORATION.md)

---

<div align="center">

**让我们一起用 Cursor 高效开发鸿蒙应用，赚取开发者激励！** 🚀

Made with ❤️ for HarmonyOS Development

</div>
