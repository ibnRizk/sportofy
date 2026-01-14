import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/features/splash/presentation/screens/splash_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../injection_container.dart';
import 'navigator_observer.dart';

class Routes {
  static const String initialRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String homeScreenRoute = '/home';
  static const String loginScreenRoute = '/login';
  static const String loginWithEmailScreenRoute =
      '/login-with-email';
  static const String forgetPasswordScreenRoute =
      '/forget-password';
  static const String registerScreenRoute = '/register';
  static const String resetPasswordScreenRoute =
      '/reset-password';
  static const String plansScreenRoute = '/plans';
}

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.initialRoute,
    observers: [AppNavigatorObserver()],
    routes: [
      GoRoute(
        path: Routes.initialRoute,
        name: 'splash',
        builder:
            (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(AppStrings.noRouteFound)),
    ),
  );

  static String get currentRoute => routesStack.isNotEmpty
      ? routesStack.last
      : Routes.initialRoute;

  static void pushRouteToRoutesStack(String route) {
    routesStack.add(route);
    ServiceLocator.injectRoutesStackSingleton(routesStack);
  }

  static void popRouteFromRoutesStack() {
    if (routesStack.isNotEmpty) {
      routesStack.removeLast();
      ServiceLocator.injectRoutesStackSingleton(
        routesStack,
      );
    }
  }
}
