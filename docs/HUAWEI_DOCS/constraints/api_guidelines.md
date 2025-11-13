# 华为鸿蒙 API 使用指南

## 📋 概述

本文档说明如何在项目中使用华为鸿蒙 API。

## 🔑 核心 API

### 权限 API
```typescript
// 请求权限
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';

const atManager = abilityAccessCtrl.createAtManager();
await atManager.requestPermissionsFromUser(context, ['ohos.permission.CAMERA']);
```

### 通知 API
```typescript
// 显示通知
import notificationManager from '@ohos.notificationManager';

const notificationRequest: notificationManager.NotificationRequest = {
  content: {
    contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
    normal: {
      title: '标题',
      text: '内容',
    },
  },
  id: Date.now(),
};

await notificationManager.publish(notificationRequest);
```

### 分布式能力
```typescript
// 分布式数据
import distributedData from '@ohos.data.distributedData';

const kvManager = distributedData.createKVManager(config);
const kvStore = await kvManager.getKVStore('myStore', options);
```

## 📱 Platform Channel 使用

### Flutter 端
```dart
static const MethodChannel _channel = MethodChannel('com.example.app/channel');

Future<void> callHarmonyAPI() async {
  try {
    final result = await _channel.invokeMethod('methodName', {'param': 'value'});
  } on PlatformException catch (e) {
    // 错误处理
  }
}
```

### 鸿蒙端
```typescript
import plugin from '@ohos.hilog';

export class MyPlugin {
  handleMethodCall(method: string, args: Object, callback: (result: Object) => void): void {
    switch (method) {
      case 'methodName':
        this.handleMethod(args, callback);
        break;
      default:
        callback({ error: 'Unknown method' });
    }
  }
}
```

## ⚠️ 使用约束

### 权限约束
- 必须在 `module.json5` 中声明权限
- 运行时检查权限状态
- 提供权限使用说明

### 性能约束
- 避免在主线程执行耗时操作
- 使用异步操作
- 合理使用缓存

### 安全约束
- 验证所有输入参数
- 不要暴露敏感信息
- 使用安全的存储方式

## 📚 参考文档

- [OpenHarmony API 参考](https://developer.harmonyos.com/cn/documentation/)
- [Platform Channel 文档](https://docs.flutter.dev/platform-integration/platform-channels)

---

**注意**: 此文档需要根据华为官方 API 文档更新。

