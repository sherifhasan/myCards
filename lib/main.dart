import 'package:challenge/application/features/cards/card_cubit.dart';
import 'package:challenge/application/features/login/login_cubit.dart';
import 'package:challenge/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injection<CardCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter coding challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        routerConfig: injection<AppRouter>().config(),
      ),
    );
  }
}
