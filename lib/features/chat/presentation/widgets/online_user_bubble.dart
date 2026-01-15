import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class OnlineUserBubble extends StatelessWidget {
  final String userAvatar;
  final String userName;
  final VoidCallback? onTap;

  const OnlineUserBubble({
    super.key,
    required this.userAvatar,
    required this.userName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            // Navigate to personal chat
            context.push(
              Routes.personalChatRoute,
              extra: {
                'userName': userName,
                'userAvatar': userAvatar,
                'isOnline': true,
              },
            );
          },
      child: Container(
        margin: EdgeInsets.only(right: 16.w),
        child: Column(
          children: [
            // Avatar with Online Indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage(userAvatar),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle error silently
                  },
                ),
                // Online Indicator (Green circle with white border)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: MyColors.greenButton,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // User Name (First name only)
            Text(
              userName.split(' ').first,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
