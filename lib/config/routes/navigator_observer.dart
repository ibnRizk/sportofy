import 'package:flutter/material.dart';

import '../../core/utils/log_utils.dart';
import '../../injection_container.dart';
import 'app_routes.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final routeName = _getRouteName(route);
    if (routeName != null) {
      AppRoutes.pushRouteToRoutesStack(routeName);
    }
    Log.i(
        '@ROUTES: [push] current: $routeName, previous: ${_getRouteName(previousRoute)}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final routeName = _getRouteName(route);
    if (routeName != null && routesStack.isNotEmpty) {
      AppRoutes.popRouteFromRoutesStack();
    }
    Log.i(
        '@ROUTES: [pop] current: $routeName, previous: ${_getRouteName(previousRoute)}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      final oldRouteName = _getRouteName(oldRoute);
      if (oldRouteName != null && routesStack.isNotEmpty) {
        AppRoutes.popRouteFromRoutesStack();
      }
    }

    if (newRoute != null) {
      final newRouteName = _getRouteName(newRoute);
      if (newRouteName != null) {
        AppRoutes.pushRouteToRoutesStack(newRouteName);
      }
    }
    Log.i(
        '@ROUTES: [replace] current: ${_getRouteName(newRoute)}, previous: ${_getRouteName(oldRoute)}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    final routeName = _getRouteName(route);
    if (routeName != null && routesStack.isNotEmpty) {
      String lastRoute = routesStack.last;
      routesStack.clear();
      routesStack.add(lastRoute);
    }
    Log.i(
        '@ROUTES: [remove] current: $routeName, previous: ${_getRouteName(previousRoute)}, routesStack: ${routesStack.toString()}');
  }

  String? _getRouteName(Route<dynamic>? route) {
    if (route == null) return null;
    // Get route name from settings
    return route.settings.name;
  }
}
