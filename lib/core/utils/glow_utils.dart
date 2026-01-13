import 'package:flutter/material.dart';
import 'package:sportify_app/injection_container.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: context.colors.main,
      child: child,
    );
  }
}
