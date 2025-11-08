# 如何投喂文档给 AI

## 📚 概述

本文档说明如何将华为官方文档和开发规范添加到项目中，让 AI 在编写代码时能够参考这些文档。

---

## 🎯 投喂文档的方式

### 方式 1: 通过对话框直接添加（最简单）⭐

直接在对话框中告诉 AI：

```
添加华为官方文档：[文档标题]
[文档内容或链接]
```

**示例 1: 添加文档内容**
```
添加华为官方文档：HarmonyOS 应用开发指南

## HarmonyOS 应用开发指南

### 1. 应用架构
HarmonyOS 应用采用分层架构...

### 2. 开发流程
1. 创建项目
2. 配置开发环境
3. 编写代码
...
```

**示例 2: 添加文档链接**
```
添加华为官方文档：HarmonyOS API 参考
链接：https://developer.harmonyos.com/cn/documentation/
内容摘要：HarmonyOS 官方 API 参考文档，包含所有系统 API 的使用说明
```

**示例 3: 添加约束规则**
```
添加华为开发约束：编码规范
- 使用驼峰命名法
- 类名使用大驼峰
- 变量名使用小驼峰
- 常量使用全大写下划线分隔
```

AI 会：
1. ✅ 自动创建相应的文档文件
2. ✅ 组织文档结构
3. ✅ 更新文档索引
4. ✅ 格式化文档
5. ✅ 提交到 Git（如果需要）

---

### 方式 2: 手动添加文件

#### 步骤 1: 准备文档

将文档内容保存为 Markdown 文件（`.md`），使用 UTF-8 编码。

#### 步骤 2: 选择存放位置

根据文档类型选择目录：

- **官方文档** → `docs/HUAWEI_DOCS/official/`
  - HarmonyOS 文档 → `docs/HUAWEI_DOCS/official/harmonyos/`
  - DevEco Studio 文档 → `docs/HUAWEI_DOCS/official/deveco/`
  - Flutter 文档 → `docs/HUAWEI_DOCS/official/flutter/`

- **约束规则** → `docs/HUAWEI_DOCS/constraints/`
  - 编码规范 → `docs/HUAWEI_DOCS/constraints/coding_standards.md`
  - API 指南 → `docs/HUAWEI_DOCS/constraints/api_guidelines.md`
  - 设计模式 → `docs/HUAWEI_DOCS/constraints/design_patterns.md`
  - 最佳实践 → `docs/HUAWEI_DOCS/constraints/best_practices.md`

- **示例代码** → `docs/HUAWEI_DOCS/examples/`
  - Platform Channel 示例 → `docs/HUAWEI_DOCS/examples/platform_channel/`
  - 原生功能示例 → `docs/HUAWEI_DOCS/examples/native_features/`

#### 步骤 3: 创建文档文件

```bash
# 示例：添加 HarmonyOS 开发指南
docs/HUAWEI_DOCS/official/harmonyos/development_guide.md
```

#### 步骤 4: 更新索引

编辑 `docs/HUAWEI_DOCS/README.md`，添加文档索引：

```markdown
### 官方文档
- [HarmonyOS 开发指南](official/harmonyos/development_guide.md) - 开发指南
```

#### 步骤 5: 提交到 Git

```bash
git add docs/HUAWEI_DOCS/
git commit -F commit_msg.txt  # 使用文件方式避免编码问题
git push
```

---

### 方式 3: 批量添加文档

如果有多个文档，可以：

1. **创建文档列表文件**
   ```
   docs_list.txt
   ```

2. **在对话框中告诉 AI**
   ```
   批量添加华为文档，文档列表：
   [文档1标题]
   [文档1内容]
   
   [文档2标题]
   [文档2内容]
   ...
   ```

3. **AI 会自动处理**
   - 创建所有文档文件
   - 组织文档结构
   - 更新索引

---

## 📋 文档格式要求

### Markdown 格式

使用标准的 Markdown 语法：

```markdown
# 文档标题

## 章节标题

### 小节标题

正文内容...

- 列表项 1
- 列表项 2

**重要提示**：...

代码示例：
```dart
// Flutter 代码
class Example {
  // ...
}
```

```typescript
// ArkTS 代码
class Example {
  // ...
}
```
```

### 文档结构

建议的文档结构：

