# 华为鸿蒙 Flutter 开发配置指南

## 项目概述

本项目已配置为支持华为鸿蒙 (HarmonyOS) 平台开发。项目使用 Flutter 框架，可以同时支持多个平台包括鸿蒙、Android、iOS 等。

## 目录结构

```
harmony_flutter_demo/
├── lib/                    # Flutter Dart 代码
│   └── main.dart          # 应用主入口
├── ohos/                   # 鸿蒙平台配置
│   ├── AppScope/          # 应用级配置
│   │   ├── app.json5      # 应用信息配置
│   │   └── resources/     # 应用级资源
│   ├── entry/             # 入口模块
│   │   ├── src/
│   │   │   ├── main/
│   │   │   │   ├── ets/   # ArkTS 代码
│   │   │   │   ├── resources/  # 资源文件
│   │   │   │   └── module.json5  # 模块配置
│   │   │   └── build-profile.json5
│   │   └── build-profile.json5
│   └── build-profile.json5  # 项目构建配置
├── android/               # Android 平台配置
├── ios/                   # iOS 平台配置
└── pubspec.yaml          # Flutter 依赖配置
```

## 环境要求

### 1. 开发工具

- **Flutter SDK**: 3.9.2 或更高版本
- **DevEco Studio**: 华为鸿蒙官方 IDE（推荐版本 4.0 或更高）
- **Node.js**: 16.0 或更高版本（用于 ArkTS 编译）

### 2. 系统要求

- **Windows**: Windows 10 或更高版本
- **macOS**: macOS 10.15 或更高版本
- **Linux**: Ubuntu 18.04 或更高版本

## 配置步骤

### 步骤 1: 安装 DevEco Studio

1. 访问 [华为开发者官网](https://developer.harmonyos.com/)
2. 下载并安装 DevEco Studio
3. 配置 HarmonyOS SDK

### 步骤 2: 配置 Flutter 环境

```bash
# 检查 Flutter 环境
flutter doctor

# 检查鸿蒙平台支持
flutter devices
```

### 步骤 3: 配置鸿蒙依赖

在 `pubspec.yaml` 中配置鸿蒙专属依赖：

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 鸿蒙依赖（根据实际情况选择以下方式之一）
  # 方式1: 从 pub.dev 安装（如果可用）
  # harmony_bridge: ^0.2.1
  
  # 方式2: 从 Gitee 安装
  # harmony_bridge:
  #   git:
  #     url: https://gitee.com/your-org/harmony_bridge.git
  #     ref: main
  
  # 方式3: 本地路径
  # harmony_bridge:
  #   path: ../harmony_bridge
```

### 步骤 4: 配置应用信息

编辑 `ohos/AppScope/app.json5` 修改应用信息：

```json5
{
  "app": {
    "bundleName": "com.example.harmony_flutter_demo",  // 修改为您的包名
    "vendor": "example",                                // 修改为您的厂商名
    "versionCode": 1000000,                            // 版本代码
    "versionName": "1.0.0",                            // 版本名称
    "icon": "$media:app_icon",                         // 应用图标
    "label": "$string:app_name"                        // 应用名称
  }
}
```

### 步骤 5: 配置权限

在 `ohos/entry/src/main/module.json5` 中配置应用权限：

```json5
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET",
        "reason": "需要网络权限",
        "usedScene": {
          "abilities": ["EntryAbility"],
          "when": "inuse"
        }
      }
      // 添加更多权限...
    ]
  }
}
```

## 开发流程

### 1. 使用 Flutter 开发

主要开发工作仍在 Flutter 层进行：

```bash
# 运行 Flutter 应用
flutter run

# 构建发布版本
flutter build apk  # Android
flutter build app  # 鸿蒙（如果支持）
```

### 2. 使用 DevEco Studio 开发

1. 使用 DevEco Studio 打开 `ohos` 目录
2. 配置 HarmonyOS SDK
3. 运行或调试应用

### 3. 混合开发

- **Flutter 层**: 处理 UI 和业务逻辑
- **鸿蒙层**: 处理原生能力调用（如通知、分布式数据等）

## 常见问题

### Q1: Flutter 不支持鸿蒙平台？

A: 标准的 Flutter SDK 可能不直接支持鸿蒙平台。您需要：
1. 使用华为提供的 Flutter for HarmonyOS 版本
2. 或通过 Android 兼容层运行（HarmonyOS 早期版本支持 Android 应用）

### Q2: 如何调用鸿蒙原生 API？

A: 可以通过以下方式：
1. 使用 Platform Channel 进行 Flutter 与原生通信
2. 使用鸿蒙专属插件（如 harmony_bridge）
3. 在 `ohos/entry/src/main/ets` 中编写 ArkTS 代码

### Q3: 依赖获取失败？

A: 检查以下几点：
1. 网络连接是否正常
2. Gitee 仓库是否需要认证
3. 包路径是否正确
4. 尝试使用 SSH 方式访问 Git 仓库

## 资源链接

- [华为开发者官网](https://developer.harmonyos.com/)
- [Flutter 官方文档](https://flutter.dev/)
- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/documentation/)
- [OpenHarmony](https://www.openharmony.cn/)

## 下一步

1. 安装 DevEco Studio 并配置开发环境
2. 配置鸿蒙 SDK 路径
3. 根据实际需求添加鸿蒙专属依赖
4. 开始开发应用功能

## 注意事项

1. **包名唯一性**: 确保 `bundleName` 在应用市场上唯一
2. **权限申请**: 合理申请权限，避免过度申请
3. **版本管理**: 保持 Flutter 和 HarmonyOS SDK 版本兼容
4. **测试**: 在真实设备上测试应用功能

## 技术支持

如遇到问题，可以：
1. 查看 [HarmonyOS 开发者论坛](https://developer.huawei.com/consumer/cn/forum/)
2. 查阅官方文档
3. 联系技术支持

