import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// 鸿蒙平台桥接服务
/// 用于 Flutter 与鸿蒙原生代码通信
class HarmonyBridge {
  static const MethodChannel _channel = MethodChannel('com.example.harmony_flutter_demo/harmony_bridge');

  /// 获取设备信息
  static Future<Map<String, dynamic>?> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod('getDeviceInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("获取设备信息失败: ${e.message}");
      }
      return null;
    }
  }

  /// 显示原生通知
  static Future<bool> showNotification(String title, String content) async {
    try {
      final result = await _channel.invokeMethod('showNotification', {
        'title': title,
        'content': content,
      });
      return result as bool;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("显示通知失败: ${e.message}");
      }
      return false;
    }
  }

  /// 请求权限
  static Future<bool> requestPermission(String permission) async {
    try {
      final result = await _channel.invokeMethod('requestPermission', {
        'permission': permission,
      });
      return result as bool;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("请求权限失败: ${e.message}");
      }
      return false;
    }
  }

  /// 调用鸿蒙分布式能力
  static Future<bool> callDistributedAbility(String action, Map<String, dynamic>? params) async {
    try {
      final result = await _channel.invokeMethod('callDistributedAbility', {
        'action': action,
        'params': params,
      });
      return result as bool;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("调用分布式能力失败: ${e.message}");
      }
      return false;
    }
  }
}

