import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class PaymentSuccessSheet extends StatelessWidget {
  const PaymentSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h30v40,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            width: AppDimens.iconSize80,
            height: AppDimens.iconSize80,
            decoration: BoxDecoration(
              color: MyColors.greenButton,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: MyColors.white,
              size: AppDimens.iconSize50,
            ),
          ),

          SizedBox(height: AppDimens.h20),

          // Success Message
          Text(
            'Your request has been sent successfully',
            style: TextStyles.medium16(color: MyColors.black87),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppDimens.h30),

          // Back to Home Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: () {
                // Close the success sheet first
                Navigator.pop(context);
                
                // Navigate to home and clear the stack
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
        ],
      ),
    );
  }
}
