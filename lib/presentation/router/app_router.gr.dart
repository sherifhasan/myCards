// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CardsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CardsScreen(),
      );
    },
    AddCardRoute.name: (routeData) {
      final args = routeData.argsAs<AddCardRouteArgs>(
          orElse: () => const AddCardRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddCardScreen(
          key: args.key,
          card: args.card,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [CardsScreen]
class CardsRoute extends PageRouteInfo<void> {
  const CardsRoute({List<PageRouteInfo>? children})
      : super(
          CardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddCardScreen]
class AddCardRoute extends PageRouteInfo<AddCardRouteArgs> {
  AddCardRoute({
    Key? key,
    CardModel? card,
    List<PageRouteInfo>? children,
  }) : super(
          AddCardRoute.name,
          args: AddCardRouteArgs(
            key: key,
            card: card,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardRoute';

  static const PageInfo<AddCardRouteArgs> page =
      PageInfo<AddCardRouteArgs>(name);
}

class AddCardRouteArgs {
  const AddCardRouteArgs({
    this.key,
    this.card,
  });

  final Key? key;

  final CardModel? card;

  @override
  String toString() {
    return 'AddCardRouteArgs{key: $key, card: $card}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
