import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

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
      onTap:
          onTap ??
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
        padding: AppPadding.h20v12,
        child: Row(
          children: [
            // Avatar with Online Indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: AppDimens.avatarSize30,
                  backgroundImage: AssetImage(userAvatar),
                  onBackgroundImageError:
                      (exception, stackTrace) {
                        // Handle error silently
                      },
                ),
                // Online Indicator (if online)
                if (isOnline)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: AppDimens.badgeSize16,
                      height: AppDimens.badgeSize16,
                      decoration: BoxDecoration(
                        color: MyColors.greenButton,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.white,
                          width: AppDimens.borderWidth2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: AppDimens.w12),
            // Name and Message (Expanded)
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // User Name (Bold)
                  Text(
                    userName,
                    style: TextStyles.medium14(
                      color: context.colors.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimens.h4),
                  // Last Message Preview (Truncated, Grey)
                  Text(
                    lastMessage,
                    style: TextStyles.regular14(
                      color: MyColors.darkGrayColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: AppDimens.w12),
            // Timestamp and Unread Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Timestamp
                Text(
                  timestamp,
                  style: TextStyles.regular12(
                    color: MyColors.darkGrayColor,
                  ),
                ),
                SizedBox(height: AppDimens.h4),
                // Unread Badge (if unread messages exist)
                if (unreadCount > 0)
                  Container(
                    width: AppDimens.badgeSize24,
                    height: AppDimens.badgeSize24,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        108,
                        169,
                        198,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyles.bold11(
                          color: MyColors.white,
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
