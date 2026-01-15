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
import 'package:sportify_app/features/tournaments/presentation/views/tournaments_list_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/match_details_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/tournament_details_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/joined_teams_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/round_of_32_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/round_of_16_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/round_of_8_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/semi_final_view.dart';
import 'package:sportify_app/features/tournaments/presentation/views/final_view.dart';
import 'package:sportify_app/features/payment/presentation/pages/payment_test_page.dart';
import 'package:sportify_app/features/stadiums/presentation/views/stadium_details_view.dart';
import 'package:sportify_app/features/booking/presentation/views/appointment_view.dart';
import 'package:sportify_app/features/booking/presentation/views/reservation_view.dart';

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
  static const String tournamentsListRoute =
      '/tournaments-list';
  static const String matchDetailsRoute = '/match-details';
  static const String paymentTestRoute = '/payment-test';
  static const String tournamentDetailsRoute =
      '/tournament-details';
  static const String joinedTeamsRoute = '/joined-teams';
  static const String roundOf32Route = '/round-of-32';
  static const String roundOf16Route = '/round-of-16';
  static const String roundOf8Route = '/round-of-8';
  static const String semiFinalRoute = '/semi-final';
  static const String finalRoute = '/final';
  static const String stadiumDetailsRoute =
      '/stadium-details';
  static const String appointmentRoute = '/appointment';
  static const String reservationRoute = '/reservation';
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
        path: Routes.stadiumDetailsRoute,
        name: 'stadiumDetails',
        builder:
            (BuildContext context, GoRouterState state) {
              return const StadiumDetailsView();
            },
      ),
      GoRoute(
        path: Routes.appointmentRoute,
        name: 'appointment',
        builder:
            (BuildContext context, GoRouterState state) {
              return const AppointmentView();
            },
      ),
      GoRoute(
        path: Routes.reservationRoute,
        name: 'reservation',
        builder:
            (BuildContext context, GoRouterState state) {
              return const ReservationView();
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
      GoRoute(
        path: Routes.tournamentsListRoute,
        name: 'tournamentsList',
        builder:
            (BuildContext context, GoRouterState state) {
              return const TournamentsListView();
            },
      ),
      GoRoute(
        path: Routes.matchDetailsRoute,
        name: 'matchDetails',
        builder:
            (BuildContext context, GoRouterState state) {
              return const MatchDetailsView();
            },
      ),
      GoRoute(
        path: Routes.tournamentDetailsRoute,
        name: 'tournamentDetails',
        builder:
            (BuildContext context, GoRouterState state) {
              return const TournamentDetailsView();
            },
      ),
      GoRoute(
        path: Routes.paymentTestRoute,
        name: 'paymentTest',
        builder:
            (BuildContext context, GoRouterState state) {
              return const PaymentTestPage();
            },
      ),
      GoRoute(
        path: Routes.joinedTeamsRoute,
        name: 'joinedTeams',
        builder:
            (BuildContext context, GoRouterState state) {
              return const JoinedTeamsView();
            },
      ),
      GoRoute(
        path: Routes.roundOf32Route,
        name: 'roundOf32',
        builder:
            (BuildContext context, GoRouterState state) {
              return const RoundOf32View();
            },
      ),
      GoRoute(
        path: Routes.roundOf16Route,
        name: 'roundOf16',
        builder:
            (BuildContext context, GoRouterState state) {
              return const RoundOf16View();
            },
      ),
      GoRoute(
        path: Routes.roundOf8Route,
        name: 'roundOf8',
        builder:
            (BuildContext context, GoRouterState state) {
              return const RoundOf8View();
            },
      ),
      GoRoute(
        path: Routes.semiFinalRoute,
        name: 'semiFinal',
        builder:
            (BuildContext context, GoRouterState state) {
              return const SemiFinalView();
            },
      ),
      GoRoute(
        path: Routes.finalRoute,
        name: 'final',
        builder:
            (BuildContext context, GoRouterState state) {
              return const FinalView();
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
