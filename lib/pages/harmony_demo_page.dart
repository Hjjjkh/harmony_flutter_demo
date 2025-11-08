import 'package:flutter/material.dart';
import '../services/harmony_bridge.dart';

/// 鸿蒙功能演示页面
class HarmonyDemoPage extends StatefulWidget {
  const HarmonyDemoPage({super.key});

  @override
  State<HarmonyDemoPage> createState() => _HarmonyDemoPageState();
}

class _HarmonyDemoPageState extends State<HarmonyDemoPage> {
  Map<String, dynamic>? _deviceInfo;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    setState(() {
      _isLoading = true;
    });

    final info = await HarmonyBridge.getDeviceInfo();
    
    setState(() {
      _deviceInfo = info;
      _isLoading = false;
    });
  }

  Future<void> _showNotification() async {
    final success = await HarmonyBridge.showNotification(
      'Flutter 通知',
      '这是一条来自 Flutter 的鸿蒙通知',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? '通知已发送' : '通知发送失败'),
        ),
      );
    }
  }

  Future<void> _requestPermission() async {
    final granted = await HarmonyBridge.requestPermission('ohos.permission.INTERNET');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(granted ? '权限已授予' : '权限被拒绝'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('鸿蒙功能演示'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 设备信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '设备信息',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (_deviceInfo != null)
                      ..._deviceInfo!.entries.map((entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(entry.value.toString()),
                              ],
                            ),
                          ))
                    else
                      const Text('无法获取设备信息'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 功能按钮
            ElevatedButton.icon(
              onPressed: _showNotification,
              icon: const Icon(Icons.notifications),
              label: const Text('显示通知'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _requestPermission,
              icon: const Icon(Icons.lock),
              label: const Text('请求权限'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loadDeviceInfo,
              icon: const Icon(Icons.refresh),
              label: const Text('刷新设备信息'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
              ),
            ),
            const SizedBox(height: 24),

            // 说明文本
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '使用说明',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. 这些功能需要通过 Platform Channel 与鸿蒙原生代码通信\n'
                      '2. 确保已正确配置鸿蒙平台和原生代码\n'
                      '3. 在真实鸿蒙设备上测试以获得最佳体验',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

