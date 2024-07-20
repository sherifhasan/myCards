import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  // This isMobile, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1100;

  static bool isWeb(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
