# 如何检查 SDK 配置

## 快速检查方法

### 方法 1: 使用检查脚本（推荐）

运行 SDK 检查脚本：

```powershell
.\scripts\check_sdk.ps1
```

这个脚本会自动检查：
- ✅ Flutter SDK 配置
- ✅ Node.js 配置
- ✅ HarmonyOS SDK 配置
- ✅ 项目 SDK 配置

---

### 方法 2: 手动检查

#### 1. 检查 Flutter SDK

```powershell
# 检查 Flutter 版本
flutter --version

# 检查 Flutter SDK 路径
flutter doctor -v

# 检查 Flutter 环境
flutter doctor
```

**预期结果**:
```
Flutter 3.35.7 • channel stable
```

#### 2. 检查 Node.js

```powershell
# 检查 Node.js 版本
node --version

# 检查 Node.js 路径
where.exe node
```

**预期结果**:
```
v22.21.0
```

#### 3. 检查 HarmonyOS SDK (DevEco Studio)

##### 方式 A: 检查 DevEco Studio 安装

```powershell
# 检查 DevEco Studio 是否在 PATH 中
$env:PATH -split ';' | Select-String "DevEco Studio"

# 检查常见安装路径
Test-Path "D:\Huawei\DevEco Studio\bin\devecostudio.exe"
Test-Path "C:\Program Files\Huawei\DevEco Studio\bin\devecostudio.exe"
```

##### 方式 B: 在 DevEco Studio 中检查 SDK

1. **打开 DevEco Studio**
   ```powershell
   .\scripts\open_deveco.ps1
   ```

2. **查看 SDK 配置**
   - 点击 `Tools` -> `SDK Manager`
   - 查看 `HarmonyOS SDK` 选项卡
   - 检查 SDK 版本和路径

3. **检查 SDK 路径**
   - 默认路径通常是：
     - `C:\Users\你的用户名\AppData\Local\Huawei\Sdk`
     - 或 `C:\Users\你的用户名\.ohpm\sdk`

##### 方式 C: 检查 SDK 目录

```powershell
# 检查 SDK 目录是否存在
Test-Path "$env:USERPROFILE\AppData\Local\Huawei\Sdk"
Test-Path "$env:USERPROFILE\.ohpm\sdk"

# 列出 SDK 目录内容
Get-ChildItem "$env:USERPROFILE\AppData\Local\Huawei\Sdk" -ErrorAction SilentlyContinue
```

---

### 方法 3: 使用环境检查脚本

运行完整的环境检查：

```powershell
.\scripts\check_environment.ps1
```

这会检查所有环境配置，包括 SDK。

---

## SDK 配置要求

### Flutter SDK
- **版本**: 3.9.2 或更高
- **路径**: 通常在 `C:\flutter_windows_3.35.7-stable\flutter`
- **状态**: ✅ 已安装

### Node.js
- **版本**: 16.0 或更高
- **路径**: 通常在 `C:\Program Files\nodejs`
- **状态**: ✅ 已安装 (v22.21.0)

### HarmonyOS SDK
- **版本**: 最新版本（在 DevEco Studio 中安装）
- **路径**: 通常在 `C:\Users\你的用户名\AppData\Local\Huawei\Sdk`
- **状态**: ⚠️ 需要在 DevEco Studio 中配置

---

## 常见问题

### Q1: Flutter SDK 未找到？

**解决方法**:
1. 检查 Flutter 是否已安装
2. 检查 PATH 环境变量
3. 运行 `flutter doctor` 查看详细信息

### Q2: HarmonyOS SDK 未找到？

**解决方法**:
1. 打开 DevEco Studio
2. 点击 `Tools` -> `SDK Manager`
3. 安装 HarmonyOS SDK
4. 等待 SDK 下载完成

### Q3: Node.js 版本过低？

**解决方法**:
1. 访问 https://nodejs.org/
2. 下载并安装 LTS 版本（16.0 或更高）
3. 重启终端

### Q4: 如何查看 SDK 详细信息？

**Flutter SDK**:
```powershell
flutter doctor -v
```

**HarmonyOS SDK**:
- 在 DevEco Studio 中：`Tools` -> `SDK Manager`
- 或查看 SDK 目录：`C:\Users\你的用户名\AppData\Local\Huawei\Sdk`

---

## 检查清单

使用以下清单检查 SDK 配置：

- [ ] Flutter SDK 已安装
  - [ ] 版本: 3.9.2 或更高
  - [ ] 路径已配置
  - [ ] `flutter doctor` 通过

- [ ] Node.js 已安装
  - [ ] 版本: 16.0 或更高
  - [ ] 路径已配置
  - [ ] `node --version` 正常

- [ ] DevEco Studio 已安装
  - [ ] 可以正常启动
  - [ ] 路径已配置

- [ ] HarmonyOS SDK 已配置
  - [ ] SDK 已下载
  - [ ] SDK 路径正确
  - [ ] 在 DevEco Studio 中可见

---

## 快速检查命令

### 一键检查所有 SDK

```powershell
# 检查 Flutter
flutter --version

# 检查 Node.js
node --version

# 检查 DevEco Studio
$env:PATH -split ';' | Select-String "DevEco Studio"

# 检查 HarmonyOS SDK
Test-Path "$env:USERPROFILE\AppData\Local\Huawei\Sdk"
```

### 使用脚本检查

```powershell
# SDK 检查
.\scripts\check_sdk.ps1

# 完整环境检查
.\scripts\check_environment.ps1
```

---

## 下一步

1. **运行 SDK 检查脚本**
   ```powershell
   .\scripts\check_sdk.ps1
   ```

2. **根据检查结果配置 SDK**
   - 如果 HarmonyOS SDK 未配置，在 DevEco Studio 中配置

3. **验证配置**
   - 在 DevEco Studio 中打开项目
   - 检查项目是否可以正常构建

---

## 参考文档

- `FINAL_SUMMARY.md` - 配置完成总结
- `NEXT_STEPS.md` - 下一步操作指南
- `USER_ACTION_REQUIRED.md` - 用户操作指南
- `scripts/README.md` - 脚本使用说明

---

**提示**: 使用 `.\scripts\check_sdk.ps1` 可以快速检查所有 SDK 配置！

