# GitHub 上传指南

## 🚀 快速上传到 GitHub

### 步骤 1: 创建 GitHub 仓库

1. 登录 GitHub
2. 点击右上角 "+" -> "New repository"
3. 填写信息：
   - **Repository name**: `harmony_flutter_demo`
   - **Description**: `华为鸿蒙 Flutter 开发演示项目`
   - **Visibility**: 选择 Public 或 Private
   - ⚠️ **不要**勾选 "Initialize this repository with a README"（项目已有 README）

4. 点击 "Create repository"

### 步骤 2: 连接并推送代码

在项目根目录执行以下命令：

```bash
# 1. 初始化 Git（如果还没有）
git init

# 2. 添加所有文件
git add .

# 3. 提交
git commit -m "feat: 初始提交 - 鸿蒙 Flutter 项目配置完成

- 完成项目结构配置
- 配置鸿蒙平台支持
- 添加开发工具和脚本
- 创建完整文档
- 配置 GitHub 协作功能"

# 4. 添加远程仓库（替换为您的仓库地址）
git remote add origin https://github.com/your-username/harmony_flutter_demo.git

# 5. 设置主分支
git branch -M main

# 6. 推送代码
git push -u origin main
```

### 步骤 3: 验证上传

1. 在 GitHub 上查看仓库
2. 确认所有文件都已上传
3. 检查文件结构是否正确

---

## 📋 已准备的文件

### GitHub 配置文件 ✅
- ✅ `.github/ISSUE_TEMPLATE/bug_report.md` - Bug 报告模板
- ✅ `.github/ISSUE_TEMPLATE/feature_request.md` - 功能建议模板
- ✅ `.github/pull_request_template.md` - PR 模板
- ✅ `.github/workflows/ci.yml` - CI 工作流

### 团队协作文档 ✅
- ✅ `CONTRIBUTING.md` - 贡献指南
- ✅ `TEAM_COLLABORATION.md` - 团队协作指南
- ✅ `GITHUB_SETUP.md` - GitHub 设置指南

### 华为文档目录 ✅
- ✅ `docs/HUAWEI_DOCS/README.md` - 文档说明
- ✅ `docs/HUAWEI_DOCS/HOW_TO_ADD_DOCS.md` - 如何添加文档
- ✅ `docs/HUAWEI_DOCS/constraints/` - 约束规则目录
  - `coding_standards.md` - 编码规范
  - `api_guidelines.md` - API 指南
  - `design_patterns.md` - 设计模式
  - `best_practices.md` - 最佳实践

---

## 📚 如何添加华为官方文档

### 方式 1: 通过对话框（推荐）

直接在对话框中告诉 AI：

```
添加华为官方文档：[文档标题]
[文档内容或链接]
```

AI 会：
1. 创建相应的文档文件
2. 组织文档结构
3. 更新索引
4. 格式化文档

### 方式 2: 手动添加

1. 将文档文件复制到 `docs/HUAWEI_DOCS/` 相应目录
2. 更新 `docs/HUAWEI_DOCS/README.md` 索引
3. 提交到 Git：
   ```bash
   git add docs/HUAWEI_DOCS/
   git commit -m "docs: 添加华为官方文档"
   git push
   ```

### 方式 3: 添加文档链接

如果文档是外部链接，创建引用文件：

```markdown
# 文档标题

**来源**: 华为官方文档
**链接**: https://developer.harmonyos.com/...
**版本**: v4.0
**更新日期**: 2025-11-08

## 内容摘要
[摘要]

## 关键要点
- 要点 1
- 要点 2
```

---

## 🎯 文档目录结构

```
docs/HUAWEI_DOCS/
├── README.md                    # 文档说明
├── HOW_TO_ADD_DOCS.md          # 如何添加文档
├── official/                    # 官方文档
│   ├── harmonyos/              # HarmonyOS 文档
│   ├── deveco/                 # DevEco Studio 文档
│   └── flutter/                # Flutter 文档
├── constraints/                 # 约束规则
│   ├── coding_standards.md     # 编码规范 ✅
│   ├── api_guidelines.md       # API 指南 ✅
│   ├── design_patterns.md      # 设计模式 ✅
│   └── best_practices.md       # 最佳实践 ✅
└── examples/                    # 示例代码
    ├── platform_channel/       # Platform Channel 示例
    └── native_features/         # 原生功能示例
```

---

## ✅ 上传前检查清单

- [ ] 所有文件已添加到 Git
- [ ] `.gitignore` 配置正确
- [ ] 敏感信息已移除（API 密钥、密码等）
- [ ] 文档已更新
- [ ] 代码已格式化
- [ ] 测试通过

---

## 🔒 安全提示

### 不要上传的文件
- ❌ `.env` 文件（包含敏感信息）
- ❌ API 密钥和密码
- ❌ 本地配置文件（`local.properties`）
- ❌ 构建产物（`.apk`, `.har` 等）
- ❌ IDE 配置文件（`.idea/`, `.vscode/` 已配置忽略）

### 已配置忽略
`.gitignore` 已配置忽略：
- ✅ 构建文件
- ✅ IDE 配置
- ✅ 环境变量文件
- ✅ 日志文件
- ✅ 临时文件

---

## 📝 后续维护

### 更新代码
```bash
git add .
git commit -m "feat: 添加新功能"
git push
```

### 添加文档
```bash
# 通过对话框告诉 AI 添加文档，或手动添加后：
git add docs/HUAWEI_DOCS/
git commit -m "docs: 添加华为官方文档"
git push
```

### 团队协作
- 使用 Pull Request 进行代码审查
- 使用 Issues 跟踪任务
- 遵循贡献指南

---

## 🎉 完成

上传完成后，您可以：
1. ✅ 在 GitHub 上查看代码
2. ✅ 与团队协作开发
3. ✅ 通过对话框添加华为文档
4. ✅ 使用 AI 编写代码

---

**现在可以开始上传了！** 🚀

