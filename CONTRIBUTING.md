# 贡献指南

欢迎参与项目开发！本文档说明如何为项目做出贡献。

## 📋 贡献方式

### 1. 报告问题
- 使用 GitHub Issues 报告 bug
- 提供详细的问题描述和复现步骤
- 包含环境信息（Flutter 版本、系统版本等）

### 2. 提出建议
- 使用 GitHub Issues 提出功能建议
- 描述功能需求和预期效果
- 讨论实现方案

### 3. 提交代码
- Fork 项目
- 创建功能分支
- 提交 Pull Request
- 等待代码审查

## 🔀 工作流程

### 1. Fork 项目
1. 在 GitHub 上 Fork 本项目
2. 克隆到本地：
   ```bash
   git clone https://github.com/your-username/harmony_flutter_demo.git
   ```

### 2. 创建分支
```bash
git checkout -b feature/your-feature-name
```

### 3. 开发
- 编写代码
- 添加测试
- 更新文档
- 遵循代码规范

### 4. 提交
```bash
git add .
git commit -m "feat: 添加新功能描述"
```

### 5. 推送
```bash
git push origin feature/your-feature-name
```

### 6. 创建 Pull Request
- 在 GitHub 上创建 PR
- 填写详细的描述
- 等待审查

## 📝 代码规范

### Flutter/Dart 代码
- 遵循 Dart 官方代码规范
- 使用 `flutter format` 格式化代码
- 使用有意义的变量和函数名
- 添加必要的注释

### 鸿蒙 ArkTS 代码
- 遵循鸿蒙开发规范
- 使用 TypeScript 最佳实践
- 添加类型注解
- 添加必要的注释

### 提交信息
使用约定式提交格式：
- `feat:` 新功能
- `fix:` 修复 bug
- `docs:` 文档更新
- `style:` 代码格式
- `refactor:` 重构
- `test:` 测试
- `chore:` 构建/工具

## 🧪 测试

### 运行测试
```bash
flutter test
```

### 检查代码
```bash
flutter analyze
```

## 📚 文档

- 新功能需要更新相关文档
- 重要变更需要更新 README
- API 变更需要更新文档

## ✅ 检查清单

提交 PR 前请确认：
- [ ] 代码通过 `flutter analyze`
- [ ] 所有测试通过
- [ ] 代码已格式化
- [ ] 文档已更新
- [ ] 提交信息清晰

## 🤝 代码审查

- PR 需要至少一人审查
- 审查通过后合并
- 保持友好的沟通

## 📞 联系方式

如有问题，可以：
- 创建 GitHub Issue
- 联系项目维护者

---

感谢您的贡献！🎉

