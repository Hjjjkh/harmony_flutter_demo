# SDK 检查指南

## 🎯 快速检查

### 使用脚本（推荐）

```powershell
# Windows
.\scripts\check_sdk.ps1
```

脚本会自动检查：
- ✅ Flutter SDK 配置
- ✅ Node.js 配置
- ✅ HarmonyOS SDK 配置
- ✅ DevEco Studio 配置

### 手动检查

```bash
# 检查 Flutter
flutter --version
flutter doctor

# 检查 Node.js
node --version

# 检查 HarmonyOS SDK
# 在 DevEco Studio 中查看 SDK 配置
```

---

## 📋 检查清单

### Flutter SDK
- [ ] Flutter 已安装
- [ ] 版本 >= 3.9.2
- [ ] 已添加到 PATH
- [ ] `flutter doctor` 无错误

### Node.js
- [ ] Node.js 已安装
- [ ] 版本 >= 16.0
- [ ] npm 可用

### DevEco Studio
- [ ] DevEco Studio 已安装
- [ ] HarmonyOS SDK 已配置
- [ ] SDK 版本正确

### HarmonyOS SDK
- [ ] SDK 路径正确
- [ ] SDK 版本 >= 4.0
- [ ] SDK 组件完整

---

## 🔧 常见问题

### SDK 路径问题

**问题**: 找不到 HarmonyOS SDK

**解决**:
1. 检查 SDK 路径：`C:\Users\<用户名>\AppData\Local\OpenHarmony\Sdk`
2. 在 DevEco Studio 中配置 SDK 路径
3. 运行 `.\scripts\check_sdk.ps1` 检查

### 版本不兼容

**问题**: SDK 版本不兼容

**解决**:
1. 检查项目要求的 SDK 版本
2. 更新 SDK 到兼容版本
3. 在 DevEco Studio 中更新 SDK

---

## 📚 参考文档

- [环境配置指南](SETUP_GUIDE.md) - 完整的环境配置说明
- [快速开始](../QUICK_START.md) - 快速上手指南

---

**检查完成后，可以开始开发了！** 🎉

