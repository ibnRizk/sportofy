import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../injection_container.dart';
import '../utils/values/text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? borderColor;
  final Color? iconColor;
  final Size? minimumSize, maximumSize;
  final double? buttonRadius;
  final double? sidePadding;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? iconSize;
  final double? elevation;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final String? icon;
  final String? iconSvg;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.borderColor,
    this.iconColor,
    this.minimumSize,
    this.maximumSize,
    this.buttonRadius,
    this.sidePadding,
    this.verticalPadding,
    this.horizontalPadding,
    this.iconSize,
    this.icon,
    this.iconSvg,
    this.textStyle,
    this.textColor,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding ?? 0.0),
      child: ElevatedButton(
        onPressed: onPressed,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        style: ElevatedButton.styleFrom(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          foregroundColor: context.colors.baseColor,
          backgroundColor: buttonColor ?? context.colors.main,
          elevation: elevation ?? 0,
          side: borderColor != null
              ? BorderSide(
                  color: borderColor ?? context.colors.main,
                  width: 1,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(buttonRadius == null ? 8.r : buttonRadius!.r)),
          ),
          minimumSize: minimumSize ?? Size(double.infinity, 56.h),
          maximumSize: maximumSize,
        ),
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              if (icon != null || iconSvg != null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        if (iconSvg != null) {
                          return SvgPicture.asset(
                            iconSvg!,
                            height: iconSize ?? 24.h,
                            width: iconSize ?? 24.w,
                            colorFilter: iconColor != null
                                ? ColorFilter.mode(
                                    iconColor!,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          );
                        } else {
                          return Image.asset(
                            icon!,
                            height: iconSize ?? 24.h,
                            color: iconColor,
                          );
                        }
                      },
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      text,
                      style: textStyle ??
                          TextStyles.medium16(
                              color: textColor ?? context.colors.baseColor),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ],
                );
              }
              return Text(
                text,
                style: textStyle ??
                    TextStyles.medium16(
                        color: textColor ?? context.colors.baseColor),
                textAlign: TextAlign.center,
                maxLines: 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
