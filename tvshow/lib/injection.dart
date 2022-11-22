import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/data/datasource/remote/home_remote_DS.dart';
import 'package:tvshow/data/repositories/home_repositories_impl.dart';
import 'package:tvshow/domain/repositories/home_repositories.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

import 'presentation/cubit/cubit.dart';
import 'shared/shared.dart';

final locator = GetIt.instance;

void init() {
  // DIO INJECT
  locator.registerLazySingleton(() => ApiHelper(Dio(BaseOptions(
        baseUrl: ConstantApp.baseUrl,
      ))));

  // REMOTE DS
  locator
      .registerLazySingleton<HomeRemoteDS>(() => HomeRemoteDSImpl(locator()));

  // REPOSITORIES
  locator.registerLazySingleton<HomeRepositories>(
      () => HomeRepositoriesImpl(locator()));
  // USE CASE
  locator.registerLazySingleton(() => GetTrendingHomeCase(locator()));
  locator.registerLazySingleton(() => SearchMovie(locator()));

  // Cubit
  locator.registerFactory(() => StartedCubit());
  locator.registerFactory(() => HomeCubit(locator()));

  locator.registerFactory(() => TrendinghomeCubit(locator()));
}
