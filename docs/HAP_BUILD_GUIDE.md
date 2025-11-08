# HarmonyOS HAP 打包指南

## 📋 概述

本文档说明如何将 Flutter 应用打包成 HarmonyOS HAP 安装包。

## 🎯 打包流程

### 方式 1: 使用自动化脚本（推荐）

#### 步骤 1: 构建 Flutter 应用

```powershell
# 构建 Flutter 资源
.\scripts\build_hap.ps1 -Mode release -FlutterBuild
```

脚本会自动：
1. ✅ 构建 Flutter 应用资源
2. ✅ 复制 Flutter 资源到鸿蒙项目
3. ✅ 提示使用 DevEco Studio 完成 HAP 打包

#### 步骤 2: 使用 DevEco Studio 打包 HAP

1. 打开 DevEco Studio
2. 打开 `ohos` 目录
3. 选择 **Build** -> **Build Hap(s)/APP(s)** -> **Build Hap(s)**
4. 等待构建完成

### 方式 2: 手动打包

#### 步骤 1: 构建 Flutter 资源

```bash
# 构建 Flutter 资源
flutter build bundle --release
```

#### 步骤 2: 复制 Flutter 资源

将 Flutter 构建产物复制到鸿蒙项目：

```bash
# Windows
xcopy /E /I /Y build\flutter_assets ohos\entry\src\main\assets\flutter

# Linux/macOS
cp -r build/flutter_assets/* ohos/entry/src/main/assets/flutter/
```

#### 步骤 3: 使用 DevEco Studio 打包

1. 打开 DevEco Studio
2. 打开 `ohos` 目录
3. 选择 **Build** -> **Build Hap(s)/APP(s)** -> **Build Hap(s)**

### 方式 3: 使用命令行（需要 hvigor）

```bash
cd ohos
.\hvigorw.bat assembleHap
```

## 📁 目录结构

```
ohos/
├── entry/
│   └── src/
│       └── main/
│           └── assets/
│               └── flutter/          # Flutter 资源目录
│                   ├── kernel_blob.bin
│                   ├── isolate_snapshot_data
│                   ├── isolate_snapshot_instr
│                   └── flutter_assets/
│                       ├── AssetManifest.json
│                       ├── FontManifest.json
│                       └── ...
└── build/
    └── outputs/
        └── hap/
            └── default/
                └── entry-default-signed.hap  # HAP 安装包
```

## 🔧 配置说明

### Flutter 资源集成

Flutter 构建产物需要复制到 `ohos/entry/src/main/assets/flutter/` 目录。

### 构建配置

- **构建模式**: `debug` 或 `release`
- **API 版本**: 在 `ohos/build-profile.json5` 中配置
- **应用信息**: 在 `ohos/AppScope/app.json5` 中配置

## 📝 注意事项

1. **Flutter 资源路径**: Flutter 资源必须放在 `assets/flutter/` 目录下
2. **资源同步**: 每次修改 Flutter 代码后，需要重新构建并复制资源
3. **构建工具**: 主要使用 DevEco Studio 的 hvigor 构建系统
4. **签名配置**: 发布版本需要配置签名，在 DevEco Studio 中配置

## 🚀 快速命令

```powershell
# 完整打包流程
.\scripts\build_hap.ps1 -Mode release

# 仅构建 Flutter，不打包 HAP
.\scripts\build_hap.ps1 -FlutterBuild -Mode release

# 清理后重新构建
.\scripts\build_hap.ps1 -Clean -Mode release
```

## 📚 参考文档

- [HarmonyOS 应用打包指南](https://developer.harmonyos.com/cn/documentation/)
- [DevEco Studio 使用指南](https://developer.harmonyos.com/cn/documentation/)

---

**提示**: 推荐使用 DevEco Studio 进行 HAP 打包，它提供了完整的构建和签名功能。

