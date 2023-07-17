import 'package:auto_route/auto_route.dart';
import 'package:challenge/presentation/cards/views/mobile/cards_mobile_view.dart';
import 'package:challenge/presentation/cards/views/web/cards_web_view.dart';
import 'package:challenge/presentation/shared/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const CardsMobileView()
        : const CardsWebView();
  }
}
