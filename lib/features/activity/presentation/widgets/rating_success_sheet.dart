import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/config/routes/app_routes.dart';

class RatingSuccessSheet extends StatelessWidget {
  const RatingSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h30v30,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top25,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: AppDimens.w40,
            height: AppDimens.h4,
            decoration: BoxDecoration(
              color: MyColors.grey300,
              borderRadius: AppRadius.r2,
            ),
          ),

          SizedBox(height: AppDimens.h40),

          // Success Icon (Green Checkmark in Circle)
          Container(
            width: AppDimens.containerHeight100,
            height: AppDimens.containerHeight100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.greenButton,
            ),
            child: Icon(
              Icons.check,
              size: AppDimens.iconSize60,
              color: MyColors.white,
            ),
          ),

          SizedBox(height: AppDimens.h32),

          // Success Message
          Text(
            'Your request has been sent successfully',
            textAlign: TextAlign.center,
            style: TextStyles.medium16(color: MyColors.black87).copyWith(
              height: 1.4,
            ),
          ),

          SizedBox(height: AppDimens.h32),

          // Back to Home Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: () {
                // Close the success sheet
                Navigator.pop(context);
                // Navigate to home screen
                context.go(Routes.homeScreenRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r10,
                ),
                elevation: AppDimens.elevation0,
              ),
              child: Text(
                'Back to home',
                style: TextStyles.bold16(color: MyColors.white),
              ),
            ),
          ),

          SizedBox(height: AppDimens.h20),
        ],
      ),
    );
  }
}
