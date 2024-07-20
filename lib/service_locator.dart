import 'package:challenge/infrastructure/cards/card_repository_imp.dart';
import 'package:challenge/infrastructure/cards/datasource/local_data_source.dart';
import 'package:challenge/infrastructure/login/datasource/remote_data_source_impl.dart';
import 'package:challenge/infrastructure/login/login_repository_imp.dart';
import 'package:challenge/presentation/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/features/cards/card_cubit.dart';
import 'application/features/login/login_cubit.dart';
import 'domain/cards/card_repository.dart';
import 'domain/login/login_repository.dart';
import 'infrastructure/cards/datasource/local_data_source_impl.dart';
import 'infrastructure/login/datasource/remote_data_source.dart';

final injection = GetIt.instance;

Future<void> setup() async {
  await setupSharedPreferences();
  setupLocators();
}

Future<void> setupSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  // Register SharedPreferences
  injection.registerLazySingleton<SharedPreferences>(() => prefs);
}

void setupLocators() {
  // Register AppRouter
  injection.registerLazySingleton<AppRouter>(() => AppRouter());

  // Register RemoteDataSource
  injection
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

  // Register LocalDataSource
  injection.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(injection<SharedPreferences>()));

  // Register Login Repository
  injection.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injection<RemoteDataSource>()));

  // Register Card Repository
  injection.registerLazySingleton<CardRepository>(
      () => CardRepositoryImpl(injection<LocalDataSource>()));

  // Register LoginCubit
  injection.registerFactory<LoginCubit>(
      () => LoginCubit(injection<LoginRepository>()));

  // Register CardCubit
  injection
      .registerFactory<CardCubit>(() => CardCubit(injection<CardRepository>()));
}
