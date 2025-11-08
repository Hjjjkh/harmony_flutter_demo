# Flutter 与 HarmonyOS 集成指南

## 📋 概述

本文档说明如何将 Flutter 应用集成到 HarmonyOS 项目中，并打包成 HAP 安装包。

## 🎯 集成架构

### 混合开发架构

```
┌─────────────────────────────────────┐
│         HarmonyOS HAP              │
├─────────────────────────────────────┤
│  ┌──────────────┐  ┌─────────────┐ │
│  │  Flutter UI  │  │  ArkTS UI   │ │
│  │  (Assets)    │  │  (Native)   │ │
│  └──────────────┘  └─────────────┘ │
│         │                  │        │
│  ┌──────▼──────────────────▼──────┐ │
│  │    Platform Channel            │ │
│  └────────────────────────────────┘ │
│         │                            │
│  ┌──────▼──────────────────────────┐ │
│  │   HarmonyOS Native APIs         │ │
│  └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

## 📁 目录结构

```
harmony_flutter_demo/
├── lib/                          # Flutter 源代码
│   ├── main.dart
│   ├── pages/
│   └── services/
├── build/                        # Flutter 构建产物
│   └── flutter_assets/          # Flutter 资源
│       ├── kernel_blob.bin
│       ├── isolate_snapshot_data
│       └── flutter_assets/
├── ohos/                        # HarmonyOS 项目
│   ├── entry/
│   │   └── src/
│   │       └── main/
│   │           ├── assets/
│   │           │   └── flutter/  # Flutter 资源（复制到这里）
│   │           ├── ets/          # ArkTS 源代码
│   │           └── resources/    # 资源文件
│   └── build-profile.json5
└── scripts/
    └── build_hap.ps1           # HAP 打包脚本
```

## 🔧 集成步骤

### 1. Flutter 资源准备

Flutter 构建会生成以下资源：
- `kernel_blob.bin` - Dart 内核
- `isolate_snapshot_data` - 隔离快照数据
- `isolate_snapshot_instr` - 隔离快照指令
- `flutter_assets/` - 应用资源（图片、字体等）

### 2. 资源复制

使用打包脚本自动复制，或手动复制：

```bash
# 构建 Flutter 资源
flutter build bundle --release

# 复制到鸿蒙项目
cp -r build/flutter_assets/* ohos/entry/src/main/assets/flutter/
```

### 3. Platform Channel 配置

Flutter 和鸿蒙通过 Platform Channel 通信：

**Flutter 端** (`lib/services/harmony_bridge.dart`):
```dart
static const MethodChannel _channel = MethodChannel('com.example.harmony_flutter_demo/harmony_bridge');
```

**鸿蒙端** (`ohos/entry/src/main/ets/utils/HarmonyBridgePlugin.ets`):
```typescript
// 处理 Flutter 调用
handleMethodCall(method: string, args: Object, callback: Function)
```

### 4. 构建 HAP

使用 DevEco Studio 或命令行构建 HAP：

```bash
cd ohos
.\hvigorw.bat assembleHap
```

## 📝 配置文件

### build-profile.json5

```json5
{
  "apiType": "stageMode",
  "buildOption": {
    "arkOptions": {
      "runtimeOnly": false
    }
  },
  "modules": [
    {
      "name": "entry",
      "srcPath": "./entry",
      "targets": [
        {
          "name": "default",
          "runtimeOS": "HarmonyOS"
        }
      ]
    }
  ]
}
```

### module.json5

确保配置了必要的权限和能力：

```json5
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET"
      }
    ],
    "abilities": [
      {
        "name": "EntryAbility",
        "srcEntry": "./ets/entryability/EntryAbility.ets"
      }
    ]
  }
}
```

## 🚀 打包流程

### 自动化打包

```powershell
# 完整打包流程
.\scripts\build_hap.ps1 -Mode release

# 仅构建 Flutter
.\scripts\build_hap.ps1 -FlutterBuild -Mode release
```

### 手动打包

1. **构建 Flutter**
   ```bash
   flutter build bundle --release
   ```

2. **复制资源**
   ```bash
   cp -r build/flutter_assets/* ohos/entry/src/main/assets/flutter/
   ```

3. **构建 HAP**
   - 使用 DevEco Studio: Build -> Build Hap(s)
   - 或使用命令行: `cd ohos && .\hvigorw.bat assembleHap`

## ⚠️ 注意事项

1. **资源同步**: 每次修改 Flutter 代码后，需要重新构建并复制资源
2. **路径一致性**: Flutter 资源必须放在 `assets/flutter/` 目录
3. **Platform Channel**: 确保 Flutter 和鸿蒙端的 Channel 名称一致
4. **权限配置**: 在 `module.json5` 中配置所需权限
5. **签名配置**: 发布版本需要在 DevEco Studio 中配置签名

## 📚 参考文档

- [HAP 打包指南](HAP_BUILD_GUIDE.md) - 详细的打包步骤
- [Platform Channel 文档](https://docs.flutter.dev/platform-integration/platform-channels)
- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/documentation/)

---

**提示**: 使用自动化脚本可以简化打包流程，推荐使用 `build_hap.ps1` 脚本。

