import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/locale/app_localizations.dart';
import '../../injection_container.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_radius.dart';
import '../utils/values/text_styles.dart';

class MyDefaultButton extends StatelessWidget {
  final String? btnText;
  final bool localeText;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final bool isSelected;
  final double? height;
  final double? width;
  final String? svgAsset;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? borderColor;

  const MyDefaultButton({
    super.key,
    this.btnText,
    this.textStyle,
    this.onPressed,
    this.color,
    this.isSelected = true,
    this.localeText = false,
    this.textColor,
    this.height,
    this.width,
    this.svgAsset,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    AppLocalizations locale = AppLocalizations.of(context)!;
    return SizedBox(
      width: width ?? screenWidth,
      height: height ?? AppDimens.buttonHeight56,
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!.r)
                  : AppRadius.r12,
              side: BorderSide(
                color: borderColor ?? context.colors.borderColor,
                width: AppDimens.borderWidth1,
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (onPressed == null || states.contains(WidgetState.disabled)) {
                return MyColors.grey300;
              }
              return color ?? context.colors.main;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (onPressed == null || states.contains(WidgetState.disabled)) {
                return MyColors.white;
              }
              return textColor ?? context.colors.upBackGround;
            },
          ),
        ),
        onPressed: onPressed,
        child: svgAsset == null
            ? Text(
                localeText ? btnText! : locale.text(btnText!),
                textAlign: TextAlign.center,
                style: textStyle ??
                    TextStyles.regular16(
                      color: textColor ?? context.colors.upBackGround,
                    ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgAsset!,
                    height: AppDimens.iconSize16,
                    width: AppDimens.w16,
                    colorFilter: ColorFilter.mode(
                      textColor ?? context.colors.upBackGround,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: AppDimens.w10),
                  Text(
                    localeText ? btnText! : locale.text(btnText!),
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyles.regular16(
                          color: textColor ?? context.colors.textColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
