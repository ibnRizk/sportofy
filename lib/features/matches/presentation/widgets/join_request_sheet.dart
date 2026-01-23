import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class JoinRequestSheet extends StatelessWidget {
  final String organizerName;
  final String organizerAvatar;

  const JoinRequestSheet({
    super.key,
    required this.organizerName,
    required this.organizerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
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
            // Drag Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 24.h),

            // Main Message
            Text(
              'Ask the founder to accept your request to enjoy the game together ✌️',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Organizer Profile Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: AssetImage(organizerAvatar),
                  ),

                  SizedBox(width: 12.w),

                  // Name and Role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          organizerName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Organizer',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greenButton,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Chat Icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.blue[700],
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Info Message
            Text(
              'If the founder of the team agrees to join you, the payment will be completed',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30.h),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home
                  if (!context.mounted) return;
                  try {
                    // Close all sheets and navigate to home
                    Navigator.of(context, rootNavigator: true)
                        .popUntil((route) => route.isFirst);
                    context.go(Routes.homeScreenRoute);
                  } catch (e) {
                    debugPrint('Navigation error to home: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  disabledBackgroundColor: MyColors.grey300,
                  disabledForegroundColor: MyColors.white,
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

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
