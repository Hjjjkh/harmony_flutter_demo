# 团队协作指南

## 🎯 概述

本文档说明如何在团队中协作开发此项目。

## 📋 工作流程

### 1. 获取代码

```bash
# 克隆仓库
git clone https://github.com/your-org/harmony_flutter_demo.git

# 进入目录
cd harmony_flutter_demo

# 安装依赖
flutter pub get
```

### 2. 创建分支

```bash
# 从 main 分支创建功能分支
git checkout -b feature/your-feature-name

# 或从 develop 分支创建
git checkout -b feature/your-feature-name develop
```

### 3. 开发

- 编写代码
- 运行测试
- 检查代码格式
- 更新文档

### 4. 提交代码

```bash
# 添加文件
git add .

# 提交（使用约定式提交格式）
git commit -m "feat: 添加新功能"

# 推送
git push origin feature/your-feature-name
```

### 5. 创建 Pull Request

1. 在 GitHub 上创建 PR
2. 填写详细的描述
3. 关联相关 Issue
4. 等待代码审查

### 6. 代码审查

- 审查者检查代码
- 提出修改建议
- 通过后合并

## 🔀 分支策略

### 主分支
- `main` - 生产环境代码
- `develop` - 开发环境代码

### 功能分支
- `feature/功能名称` - 新功能开发
- `bugfix/问题描述` - Bug 修复
- `hotfix/问题描述` - 紧急修复

## 📝 提交规范

### 约定式提交

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 类型
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式
- `refactor`: 重构
- `test`: 测试
- `chore`: 构建/工具

### 示例
```
feat(login): 添加用户登录功能

实现用户名密码登录
添加记住密码功能
添加登录状态管理

Closes #123
```

## 🤝 代码审查

### 审查检查点
- [ ] 代码逻辑正确
- [ ] 遵循代码规范
- [ ] 有适当的测试
- [ ] 文档已更新
- [ ] 没有引入安全问题

### 审查反馈
- 使用友好的语气
- 提供具体的建议
- 解释原因
- 可以要求修改或直接修改

## 📚 文档协作

### 添加文档
1. 在 `docs/` 目录下创建文档
2. 更新相关索引
3. 提交 PR

### 更新文档
- 功能变更时更新文档
- 保持文档与代码同步
- 使用清晰的描述

## 🛠️ 开发工具

### 必需工具
- Flutter SDK
- DevEco Studio
- Git
- Node.js

### 推荐工具
- VS Code / Cursor
- Git 客户端
- 代码格式化工具

## 📞 沟通方式

### GitHub Issues
- 报告问题
- 提出建议
- 讨论功能

### Pull Requests
- 代码审查
- 讨论实现
- 合并代码

### 团队沟通
- 使用团队沟通工具
- 定期同步进度
- 分享经验

## ✅ 检查清单

### 提交前
- [ ] 代码通过 `flutter analyze`
- [ ] 所有测试通过
- [ ] 代码已格式化
- [ ] 文档已更新
- [ ] 提交信息清晰

### PR 前
- [ ] 代码已自检
- [ ] 测试已添加
- [ ] 文档已更新
- [ ] 已关联 Issue
- [ ] 已请求审查

## 🎯 最佳实践

1. **小步提交**: 频繁提交，每次提交一个功能
2. **清晰描述**: 提交信息和 PR 描述要清晰
3. **及时沟通**: 遇到问题及时沟通
4. **代码审查**: 认真对待代码审查
5. **持续学习**: 分享和学习最佳实践

## 📖 参考文档

- [贡献指南](CONTRIBUTING.md)
- [开发工作流程](DEVELOPMENT_WORKFLOW.md)
- [华为文档](docs/HUAWEI_DOCS/README.md)

---

**祝团队协作愉快！** 🎉

