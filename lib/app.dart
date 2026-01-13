import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sportify_app/features/splash/splash_injection.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/cubit/app_theme_cubit/app_theme_cubit.dart';
import 'config/themes/theme_injection.dart';
import 'core/utils/app_strings.dart';
import 'features/language/language_injection.dart';
import 'features/language/presentation/cubit/locale_cubit/locale_cubit.dart';

class SportifyApp extends StatelessWidget {
  const SportifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...languageBlocs,
        // ...splashBlocs,
        ...themeBlocs,
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        buildWhen: (previous, current) {
          return previous.isLight != current.isLight;
        },
        builder: (context, themeState) {
          final isLight = themeState.isLight;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: isLight
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFF161616),
              systemNavigationBarIconBrightness: isLight
                  ? Brightness.dark
                  : Brightness.light,
              statusBarColor: isLight
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFF161616),
              statusBarIconBrightness: isLight
                  ? Brightness.dark
                  : Brightness.light,
              statusBarBrightness: isLight
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );
          return BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previous, current) {
              return previous.locale.languageCode !=
                  current.locale.languageCode;
            },
            builder: (context, localeState) {
              log(
                'LocaleCubit state: ${localeState.locale.languageCode}',
              );
              return ScreenUtilInit(
                designSize: const Size(
                  AppStrings.screenWidth,
                  AppStrings.screenHeight,
                ),
                minTextAdapt: true,
                //splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp.router(
                    title: AppStrings.appName,
                    locale: localeState.locale,
                    debugShowCheckedModeBanner: false,
                    theme: getAppTheme(context, isLight),
                    darkTheme: getAppTheme(context, false),
                    themeMode: isLight
                        ? ThemeMode.light
                        : ThemeMode.dark,
                    routerConfig: AppRoutes.router,
                    supportedLocales: AppLocalizationsSetup
                        .supportedLocales,
                    localeResolutionCallback:
                        AppLocalizationsSetup
                            .localeResolutionCallback,
                    localizationsDelegates:
                        AppLocalizationsSetup
                            .localizationsDelegates,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
