import 'package:flutter/material.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
        borderRadius: AppRadius.r16,
      ),
      child: Padding(
        padding: AppPadding.p24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location Icon
            Container(
              width: AppDimens.containerWidth60,
              height: AppDimens.containerHeight60,
              decoration: BoxDecoration(
                color: MyColors.greenButton.withValues(alpha: AppDimens.opacity1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on,
                color: MyColors.greenButton,
                size: AppDimens.iconSize32,
              ),
            ),

            SizedBox(height: AppDimens.h20),

            // Title
            Text(
              'allow_location'.tr(context),
              textAlign: TextAlign.center,
              style: TextStyles.semiBold16(
                color: context.colors.textColor,
              ).copyWith(height: 1.5),
            ),

            SizedBox(height: AppDimens.h32),

            // Allow Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onAllow,
                style: TextButton.styleFrom(
                  padding: AppPadding.v12,
                ),
                child: Text(
                  'allow_while_using'.tr(context),
                  style: TextStyles.semiBold16(
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h8),

            // Deny Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onDeny,
                style: TextButton.styleFrom(
                  padding: AppPadding.v12,
                ),
                child: Text(
                  'deny'.tr(context),
                  style: TextStyles.semiBold16(
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
