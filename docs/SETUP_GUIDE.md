# 环境配置指南

## 📋 环境要求

### 必需工具
- **Flutter SDK**: 3.9.2 或更高版本
- **DevEco Studio**: 华为鸿蒙官方 IDE（推荐版本 4.0 或更高）
- **Node.js**: 16.0 或更高版本（用于 ArkTS 编译）
- **Git**: 版本控制工具

### 系统要求
- **Windows**: Windows 10 或更高版本
- **macOS**: macOS 10.15 或更高版本
- **Linux**: Ubuntu 18.04 或更高版本

---

## 🚀 快速配置

### 1. 安装 Flutter

1. 下载 Flutter SDK：https://flutter.dev/docs/get-started/install
2. 解压到合适的位置
3. 添加到 PATH 环境变量
4. 运行 `flutter doctor` 检查环境

### 2. 安装 DevEco Studio

1. 访问 [华为开发者官网](https://developer.harmonyos.com/)
2. 下载并安装 DevEco Studio
3. 配置 OpenHarmony SDK

### 3. 安装 Node.js

1. 下载 Node.js：https://nodejs.org/
2. 安装 LTS 版本（推荐 16.0 或更高）
3. 验证安装：`node --version`

### 4. 配置项目

```bash
# 克隆项目
git clone https://github.com/Hjjjkh/harmony_flutter_demo.git
cd harmony_flutter_demo

# 安装依赖
flutter pub get

# 检查环境
flutter doctor
```

---

## ✅ 环境检查

### 使用脚本检查

```powershell
# Windows
.\scripts\check_environment.ps1
.\scripts\check_sdk.ps1
```

### 手动检查

```bash
# 检查 Flutter
flutter --version
flutter doctor

# 检查 Node.js
node --version
npm --version

# 检查 DevEco Studio
# 在 DevEco Studio 中查看 SDK 配置
```

---

## 🔧 常见问题

### Flutter 环境问题

**问题**: `flutter doctor` 显示错误

**解决**:
1. 检查 Flutter SDK 路径
2. 检查环境变量配置
3. 运行 `flutter doctor -v` 查看详细信息

### OpenHarmony SDK 问题

**问题**: 找不到 OpenHarmony SDK

**解决**:
1. 在 DevEco Studio 中配置 SDK 路径
2. 检查 SDK 版本是否兼容
3. 运行 `.\scripts\check_sdk.ps1` 检查

### 依赖问题

**问题**: `flutter pub get` 失败

**解决**:
1. 检查网络连接
2. 检查 `pubspec.yaml` 配置
3. 清理缓存：`flutter clean && flutter pub get`

---

## 📚 参考文档

- [快速开始](../QUICK_START.md) - 快速上手指南
- [鸿蒙配置指南](../HARMONYOS_SETUP.md) - 详细的配置说明
- [SDK 检查指南](../HOW_TO_CHECK_SDK.md) - SDK 检查方法

---

**配置完成后，可以开始开发了！** 🎉

