import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

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
        margin: AppPadding.right16,
        child: Column(
          children: [
            // Avatar with Online Indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: AppDimens.avatarSize30,
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
            SizedBox(height: AppDimens.h8),
            // User Name (First name only)
            Text(
              userName.split(' ').first,
              style: TextStyles.medium12(color: MyColors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
