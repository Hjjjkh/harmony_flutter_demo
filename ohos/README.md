# HarmonyOS 平台配置

此目录包含华为鸿蒙 (HarmonyOS) 平台的原生代码和配置文件。

## 📁 目录说明

- `AppScope/` - 应用级配置和资源
- `entry/` - 应用入口模块
  - `src/main/ets/` - ArkTS 源代码
  - `src/main/resources/` - 资源文件
  - `src/main/assets/flutter/` - Flutter 资源目录（构建时自动复制）
  - `src/main/module.json5` - 模块配置

## 🔧 开发说明

1. 使用 DevEco Studio 打开此目录进行原生开发
2. Flutter 代码位于项目根目录的 `lib/` 目录
3. 原生能力通过 Platform Channel 与 Flutter 通信

## 📦 构建 HAP

### 方式 1: 使用自动化脚本（推荐）

在项目根目录执行：

```powershell
.\scripts\build_hap.ps1 -Mode release
```

脚本会自动：
1. 构建 Flutter 应用资源
2. 复制 Flutter 资源到鸿蒙项目
3. 提示使用 DevEco Studio 完成 HAP 打包

### 方式 2: 使用 DevEco Studio

1. 打开 DevEco Studio
2. 打开 `ohos` 目录
3. 选择 **Build** -> **Build Hap(s)/APP(s)** -> **Build Hap(s)**
4. 等待构建完成

### 方式 3: 使用命令行

```bash
cd ohos
.\hvigorw.bat assembleHap
```

## 📚 更多信息

- [HAP 打包指南](../docs/HAP_BUILD_GUIDE.md) - 详细的打包步骤
- [Flutter 集成指南](../docs/FLUTTER_HARMONYOS_INTEGRATION.md) - Flutter 与鸿蒙集成说明
- [项目主文档](../README.md) - 项目说明

---

**提示**: HAP 文件位于 `ohos/entry/build/outputs/hap/default/` 目录
