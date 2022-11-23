import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../presentation/cubit/cubit.dart';
import '../presentation/pages/pages.dart';

import '../injection.dart' as di;

class RoutesApp {
  static const String initial = '/';
  static const String detailTv = '/detailTv';
  static const String login = '/login';
  static const String validateToken = '/validateToken';

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => BlocBuilder<StartedCubit, StartedState>(
        builder: (context, state) {
          print("STATE $state");
          if (state is StartedHome) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => di.locator<TrendinghomeCubit>(),
                ),
                BlocProvider(
                  create: (context) => di.locator<HomeCubit>(),
                ),
                BlocProvider(
                  create: (context) => di.locator<TvpopularCubit>(),
                )
              ],
              child: HomePages(
                sessionID: state.sessionID,
              ),
            );
          } else {
            return SplashPages();
          }
        },
      ),
    ),
    GetPage(
      name: detailTv,
      page: () => BlocProvider(
        create: (context) => di.locator<DetailTvCubit>(),
        child: DetailTvPages(),
      ),
    ),
    GetPage(
      name: validateToken,
      page: () => ValidateTokenPages(),
    ),
    GetPage(
      name: login,
      page: () => BlocProvider(
        create: (context) => di.locator<LoginCubit>(),
        child: LoginPages(),
      ),
    )
  ];
}
