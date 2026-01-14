import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:sportify_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:sportify_app/features/home/presentation/screens/home_screen.dart';
import 'package:sportify_app/features/auth/presentation/pages/login_view.dart';
import 'package:sportify_app/features/auth/presentation/pages/otp_view.dart';
import 'package:sportify_app/features/auth/presentation/pages/setup_profile_view.dart';
import 'package:sportify_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../core/utils/app_strings.dart';
import '../../injection_container.dart';
import 'navigator_observer.dart';

class Routes {
  static const String initialRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String homeScreenRoute = '/home';
  static const String loginRoute = '/login';
  static const String otpRoute = '/otp';
  static const String setupProfileRoute = '/setup-profile';
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
      GoRoute(
        path: Routes.onboardingRoute,
        name: 'onboarding',
        builder:
            (BuildContext context, GoRouterState state) {
              return const OnboardingScreen();
            },
      ),
      GoRoute(
        path: Routes.homeScreenRoute,
        name: 'home',
        builder:
            (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
      ),
      GoRoute(
        path: Routes.loginRoute,
        name: 'auth_login',
        builder:
            (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => AuthCubit(),
                child: const LoginView(),
              );
            },
      ),
      GoRoute(
        path: Routes.otpRoute,
        name: 'otp',
        builder:
            (BuildContext context, GoRouterState state) {
              final phoneNumber =
                  state.extra as String? ?? '';
              return BlocProvider(
                create: (context) =>
                    AuthCubit()..startOtpTimer(),
                child: OtpView(phoneNumber: phoneNumber),
              );
            },
      ),
      GoRoute(
        path: Routes.setupProfileRoute,
        name: 'setup_profile',
        builder:
            (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => AuthCubit(),
                child: const SetupProfileView(),
              );
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
