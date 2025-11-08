# GitHub 仓库使用指南

## 🎯 概述

本项目已配置为支持 GitHub 团队协作，并提供了华为官方文档和约束规则的管理机制。

## 📋 快速开始

### 1. 上传到 GitHub

```bash
# 初始化 Git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "feat: 初始提交"

# 添加远程仓库
git remote add origin https://github.com/your-username/harmony_flutter_demo.git

# 推送
git push -u origin main
```

详细步骤请参考：[GITHUB_UPLOAD_GUIDE.md](GITHUB_UPLOAD_GUIDE.md)

---

## 📚 华为文档管理

### 文档目录

```
docs/HUAWEI_DOCS/
├── README.md                    # 文档说明
├── HOW_TO_ADD_DOCS.md          # 如何添加文档
├── official/                    # 官方文档
├── constraints/                 # 约束规则 ✅
└── examples/                    # 示例代码
```

### 添加文档

#### 方式 1: 通过对话框（推荐）

直接在对话框中告诉 AI：

```
添加华为官方文档：[文档标题]
[文档内容或链接]
```

AI 会：
- 创建文档文件
- 组织文档结构
- 更新索引
- 格式化文档

#### 方式 2: 手动添加

1. 将文档添加到相应目录
2. 更新索引
3. 提交到 Git

详细说明请参考：[docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md](docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md)

---

## 🤝 团队协作

### 工作流程

1. **创建 Issue** - 描述问题或功能
2. **创建分支** - 从 `develop` 创建功能分支
3. **开发** - 编写代码
4. **提交 PR** - 创建 Pull Request
5. **代码审查** - 团队成员审查
6. **合并** - 审查通过后合并

详细说明请参考：
- [CONTRIBUTING.md](CONTRIBUTING.md) - 贡献指南
- [TEAM_COLLABORATION.md](TEAM_COLLABORATION.md) - 团队协作指南

---

## 🔧 已配置的功能

### GitHub 功能 ✅
- ✅ Issue 模板（Bug 报告、功能建议）
- ✅ Pull Request 模板
- ✅ CI 工作流（代码分析、测试、格式检查）
- ✅ 贡献指南
- ✅ 团队协作指南

### 文档管理 ✅
- ✅ 华为文档目录结构
- ✅ 约束规则文档模板
- ✅ 文档添加指南
- ✅ 文档索引

---

## 📝 下一步

1. **上传到 GitHub**
   - 参考 [GITHUB_UPLOAD_GUIDE.md](GITHUB_UPLOAD_GUIDE.md)

2. **添加华为文档**
   - 通过对话框告诉 AI 添加文档
   - 或参考 [docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md](docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md)

3. **开始协作**
   - 创建 Issue 跟踪任务
   - 使用 Pull Request 协作
   - 进行代码审查

---

## 🎯 AI 如何使用文档

AI 在编写代码时会：
1. ✅ 参考华为官方文档
2. ✅ 遵循约束规则
3. ✅ 应用最佳实践
4. ✅ 使用推荐的设计模式

您可以通过对话框添加更多文档，AI 会学习并应用！

---

**现在可以开始使用 GitHub 进行团队协作了！** 🚀

