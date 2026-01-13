import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/locale/app_localizations.dart';
import '../../injection_container.dart';

class BackIcon extends StatelessWidget {
  final Function()? onBack;
  const BackIcon({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBack ?? () => Navigator.of(context).pop(),
      child: Icon(
        AppLocalizations.of(context)!.isArLocale
            ? Icons.arrow_back
            : Icons.arrow_forward,
        size: 24.w,
        color: context.colors.textColor,
      ),
    );
  }
}
