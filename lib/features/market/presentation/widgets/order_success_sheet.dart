import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class OrderSuccessSheet extends StatefulWidget {
  const OrderSuccessSheet({super.key});

  @override
  State<OrderSuccessSheet> createState() =>
      _OrderSuccessSheetState();
}

class _OrderSuccessSheetState
    extends State<OrderSuccessSheet> {
  @override
  void initState() {
    super.initState();
    // Automatically navigate to home after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      // Close the sheet first
      Navigator.pop(context);
      // Clear navigation stack and navigate to home
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamedAndRemoveUntil(
          Routes.homeScreenRoute,
          (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 40.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: MyColors.greenButton,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.greenButton.withValues(
                    alpha: 0.3,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.check,
              size: 50.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 32.h),

          // Title
          Text(
            'Order placed successfully',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // Subtitle
          Text(
            'You will receive an email confirmation',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          // Back to Home Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Close the sheet first
                Navigator.pop(context);

                // Clear navigation stack and navigate to home
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    if (!context.mounted) return;
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamedAndRemoveUntil(
                      Routes.homeScreenRoute,
                      (route) => false,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Back to home',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
