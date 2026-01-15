import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class BookingSuccessSheet extends StatelessWidget {
  const BookingSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Success Icon (Prominent)
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: MyColors.greenButton,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 60.sp,
            ),
          ),

          SizedBox(height: 30.h),

          // Success Message
          Text(
            'Your request has been sent successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 40.h),

          // Back to Home Button
          SizedBox(
            width: double.infinity,
            height: 55.h,
            child: ElevatedButton(
              onPressed: () {
                // Close the success sheet first
                Navigator.pop(context);
                
                // Navigate to home and clear the stack
                context.go(Routes.homeScreenRoute);
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
