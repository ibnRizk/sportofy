import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class NotificationTile extends StatelessWidget {
  final String userAvatar;
  final String userName;
  final String message;
  final String time;
  final String? actionButtonText;
  final VoidCallback? onActionTap;

  const NotificationTile({
    super.key,
    required this.userAvatar,
    required this.userName,
    required this.message,
    required this.time,
    this.actionButtonText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage(userAvatar),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle error silently
            },
          ),
          SizedBox(width: 12.w),

          // Notification Text (Expanded)
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
                children: [
                  // User Name (Bold)
                  TextSpan(
                    text: userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Message (Regular Grey)
                  TextSpan(
                    text: ' $message',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Time (Blue/Light Blue)
                  TextSpan(
                    text: ' $time',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.lightBlue[700],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Action Button (Conditional)
          if (actionButtonText != null && onActionTap != null)
            SizedBox(
              height: 36.h,
              child: ElevatedButton(
                onPressed: onActionTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  actionButtonText!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
