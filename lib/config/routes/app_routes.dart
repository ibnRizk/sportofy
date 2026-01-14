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
import 'package:sportify_app/features/activity/presentation/views/my_activity_view.dart';
import 'package:sportify_app/features/profile/presentation/pages/profile_view.dart';
import 'package:sportify_app/features/profile/presentation/pages/my_team_view.dart';
import 'package:sportify_app/features/profile/presentation/pages/edit_profile_view.dart';
import 'package:sportify_app/features/community/presentation/pages/friends_view.dart';
import 'package:sportify_app/features/points/presentation/views/points_view.dart';
import 'package:sportify_app/features/wallet/presentation/views/wallet_view.dart';
import 'package:sportify_app/features/orders/presentation/views/my_orders_view.dart';
import 'package:sportify_app/features/orders/presentation/views/order_details_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/my_tournaments_view.dart';

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
  static const String profileRoute = '/profile';
  static const String friendsRoute = '/friends';
  static const String myTeamRoute = '/my-team';
  static const String editProfileRoute = '/edit-profile';
  static const String myActivityRoute = '/my-activity';
  static const String pointsRoute = '/points';
  static const String walletRoute = '/wallet';
  static const String myOrdersRoute = '/my-orders';
  static const String orderDetailsRoute = '/order-details';
  static const String tournamentsRoute = '/tournaments';
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
      GoRoute(
        path: Routes.profileRoute,
        name: 'profile',
        builder:
            (BuildContext context, GoRouterState state) {
              return const ProfileView();
            },
      ),
      GoRoute(
        path: Routes.friendsRoute,
        name: 'friends',
        builder:
            (BuildContext context, GoRouterState state) {
              return const FriendsView();
            },
      ),
      GoRoute(
        path: Routes.myTeamRoute,
        name: 'myTeam',
        builder:
            (BuildContext context, GoRouterState state) {
              return const MyTeamView();
            },
      ),
      GoRoute(
        path: Routes.editProfileRoute,
        name: 'editProfile',
        builder:
            (BuildContext context, GoRouterState state) {
              return const EditProfileView();
            },
      ),
      GoRoute(
        path: Routes.myActivityRoute,
        name: 'myActivity',
        builder:
            (BuildContext context, GoRouterState state) {
              return const MyActivityView();
            },
      ),
      GoRoute(
        path: Routes.pointsRoute,
        name: 'points',
        builder:
            (BuildContext context, GoRouterState state) {
              return const PointsView();
            },
      ),
      GoRoute(
        path: Routes.walletRoute,
        name: 'wallet',
        builder:
            (BuildContext context, GoRouterState state) {
              return const WalletView();
            },
      ),
      GoRoute(
        path: Routes.myOrdersRoute,
        name: 'myOrders',
        builder:
            (BuildContext context, GoRouterState state) {
              return const MyOrdersView();
            },
      ),
      GoRoute(
        path: Routes.orderDetailsRoute,
        name: 'orderDetails',
        builder:
            (BuildContext context, GoRouterState state) {
              return const OrderDetailsView();
            },
      ),
      GoRoute(
        path: Routes.tournamentsRoute,
        name: 'tournaments',
        builder:
            (BuildContext context, GoRouterState state) {
              return const MyTournamentsView();
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
