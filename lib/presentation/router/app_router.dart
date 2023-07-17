import 'package:auto_route/auto_route.dart';
import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:challenge/presentation/cards/add_card_screen.dart';
import 'package:challenge/presentation/cards/cards_screen.dart';
import 'package:challenge/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: CardsRoute.page),
        AutoRoute(page: AddCardRoute.page),
      ];
}
