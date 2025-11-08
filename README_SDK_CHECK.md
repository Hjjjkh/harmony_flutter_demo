# SDK 检查指南

## 🚀 快速检查 SDK

### 方法 1: 使用检查脚本（最简单）

```powershell
.\scripts\check_sdk.ps1
```

**刚刚运行的结果**:
```
========================================
  SDK Configuration Check
========================================

1. Checking Flutter SDK...
  [OK] Flutter SDK installed
    SDK Path: C:\flutter_windows_3.35.7-stable\flutter
    Version: 3.35.7
    Dart Version: 3.9.2

2. Checking Node.js...
  [OK] Node.js installed: v22.21.0
    Version OK (>= 16.0)

3. Checking HarmonyOS SDK (DevEco Studio)...
  [OK] DevEco Studio in PATH
  [WARN] HarmonyOS SDK directory not found
    Please configure SDK in DevEco Studio:
      Tools -> SDK Manager -> HarmonyOS SDK

4. Checking project SDK configuration...
  [OK] Flutter SDK version in pubspec.yaml: ^3.9.2
  [OK] HarmonyOS build profile found

[SUCCESS] Basic SDKs configured, but there are warnings:
  [WARN] HarmonyOS SDK directory not found. You may need to configure it in DevEco Studio.

Next steps:
1. Configure HarmonyOS SDK in DevEco Studio
2. Tools -> SDK Manager -> HarmonyOS SDK
```

---

### 方法 2: 使用快速启动菜单

```powershell
.\scripts\quick_start.ps1
```

然后选择 `2. 检查 SDK 配置`

---

### 方法 3: 手动检查命令

#### 检查 Flutter SDK
```powershell
flutter --version
flutter doctor -v
```

#### 检查 Node.js
```powershell
node --version
where.exe node
```

#### 检查 DevEco Studio
```powershell
$env:PATH -split ';' | Select-String "DevEco Studio"
```

#### 检查 HarmonyOS SDK
```powershell
Test-Path "$env:USERPROFILE\AppData\Local\Huawei\Sdk"
Get-ChildItem "$env:USERPROFILE\AppData\Local\Huawei\Sdk" -ErrorAction SilentlyContinue
```

---

## 📊 当前 SDK 状态

根据刚刚的检查结果：

### ✅ 已配置的 SDK

1. **Flutter SDK**
   - ✅ 已安装
   - 版本: 3.35.7
   - 路径: `C:\flutter_windows_3.35.7-stable\flutter`
   - Dart 版本: 3.9.2

2. **Node.js**
   - ✅ 已安装
   - 版本: v22.21.0
   - 路径: `C:\Program Files\nodejs\node.exe`
   - 版本符合要求 (>= 16.0)

3. **DevEco Studio**
   - ✅ 已安装
   - 路径: `D:\Huawei\DevEco Studio\bin`
   - 已在 PATH 中配置

### ⚠️ 需要配置的 SDK

1. **HarmonyOS SDK**
   - ⚠️ SDK 目录未找到
   - 需要在 DevEco Studio 中配置
   - 配置方法：`Tools` -> `SDK Manager` -> `HarmonyOS SDK`

---

## 🔧 如何配置 HarmonyOS SDK

### 步骤 1: 打开 DevEco Studio

```powershell
.\scripts\open_deveco.ps1
```

或手动打开：
```
D:\Huawei\DevEco Studio\bin\devecostudio.exe
```

### 步骤 2: 配置 SDK

1. **打开 SDK Manager**
   - 点击 `Tools` -> `SDK Manager`
   - 或按 `Ctrl + Alt + S` 打开设置，然后选择 `SDK`

2. **安装 HarmonyOS SDK**
   - 选择 `HarmonyOS SDK` 选项卡
   - 选择 SDK 安装路径（建议使用默认路径）
   - 点击 `Apply` 或 `OK`
   - 等待 SDK 下载完成

3. **验证 SDK 安装**
   - 检查 SDK 路径：`C:\Users\你的用户名\AppData\Local\Huawei\Sdk`
   - 运行检查脚本：`.\scripts\check_sdk.ps1`

---

## 📝 SDK 检查清单

使用以下清单检查 SDK 配置：

### Flutter SDK
- [x] ✅ 已安装
- [x] ✅ 版本: 3.35.7
- [x] ✅ 路径已配置
- [x] ✅ `flutter doctor` 通过

### Node.js
- [x] ✅ 已安装
- [x] ✅ 版本: v22.21.0 (>= 16.0)
- [x] ✅ 路径已配置
- [x] ✅ `node --version` 正常

### DevEco Studio
- [x] ✅ 已安装
- [x] ✅ 可以正常启动
- [x] ✅ 路径已配置

### HarmonyOS SDK
- [ ] ⚠️ 需要在 DevEco Studio 中配置
- [ ] ⚠️ SDK 需要下载
- [ ] ⚠️ SDK 路径需要配置

---

## 🎯 下一步操作

1. **运行 SDK 检查**
   ```powershell
   .\scripts\check_sdk.ps1
   ```

2. **配置 HarmonyOS SDK**
   - 打开 DevEco Studio
   - 配置 SDK（见上方说明）

3. **再次检查 SDK**
   ```powershell
   .\scripts\check_sdk.ps1
   ```

4. **开始开发**
   - 在 DevEco Studio 中打开 `ohos` 目录
   - 开始开发鸿蒙应用

---

## 📚 相关文档

- `HOW_TO_CHECK_SDK.md` - 详细的 SDK 检查方法
- `FINAL_SUMMARY.md` - 配置完成总结
- `NEXT_STEPS.md` - 下一步操作指南
- `scripts/README.md` - 脚本使用说明

---

## ❓ 常见问题

### Q: HarmonyOS SDK 在哪里？

**A**: 默认情况下，HarmonyOS SDK 安装在：
- `C:\Users\你的用户名\AppData\Local\Huawei\Sdk`
- 或 `C:\Users\你的用户名\.ohpm\sdk`

### Q: 如何查看 SDK 版本？

**A**: 
1. 在 DevEco Studio 中：`Tools` -> `SDK Manager`
2. 或查看 SDK 目录内容

### Q: SDK 检查脚本显示警告怎么办？

**A**: 
- 如果是 HarmonyOS SDK 未找到，这是正常的
- 需要在 DevEco Studio 中配置 SDK
- 按照上面的步骤配置即可

---

**提示**: 使用 `.\scripts\check_sdk.ps1` 可以快速检查所有 SDK 配置！

