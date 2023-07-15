// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:challenge/presentation/cards/cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('testing a responsive layout', () {
    testGoldens('testing a responsive layout for Login page', (tester) async {
      await tester.pumpWidgetBuilder(const CardsScreen());
      await multiScreenGolden(
        tester,
        'login_page',
        devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
          const Device(size: Size(1920, 1080), name: 'Web')
        ],
      );
    });
  });
}
