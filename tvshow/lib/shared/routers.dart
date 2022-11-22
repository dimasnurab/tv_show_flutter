import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../presentation/cubit/cubit.dart';
import '../presentation/pages/pages.dart';

import '../injection.dart' as di;

class RoutesApp {
  static const String initial = '/';

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
                      )
                    ],
                    child: HomePages(),
                  );
                } else {
                  return SplashPages();
                }
              },
            ))
  ];
}
