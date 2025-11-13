// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:harmony_flutter_demo/main.dart';

void main() {
  testWidgets('Main page displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the main page displays the welcome text.
    expect(find.text('欢迎使用鸿蒙 Flutter 应用'), findsOneWidget);
    expect(find.text('Harmony Flutter Demo'), findsOneWidget);
    expect(find.text('鸿蒙功能演示'), findsOneWidget);
    expect(find.text('点击上方按钮体验鸿蒙原生功能'), findsOneWidget);
  });

  testWidgets('Navigation button exists', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the navigation button.
    final button = find.text('鸿蒙功能演示');
    expect(button, findsOneWidget);
  });
}
