# 脚本说明

本目录包含用于项目开发和管理的 PowerShell 脚本。

## 脚本列表

### 1. `check_environment.ps1`
**功能**: 检查开发环境是否配置正确

**使用方法**:
```powershell
.\scripts\check_environment.ps1
```

**检查项目**:
- Flutter 安装
- Node.js 安装和版本
- DevEco Studio 安装
- Dart 安装
- 项目文件完整性
- Flutter 依赖

---

### 2. `setup.ps1`
**功能**: 初始化项目环境

**使用方法**:
```powershell
.\scripts\setup.ps1
```

**执行操作**:
- 检查 Flutter 环境
- 获取 Flutter 依赖
- 分析代码
- 检查项目文件

---

### 3. `open_deveco.ps1`
**功能**: 快速打开 DevEco Studio 并加载 ohos 项目

**使用方法**:
```powershell
.\scripts\open_deveco.ps1
```

**功能**:
- 自动查找 DevEco Studio 安装路径
- 打开 ohos 项目目录

---

### 4. `build_flutter.ps1`
**功能**: 构建 Flutter 应用

**使用方法**:
```powershell
# 构建 APK (默认)
.\scripts\build_flutter.ps1

# 构建指定平台
.\scripts\build_flutter.ps1 -Platform apk -Mode release
.\scripts\build_flutter.ps1 -Platform appbundle -Mode release
.\scripts\build_flutter.ps1 -Platform web -Mode release

# 构建模式
# -Mode debug    : 调试模式
# -Mode profile  : 性能分析模式
# -Mode release  : 发布模式（默认）
```

**参数**:
- `-Platform`: 构建平台 (apk, appbundle, ios, web, windows, linux, macos)
- `-Mode`: 构建模式 (debug, profile, release)

---

### 5. `quick_start.ps1`
**功能**: 快速启动菜单，提供常用功能的快捷访问

**使用方法**:
```powershell
.\scripts\quick_start.ps1
```

**功能菜单**:
1. 检查开发环境
2. 初始化项目
3. 打开 DevEco Studio
4. 获取 Flutter 依赖
5. 分析代码
6. 构建应用 (APK)
7. 运行 Flutter 应用
8. 查看项目信息
0. 退出

---

## 使用建议

### 首次使用
1. 运行 `setup.ps1` 初始化项目
2. 运行 `check_environment.ps1` 检查环境
3. 运行 `open_deveco.ps1` 打开 DevEco Studio

### 日常开发
1. 使用 `quick_start.ps1` 快速访问常用功能
2. 使用 `build_flutter.ps1` 构建应用
3. 使用 `check_environment.ps1` 检查环境问题

---

## 注意事项

1. **执行策略**: 如果脚本无法运行，可能需要修改 PowerShell 执行策略：
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **路径**: 脚本会自动检测项目根目录，确保在项目根目录下运行

3. **权限**: 某些操作可能需要管理员权限

4. **错误处理**: 如果脚本执行失败，请查看错误信息并根据提示修复

---

## 故障排除

### 问题: 脚本无法执行
**解决**: 修改执行策略（见上方）

### 问题: DevEco Studio 未找到
**解决**: 检查 `open_deveco.ps1` 中的路径，或手动修改脚本中的路径

### 问题: Flutter 命令未找到
**解决**: 确保 Flutter 已安装并在 PATH 环境变量中

---

## 扩展脚本

如果需要添加新脚本，请：
1. 在 `scripts/` 目录下创建新的 `.ps1` 文件
2. 添加适当的错误处理
3. 更新本文档
4. 在 `quick_start.ps1` 中添加菜单项（如需要）

---

**提示**: 使用 `quick_start.ps1` 可以快速访问所有功能！

