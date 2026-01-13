import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '/config/locale/app_localizations.dart';
import '../../injection_container.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onBack;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final double? iconSize;

  const CustomBackButton({
    super.key,
    this.onBack,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRtl = AppLocalizations.of(context)!.isArLocale;

    return GestureDetector(
      onTap: onBack ?? () => context.pop(),
      child: Container(
        width: size ?? 44.w,
        height: size ?? 44.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colors.unselectedColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Icon(
            isRtl
                ? Icons.arrow_forward_ios_outlined
                : Icons.arrow_back_ios_new_rounded,
            size: iconSize ?? 16.w,
            color: iconColor ?? context.colors.textColor,
          ),
        ),
      ),
    );
  }
}
