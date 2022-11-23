import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/data/datasource/remote/auth_remote_DS.dart';
import 'package:tvshow/data/datasource/remote/home_remote_DS.dart';
import 'package:tvshow/data/repositories/auth_repositories_impl.dart';
import 'package:tvshow/data/repositories/home_repositories_impl.dart';
import 'package:tvshow/domain/repositories/auth_repositories.dart';
import 'package:tvshow/domain/repositories/home_repositories.dart';
import 'package:tvshow/domain/usecase/auth_usecase.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

import 'data/datasource/local/auth_pref_DS.dart';
import 'presentation/cubit/cubit.dart';
import 'shared/shared.dart';

final locator = GetIt.instance;

void init(SharedPreferences preferences) {
  // DIO INJECT
  locator.registerLazySingleton(() => ApiHelper(Dio(BaseOptions(
        baseUrl: ConstantApp.baseUrl,
      ))));

  // LocalDS
  locator.registerLazySingleton<AuthPreferencseDS>(
      () => AuthPreferencesDSImpl(preferences));
  // REMOTE DS
  locator.registerLazySingleton<HomeRemoteDS>(
      () => HomeRemoteDSImpl(locator(), locator()));
  locator.registerLazySingleton<AuthRemoteDS>(
      () => AuthRemoteDSImpl(locator(), locator()));

  // REPOSITORIES
  locator.registerLazySingleton<HomeRepositories>(
      () => HomeRepositoriesImpl(locator()));
  locator.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImpl(locator(), locator()));
  // USE CASE
  locator.registerLazySingleton(() => GetTrendingHomeCase(locator()));
  locator.registerLazySingleton(() => SearchMovie(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => RequestToken(locator()));
  locator.registerLazySingleton(() => CreateSessionID(locator()));
  locator.registerLazySingleton(() => SetsessionID(locator()));
  locator.registerLazySingleton(() => GetSessionID(locator()));
  locator.registerLazySingleton(() => AddWatchList(locator()));
  locator.registerLazySingleton(() => DeleteSession(locator()));

  // Cubit
  locator.registerFactory(() => StartedCubit(locator()));
  locator.registerFactory(() => HomeCubit(locator(), locator()));
  locator.registerFactory(() => TvpopularCubit(locator()));
  locator.registerFactory(() => DetailTvCubit(locator()));
  locator.registerFactory(() => LoginCubit(locator(), locator(), locator()));

  locator.registerFactory(() => TrendinghomeCubit(locator(), locator()));
}
