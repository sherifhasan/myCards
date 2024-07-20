import 'package:challenge/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('testing a responsive layout', () {
    testGoldens('testing a responsive layout for Login page', (tester) async {
      await tester.pumpWidgetBuilder(const LoginScreen());
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
  }, skip: true);
}
