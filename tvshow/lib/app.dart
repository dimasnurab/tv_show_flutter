import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tvshow/config/config.dart';
import 'package:tvshow/shared/shared.dart';
import 'injection.dart' as di;
import 'presentation/cubit/cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TvShowApp extends StatelessWidget {
  const TvShowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return RefreshConfiguration(
      footerBuilder: () => ClassicFooter(
        idleText: '',
        canLoadingText: 'Sedang memuat',
        idleIcon: Text(''),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StartedCubit>(
            create: (context) => di.locator<StartedCubit>(),
          ),
        ],
        child: GetMaterialApp(
          title: ConstantApp.appName,
          debugShowCheckedModeBanner: false,
          getPages: RoutesApp.routes,
          initialRoute: RoutesApp.initial,
          locale: Locale("id", "ID"),
          supportedLocales: [Locale("id", "ID")],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            child = ResponsiveWrapper.builder(child,
                maxWidth: 1200,
                minWidth: 432,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: const Color(0xFFF5F5F5)));
            return child;
          },
        ),
      ),
    );
  }
}
