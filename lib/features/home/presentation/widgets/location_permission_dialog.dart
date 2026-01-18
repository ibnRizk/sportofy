import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/injection_container.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const LocationPermissionDialog({
    super.key,
    required this.onAllow,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location Icon
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: MyColors.greenButton.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on,
                color: MyColors.greenButton,
                size: 32.w,
              ),
            ),

            SizedBox(height: 20.h),

            // Title
            Text(
              'allow_location'.tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.textColor,
                height: 1.5,
              ),
            ),

            SizedBox(height: 32.h),

            // Allow Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onAllow,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  'allow_while_using'.tr(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // Deny Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onDeny,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  'deny'.tr(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
