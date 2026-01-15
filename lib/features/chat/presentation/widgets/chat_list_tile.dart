import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class ChatListTile extends StatelessWidget {
  final String userAvatar;
  final String userName;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;

  const ChatListTile({
    super.key,
    required this.userAvatar,
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            // Navigate to personal chat
            context.push(
              Routes.personalChatRoute,
              extra: {
                'userName': userName,
                'userAvatar': userAvatar,
                'isOnline': isOnline,
              },
            );
          },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 12.h,
        ),
        child: Row(
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
                // Online Indicator (if online)
                if (isOnline)
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
            SizedBox(width: 12.w),
            // Name and Message (Expanded)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name (Bold)
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  // Last Message Preview (Truncated, Grey)
                  Text(
                    lastMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Timestamp and Unread Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Timestamp
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                // Unread Badge (if unread messages exist)
                if (unreadCount > 0)
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[400],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
