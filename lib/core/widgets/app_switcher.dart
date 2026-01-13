import 'package:flutter/material.dart';

import '../../injection_container.dart';

class AppSwitcher extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;

  const AppSwitcher({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      activeColor: context.colors.baseColor,
      activeTrackColor: context.colors.main,
      inactiveThumbColor: context.colors.baseColor,
      inactiveTrackColor: context.colors.unselected,
      trackOutlineWidth: WidgetStateProperty.all(0),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      onChanged: onChanged,
    );
  }
}