```markdown
# 文档标题

## 概述
文档简介和目的

## 主要内容
详细内容...

## 示例
代码示例...

## 参考链接
相关文档链接

## 更新记录
- 2025-11-08: 初始版本
```

---

## 🎯 文档类型

### 1. 官方文档

**存放位置**: `docs/HUAWEI_DOCS/official/`

**内容类型**:
- HarmonyOS 开发文档
- DevEco Studio 使用指南
- API 参考文档
- 设计指南
- 最佳实践

**示例**:
```
docs/HUAWEI_DOCS/official/harmonyos/
├── getting_started.md          # 快速开始
├── api_reference.md            # API 参考
├── design_guide.md             # 设计指南
└── best_practices.md           # 最佳实践
```

### 2. 约束规则

**存放位置**: `docs/HUAWEI_DOCS/constraints/`

**内容类型**:
- 编码规范
- API 使用约束
- 性能要求
- 安全规范

**已创建的文档**:
- ✅ `coding_standards.md` - 编码规范
- ✅ `api_guidelines.md` - API 使用指南
- ✅ `design_patterns.md` - 设计模式
- ✅ `best_practices.md` - 最佳实践

### 3. 示例代码

**存放位置**: `docs/HUAWEI_DOCS/examples/`

**内容类型**:
- Platform Channel 示例
- 原生功能示例
- 架构示例

---

## 💡 实际示例

### 示例 1: 添加 HarmonyOS 开发指南

**在对话框中**:
```
添加华为官方文档：HarmonyOS 应用开发指南

## HarmonyOS 应用开发指南

### 1. 应用架构
HarmonyOS 应用采用分层架构：
- UI 层：使用 ArkUI 框架
- 业务逻辑层：使用 TypeScript/ArkTS
- 数据层：使用分布式数据管理

### 2. 开发流程
1. 创建项目
2. 配置开发环境
3. 编写代码
4. 调试测试
5. 打包发布

### 3. 关键概念
- Ability：应用的基本组成单元
- Page：页面组件
- Component：UI 组件
```

### 示例 2: 添加 API 使用约束

**在对话框中**:
```
更新华为开发约束：API 使用规范

## API 使用规范

### 权限管理
- 所有需要权限的 API 必须在 module.json5 中声明
- 运行时检查权限状态
- 提供权限使用说明

### 异步操作
- 使用 async/await 处理异步操作
- 必须处理错误情况
- 避免阻塞主线程

### 资源管理
- 及时释放资源
- 使用 try-finally 确保资源释放
- 避免内存泄漏
```

### 示例 3: 添加示例代码

**在对话框中**:
```
添加华为开发示例：相机功能调用

## 相机功能调用示例

### Flutter 端
```dart
Future<void> takePicture() async {
  final result = await HarmonyBridge.callMethod('takePicture');
  // 处理结果
}
```

### 鸿蒙端
```typescript
case 'takePicture':
  // 调用相机 API
  break;
```
```

---

## 🔄 更新现有文档

### 更新约束规则

**在对话框中**:
```
更新华为开发约束：[约束名称]
[新的约束内容]
```

**示例**:
```
更新华为开发约束：编码规范
添加新的命名规范：
- 文件名使用小写下划线
- 类名使用大驼峰
- 函数名使用小驼峰
- 常量使用全大写下划线
```

### 更新官方文档

**在对话框中**:
```
更新华为官方文档：[文档标题]
[更新的内容]
```

---

## ✅ 检查清单

添加文档后，确认：

- [ ] 文档文件已创建
- [ ] 文档内容完整
- [ ] 文档索引已更新
- [ ] 文档格式正确
- [ ] 已提交到 Git（如果手动添加）

---

## 📚 参考

- [文档说明](README.md) - 文档目录说明
- [如何添加文档](HOW_TO_ADD_DOCS.md) - 详细添加方法

---

## 🚀 快速开始

**现在就试试！在对话框中输入：**

```
添加华为官方文档：HarmonyOS 快速开始指南

## HarmonyOS 快速开始

### 环境要求
- DevEco Studio 4.0+
- HarmonyOS SDK
- Node.js 16.0+

### 创建项目
1. 打开 DevEco Studio
2. 创建新项目
3. 选择模板
4. 配置项目信息
```

**AI 会立即处理并创建文档！** 🎉

---

**提示**: 最简单的方式就是直接在对话框中告诉 AI 添加文档，AI 会自动处理所有细节！

