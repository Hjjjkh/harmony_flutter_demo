# GitHub 仓库设置指南

## 🚀 快速开始

### 1. 创建 GitHub 仓库

1. 登录 GitHub
2. 点击 "New repository"
3. 填写仓库信息：
   - Repository name: `harmony_flutter_demo`
   - Description: `华为鸿蒙 Flutter 开发演示项目`
   - Visibility: 选择 Public 或 Private
   - **不要** 初始化 README（项目已有）

### 2. 连接本地仓库

```bash
# 在项目根目录执行
git init
git add .
git commit -m "feat: 初始提交 - 鸿蒙 Flutter 项目配置完成"

# 添加远程仓库（替换为您的仓库地址）
git remote add origin https://github.com/your-username/harmony_flutter_demo.git

# 推送代码
git branch -M main
git push -u origin main
```

### 3. 配置分支保护

在 GitHub 仓库设置中：
1. 进入 `Settings` -> `Branches`
2. 添加分支保护规则
3. 保护 `main` 分支：
   - ✅ Require pull request reviews
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date

## 📋 已配置的文件

### GitHub 配置文件 ✅

- ✅ `.github/ISSUE_TEMPLATE/bug_report.md` - Bug 报告模板
- ✅ `.github/ISSUE_TEMPLATE/feature_request.md` - 功能建议模板
- ✅ `.github/pull_request_template.md` - PR 模板
- ✅ `.github/workflows/ci.yml` - CI 工作流

### 团队协作文件 ✅

- ✅ `CONTRIBUTING.md` - 贡献指南
- ✅ `TEAM_COLLABORATION.md` - 团队协作指南
- ✅ `.gitignore` - Git 忽略文件
- ✅ `.gitattributes` - Git 属性配置

### 文档目录 ✅

- ✅ `docs/HUAWEI_DOCS/` - 华为文档目录
  - `README.md` - 文档说明
  - `HOW_TO_ADD_DOCS.md` - 如何添加文档
  - `constraints/` - 约束规则目录
  - `official/` - 官方文档目录
  - `examples/` - 示例代码目录

## 🔧 仓库设置

### 1. 基本设置

- **Description**: 华为鸿蒙 Flutter 开发演示项目
- **Topics**: `flutter`, `harmonyos`, `dart`, `mobile-development`
- **Website**: （可选）项目网站
- **License**: 选择合适的许可证

### 2. 功能设置

- ✅ Issues - 启用
- ✅ Projects - 启用（可选）
- ✅ Wiki - 禁用（使用文档目录）
- ✅ Discussions - 启用（可选）

### 3. 安全设置

- ✅ Dependency graph - 启用
- ✅ Dependabot alerts - 启用
- ✅ Secret scanning - 启用

## 📚 文档管理

### 添加华为官方文档

#### 方式 1: 通过对话框（推荐）

直接在对话框中告诉 AI：
```
添加华为官方文档：[文档标题]
[文档内容或链接]
```

#### 方式 2: 手动添加

1. 将文档添加到 `docs/HUAWEI_DOCS/` 相应目录
2. 更新 `docs/HUAWEI_DOCS/README.md` 索引
3. 提交到 Git

### 文档结构

```
docs/HUAWEI_DOCS/
├── README.md                    # 文档说明
├── HOW_TO_ADD_DOCS.md          # 如何添加文档
├── official/                    # 官方文档
│   ├── harmonyos/              # HarmonyOS 文档
│   ├── deveco/                  # DevEco Studio 文档
│   └── flutter/                 # Flutter 文档
├── constraints/                 # 约束规则
│   ├── coding_standards.md     # 编码规范
│   ├── api_guidelines.md        # API 指南
│   ├── design_patterns.md       # 设计模式
│   └── best_practices.md        # 最佳实践
└── examples/                    # 示例代码
    ├── platform_channel/       # Platform Channel 示例
    └── native_features/         # 原生功能示例
```

## 🤝 团队协作

### 工作流程

1. **创建 Issue** - 描述问题或功能
2. **创建分支** - 从 `develop` 或 `main` 创建
3. **开发** - 编写代码和测试
4. **提交 PR** - 创建 Pull Request
5. **代码审查** - 团队成员审查
6. **合并** - 审查通过后合并

### 分支策略

- `main` - 生产环境代码
- `develop` - 开发环境代码
- `feature/*` - 功能分支
- `bugfix/*` - Bug 修复分支
- `hotfix/*` - 紧急修复分支

## 🔄 CI/CD

### GitHub Actions

已配置 CI 工作流（`.github/workflows/ci.yml`）：
- ✅ 代码分析 (`flutter analyze`)
- ✅ 运行测试 (`flutter test`)
- ✅ 检查格式 (`flutter format`)

### 触发条件

- Push 到 `main` 或 `develop` 分支
- 创建 Pull Request

## 📝 提交规范

使用约定式提交格式：

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

## ✅ 检查清单

### 首次设置
- [ ] 创建 GitHub 仓库
- [ ] 连接本地仓库
- [ ] 推送代码
- [ ] 配置分支保护
- [ ] 设置仓库描述和 Topics
- [ ] 配置 CI/CD

### 团队协作
- [ ] 添加团队成员
- [ ] 设置权限
- [ ] 创建团队文档
- [ ] 配置代码审查规则

### 文档管理
- [ ] 创建文档目录结构
- [ ] 添加初始文档
- [ ] 更新文档索引
- [ ] 设置文档更新流程

## 🎯 下一步

1. **创建仓库并推送代码**
   ```bash
   git remote add origin https://github.com/your-username/harmony_flutter_demo.git
   git push -u origin main
   ```

2. **配置仓库设置**
   - 设置描述和 Topics
   - 配置分支保护
   - 启用必要的功能

3. **添加团队文档**
   - 通过对话框告诉 AI 添加华为官方文档
   - 或手动添加文档到 `docs/HUAWEI_DOCS/`

4. **开始协作**
   - 创建 Issue 跟踪任务
   - 使用 Pull Request 协作
   - 进行代码审查

---

## 📚 参考文档

- [贡献指南](CONTRIBUTING.md)
- [团队协作指南](TEAM_COLLABORATION.md)
- [开发工作流程](DEVELOPMENT_WORKFLOW.md)
- [华为文档说明](docs/HUAWEI_DOCS/README.md)

---

**现在可以开始使用 GitHub 进行团队协作了！** 🚀

