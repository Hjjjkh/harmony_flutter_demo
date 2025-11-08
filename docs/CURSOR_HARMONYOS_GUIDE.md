# 如何让 Cursor 精通鸿蒙开发？

> 原文作者：北极的树  
> 原文链接：https://mp.weixin.qq.com/s/gLgP7gGU0pmGc2x1hS-0UQ  
> 项目地址：https://github.com/skindhu/harmony-cursor-rules

## 📋 概述

近两年，华为在加速推广鸿蒙生态，越来越多的应用需要适配或者重新开发鸿蒙版。鸿蒙官方也顺势推出了 AI 开发助手 DevEco CodeGenie，希望能帮开发者提效。但由于 CodeGenie 目前还不太好用，无论是问答还是代码补全，都频繁出错。这对于用惯了 Cursor 的开发者来说，难以忍受。

那么，能直接使用 Cursor 来开发鸿蒙么？效果同样不理想。鸿蒙系统很新，主流 AI 大模型在训练时，相关的代码语料不足。这导致 Cursor 在生成鸿蒙代码时，表现也差强人意。

这篇文章，就来聊聊如何解决这个问题，让 Cursor 能为我们准确、高效地生成鸿蒙代码。

---

## 🎯 如何让 Cursor 精通鸿蒙开发？

想让 Cursor 成为鸿蒙开发专家，需要从三个方面入手：

1. **应用框架** - 官方文档
2. **语法规范** - ArkTS 约束规则
3. **最佳实践** - 开发规范

---

## 1. 喂给它"应用框架"官方文档

首先，要让 Cursor 了解鸿蒙的应用框架，比如 UI、网络、文件服务等。这样它才能在生成代码时，正确地引用各种库和组件。

可以看到，官方开发文档内容非常多，最适合使用 **RAG（检索增强）** 方案来解决。

幸运的是，我们不需要自己去搭建完整的 RAG 工作流，**Cursor 内置了第三方文档知识库功能**（必须是在线文档）。

### 配置步骤

1. 在 Cursor 的设置中，添加鸿蒙官方文档入口的 URL

   ```
   https://developer.harmonyos.com/cn/documentation/
   ```

2. **重要提示**：URL 后加上斜杠 `/`，Cursor 就会索引该网址下的所有子页面，学得更全面。

3. 自定义文档名称，例如：`ohos`

### 使用方法

添加完成后，在与 AI 对话时，使用 `@ohos`（你自定义的文档名）就能引用鸿蒙知识库，让它基于官方开发文档来回答问题或生成代码。

**示例**：
```
@ohos 如何创建一个新的 Ability？
```

---

## 2. 用 CursorRules 定义"ArkTS 语法规范"

鸿蒙使用 **ArkTS** 语言开发。它基于 TypeScript，但增加了许多严格的语法约束，来保证程序更健壮、性能更高。

如果直接让 Cursor 生成 ArkTS 代码，它经常会写出不符合约束规范的代码，我们还得手动修改。

因此，我们必须让 Cursor 牢记 ArkTS 相对于 TypeScript 的语法约束规则。

### 为什么不用文档知识库？

官方提供了一份详细的《从 TypeScript 到 ArkTS 的适配指南》。但这次，我们不能把它加到文档知识库里。原因有两点：

1. **难以召回**：知识库是根据你的问题，查找最相关的片段。但语法规则是一种普适约束，很难通过具体的需求"召回"。
2. **使用繁琐**：每次提问都要 `@Docs` 引用一下，太麻烦了。

### 解决方案：CursorRules

所以这种情况比较适合的方案是，将官方的这份手册抓取下来后，通过 AI 梳理成一份完整的语法约束规范，放在 **CursorRules** 中，这样每次生成代码时就能作为上下文强制 AI 遵守。

### 规则格式

我使用 Gemini 将官方文档总结成了 67 条规则，格式如下：

```json
[
  {
    "name": "arkts-no-aliases-by-index",
    "severity": "error",
    "description": "ArkTS不支持索引访问类型。",
    "suggestion": "请改用类型名称。"
  },
  {
    "name": "arkts-no-ambient-decls",
    "severity": "error",
    "description": "ArkTS不支持环境模块声明，因为它有自己的与JavaScript互操作的机制。",
    "suggestion": "请从原始模块中导入所需的内容。"
  },
  {
    "name": "arkts-no-any-unknown",
    "severity": "error",
    "description": "ArkTS不支持any和unknown类型。",
    "suggestion": "请显式指定类型。"
  },
  {
    "name": "arkts-no-as-const",
    "severity": "error",
    "description": "ArkTS不支持as const断言，因为在标准TypeScript中，as const用于使用相应的字面量类型标注字面量，而ArkTS不支持字面量类型。",
    "suggestion": "请避免使用as const断言。请改用字面量的显式类型标注。"
  }
  // ... 更多规则
]
```

