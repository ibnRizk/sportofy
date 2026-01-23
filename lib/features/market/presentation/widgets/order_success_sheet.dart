import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class OrderSuccessSheet extends StatefulWidget {
  const OrderSuccessSheet({super.key});

  @override
  State<OrderSuccessSheet> createState() =>
      _OrderSuccessSheetState();
}

class _OrderSuccessSheetState
    extends State<OrderSuccessSheet> {
  void _navigateToHome() {
    // Navigate to home using go_router
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.go(Routes.homeScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          _navigateToHome();
        }
      },
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 40.h,
          ),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Title
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Text(
                  'Your request has been sent successfully',
                  style: TextStyles.medium18(
                    color: MyColors.darkGrayColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 32.h),

              // Delivery Illustration Image
              Image.asset(
                ImgAssets.deliverySuccess,
                width: double.infinity,
                height: 250.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250.h,
                    decoration: BoxDecoration(
                      color: MyColors.grey100,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    child: Icon(
                      Icons.local_shipping,
                      size: 80.sp,
                      color: MyColors.grey400,
                    ),
                  );
                },
              ),

              SizedBox(height: 24.h),

              // Delivery Time Text
              Row(
                children: [
                  Text(
                    'The order will reach you within ',
                    style: TextStyles.regular18(
                      color: MyColors.darkGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ' 3-5 days',
                    style: TextStyles.bold18(
                      color: MyColors.darkGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Back to Home Button
              SizedBox(
                width: double.infinity,
                height: 53.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Close the sheet - navigation will happen via PopScope
                    if (Navigator.canPop(context)) {
                      context.go(Routes.homeScreenRoute);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Back to home',
                    style: TextStyles.semiBold20(
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
