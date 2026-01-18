import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/injection_container.dart';

class EmptyMatchesWidget extends StatelessWidget {
  const EmptyMatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'no_matches_near'.tr(context),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: MyColors.greyText,
          ),
        ),
      ),
    );
  }
}