### 规则应用

这些规则主要用于：
- TypeScript 到 ArkTS 的迁移
- HarmonyOS 应用开发
- 确保代码符合 ArkTS 规范

这样一来，Cursor 生成的每一行代码都会戴上"紧箍咒"，符合 ArkTS 的规范。

---

## 3. 将最佳实践也沉淀为 CursorRules

和语法规范一样，鸿蒙官方也提供了一系列最佳实践文档，指导我们写出更高质量的代码。

处理这些文档，我们沿用 CursorRules 的思路，但方法却需要升级。

### 问题：文档层级复杂

官方的最佳实践是分层级的，比如：
- "界面开发"下有"组件封装"
- 再往下还有"组件动态创建"

如果把所有规则都揉进一个全局的 CursorRules 文件，会导致上下文窗口过大，影响生成效果。

### 解决方案：分而治之

更好的方式是，**分而治之**：

1. **分层总结**：先用 AI 总结出每个"三级模块"（如组件动态创建）的最佳实践规则。
2. **向上聚合**：再让 AI 将多个三级模块的规则，精炼成所属"二级模块"（如组件封装与复用）的规则。

### 优势

这样做的好处是，我们可以将不同模块的规则，应用到工程项目的不同目录。比如：
- UI 相关的规则只在 `src/main/ets/ui` 目录下生效
- 互不干扰，也更节省上下文

### 自动化处理

手动处理这些文档既低效又易出错，一旦文档发生更新，又要重来一次。

为此，我开发了一个开源项目，实现了自动化处理：

- ✅ 自动爬取鸿蒙官方文档
- ✅ 调用 AI 总结 ArkTS 语法规范和各层级最佳实践
- ✅ 自动生成可以直接使用的 CursorRules 文件

**项目地址**：https://github.com/skindhu/harmony-cursor-rules

目前，项目已内置了"ArkTS 语法规范"和"界面开发最佳实践"的生成逻辑。

如果你需要其他模块的规则，只需在配置文件 `harmony_modules_config.json` 中添加相应模块信息，然后运行项目即可。

最终生成的规则文件都在 `final_cursor_rules` 文件夹里。你只需将内容复制到 Cursor Rules 中，并配置好应用范围，就能让 Cursor 真正懂鸿蒙，生成高质量代码。

---

## 📊 总结

通过 **"文档知识库 + 分层 CursorRules"** 这套组合拳，我们成功地让 Cursor 掌握了鸿蒙开发的方方面面，成为我们项目开发中的得力助手。

### 核心方法

1. **应用框架** → 使用 Cursor 文档知识库功能，添加鸿蒙官方文档 URL
2. **语法规范** → 使用 CursorRules，定义 ArkTS 语法约束规则
3. **最佳实践** → 使用分层 CursorRules，按模块组织最佳实践规则

### 适用场景

当然，这套方法论同样适用于其他任何新的、小众的或内部的开发框架。

---

## 🔗 相关资源

- [项目地址](https://github.com/skindhu/harmony-cursor-rules) - 自动化生成 CursorRules 的开源项目
- [HarmonyOS 官方文档](https://developer.harmonyos.com/cn/documentation/) - 鸿蒙开发文档
- [从 TypeScript 到 ArkTS 的适配指南](https://developer.huawei.com/consumer/en/doc/harmonyos-guides-V14/typescript-to-arkts-migration-guide-V14) - 官方语法规范

---

## 💡 在本项目中的应用

本项目已经配置了完整的文档结构和约束规则：

- 📁 `docs/HUAWEI_DOCS/` - 华为官方文档目录
- 📁 `docs/HUAWEI_DOCS/constraints/` - 约束规则目录
- 📁 `docs/HUAWEI_DOCS/official/` - 官方文档目录

你可以：
1. 在 Cursor 中配置文档知识库，指向 `docs/HUAWEI_DOCS/` 目录
2. 使用项目中的约束规则文件作为 CursorRules
3. 通过对话框添加更多文档和规则

详细说明请参考：[如何投喂文档](docs/HUAWEI_DOCS/HOW_TO_FEED_DOCS.md)

---

**希望这篇文章能给你带来启发！** 🚀

