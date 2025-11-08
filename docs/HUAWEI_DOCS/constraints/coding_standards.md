# 华为鸿蒙开发编码规范

## 📋 概述

本文档定义华为鸿蒙开发的编码规范和约束规则。

## 🎯 通用规范

### 命名规范

#### 文件命名
- 使用小写字母和下划线
- 示例: `user_profile_page.dart`, `harmony_bridge_service.dart`

#### 类命名
- 使用大驼峰命名法（PascalCase）
- 示例: `UserProfilePage`, `HarmonyBridgeService`

#### 变量和函数命名
- 使用小驼峰命名法（camelCase）
- 示例: `userName`, `getUserInfo()`

#### 常量命名
- 使用全大写下划线分隔
- 示例: `MAX_RETRY_COUNT`, `API_BASE_URL`

### 代码组织

#### 导入顺序
1. Dart SDK 导入
2. Flutter 包导入
3. 第三方包导入
4. 项目内部导入

#### 文件结构
```dart
// 1. 导入
import 'package:flutter/material.dart';

// 2. 常量
const String API_BASE_URL = 'https://api.example.com';

// 3. 类定义
class MyWidget extends StatelessWidget {
  // ...
}
```

## 🔧 Flutter/Dart 规范

### 代码风格
- 遵循 Dart 官方风格指南
- 使用 `flutter format` 格式化
- 行长度限制: 80 字符（可适当放宽到 100）

### 注释规范
```dart
/// 获取用户信息
/// 
/// [userId] 用户 ID
/// 返回用户信息，如果用户不存在则返回 null
Future<User?> getUserInfo(String userId) async {
  // 实现
}
```

### 错误处理
```dart
try {
  // 操作
} on SpecificException catch (e) {
  // 处理特定异常
} catch (e) {
  // 处理其他异常
  logError(e);
}
```

## 🎨 鸿蒙 ArkTS 规范

### 类型注解
```typescript
// 总是使用类型注解
function getUserInfo(userId: string): Promise<User | null> {
  // 实现
}
```

### 命名规范
- 类: PascalCase
- 函数/变量: camelCase
- 常量: UPPER_SNAKE_CASE
- 接口: I 前缀或直接命名

### 错误处理
```typescript
try {
  // 操作
} catch (error) {
  hilog.error(0x0000, 'tag', 'Error: %{public}s', error.message);
  // 处理错误
}
```

## 📱 平台特定规范

### Platform Channel
- Channel 名称格式: `com.package.name/channel_name`
- 方法命名: 使用动词开头，如 `getUserInfo`, `showNotification`
- 参数验证: 在两端都进行参数验证

### 权限管理
- 明确声明所需权限
- 运行时检查权限
- 提供权限说明

### 资源管理
- 使用资源引用，不要硬编码
- 支持多语言
- 适配不同屏幕尺寸

## ⚠️ 约束规则

### 必须遵守
1. ✅ 所有公共 API 必须有文档注释
2. ✅ 所有异步操作必须有错误处理
3. ✅ 所有用户输入必须验证
4. ✅ 所有资源访问必须检查权限

### 禁止事项
1. ❌ 不要使用已废弃的 API
2. ❌ 不要硬编码敏感信息
3. ❌ 不要忽略错误处理
4. ❌ 不要使用不安全的类型转换

## 📝 代码审查检查点

- [ ] 代码遵循命名规范
- [ ] 有适当的注释
- [ ] 错误处理完整
- [ ] 性能考虑合理
- [ ] 安全性考虑
- [ ] 测试覆盖

---

**注意**: 此文档需要根据华为官方文档更新和完善。

