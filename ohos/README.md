# HarmonyOS 平台配置

此目录包含华为鸿蒙 (HarmonyOS) 平台的原生代码和配置文件。

## 目录说明

- `AppScope/` - 应用级配置和资源
- `entry/` - 应用入口模块
  - `src/main/ets/` - ArkTS 源代码
  - `src/main/resources/` - 资源文件
  - `src/main/module.json5` - 模块配置

## 开发说明

1. 使用 DevEco Studio 打开此目录进行原生开发
2. Flutter 代码位于项目根目录的 `lib/` 目录
3. 原生能力通过 Platform Channel 与 Flutter 通信

## 构建命令

```bash
# 在项目根目录执行
flutter build app  # 构建鸿蒙应用（如果支持）
```

## 更多信息

请参阅项目根目录的 `HARMONYOS_SETUP.md` 文件。

