# 快速开始指南

## 项目配置完成 ✅

您的 Flutter 项目已配置为支持 OpenHarmony 开发。以下是快速开始步骤：

## 1. 环境检查

```bash
# 检查 Flutter 环境
flutter doctor

# 检查依赖
flutter pub get
```

## 2. 项目结构

```
openharmony_flutter_demo/
├── lib/                          # Flutter Dart 代码
│   ├── main.dart                # 应用主入口
│   ├── pages/                   # 页面
│   │   └── harmony_demo_page.dart
│   └── services/                # 服务
│       └── harmony_bridge.dart  # OpenHarmony桥接服务
├── ohos/                        # OpenHarmony平台配置
│   ├── AppScope/               # 应用配置
│   └── entry/                  # 入口模块
└── pubspec.yaml                # 依赖配置
```

## 3. 运行应用

### 方式 1: 使用 Flutter CLI

```bash
# 运行应用（如果 Flutter 支持OpenHarmony平台）
flutter run

# 构建应用
flutter build app
```

### 方式 2: 使用 DevEco Studio

1. 打开 DevEco Studio
2. 选择 "Open" 并选择 `ohos` 目录
3. 配置 OpenHarmony SDK
4. 运行应用

## 4. 功能演示

应用包含以下功能演示：

- **设备信息获取**: 获取OpenHarmony设备信息
- **通知功能**: 显示原生通知
- **权限请求**: 请求系统权限
- **分布式能力**: 调用OpenHarmony分布式能力

## 5. 下一步

1. **安装 DevEco Studio**
   - 访问 https://developer.harmonyos.com/
   - 下载并安装 DevEco Studio

2. **配置OpenHarmony SDK**
   - 在 DevEco Studio 中配置 OpenHarmony SDK
   - 设置 SDK 路径

3. **配置依赖**
   - 根据实际情况在 `pubspec.yaml` 中配置OpenHarmony依赖
   - 参考 `HARMONYOS_SETUP.md` 获取详细说明

4. **开发功能**
   - 在 `lib/` 目录下开发 Flutter 代码
   - 在 `ohos/entry/src/main/ets/` 下开发原生代码
   - 使用 Platform Channel 进行通信

## 6. 常见问题

### Q: Flutter 不支持OpenHarmony平台？

**A:** 标准的 Flutter SDK 可能不直接支持OpenHarmony。您需要：
- 使用华为提供的 Flutter for OpenHarmony 版本
- 或通过 Android 兼容层运行

### Q: 如何调用OpenHarmony原生 API？

**A:** 通过 Platform Channel：
1. 在 Flutter 中使用 `HarmonyBridge` 服务
2. 在OpenHarmony原生代码中实现对应的方法
3. 参考 `lib/services/harmony_bridge.dart` 和 `ohos/entry/src/main/ets/utils/OpenHarmonyBridgePlugin.ets`

### Q: 依赖获取失败？

**A:** 
1. 检查网络连接
2. 确认 Gitee 仓库是否需要认证
3. 尝试使用 SSH 方式访问 Git 仓库
4. 或使用本地路径依赖

## 7. 参考文档

- [完整配置指南](OPENHARMONY_SETUP.md)
- [华为开发者官网](https://developer.harmonyos.com/)
- [Flutter 官方文档](https://flutter.dev/)

## 8. 技术支持

如遇到问题，可以：
1. 查看 `OPENHARMONY_SETUP.md` 获取详细配置说明
2. 访问华为开发者论坛
3. 查阅官方文档

---

祝您开发愉快！🎉

