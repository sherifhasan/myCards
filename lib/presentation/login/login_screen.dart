import 'package:challenge/presentation/login/views/mobile/login_mobile_view.dart';
import 'package:challenge/presentation/login/views/web/login_web_view.dart';
import 'package:challenge/presentation/shared/responsive.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const LoginMobileView()
        : const LoginWebView();
  }
}
