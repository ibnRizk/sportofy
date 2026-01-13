import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/injection_container.dart';

import '../utils/values/text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              backgroundColor ??
              context.colors.unselectedColor,
          side: BorderSide(
            color:
                borderColor ??
                context.colors.unselectedColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath.endsWith('.svg'))
              SvgPicture.asset(
                iconPath,
                width: 24.w,
                height: 24.h,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(
                        iconColor!,
                        BlendMode.srcIn,
                      )
                    : null,
              )
            else
              Image.asset(
                iconPath,
                width: 24.w,
                height: 24.h,
                color: iconColor,
              ),
            Spacer(),
            Text(
              text,
              style: TextStyles.regular16(
                color:
                    textColor ?? context.colors.textColor,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
