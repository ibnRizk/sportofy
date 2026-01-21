import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

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
      padding: AppPadding.h20v12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          CircleAvatar(
            radius: AppDimens.avatarSize30,
            backgroundImage: AssetImage(userAvatar),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle error silently
            },
          ),
          SizedBox(width: AppDimens.w12),

          // Notification Text (Expanded)
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyles.regular14(color: MyColors.black87).copyWith(
                  height: 1.5,
                ),
                children: [
                  // User Name (Bold)
                  TextSpan(
                    text: userName,
                    style: TextStyles.bold14(color: MyColors.black87),
                  ),
                  // Message (Regular Grey)
                  TextSpan(
                    text: ' $message',
                    style: TextStyles.regular14(color: MyColors.grey700),
                  ),
                  // Time (Blue/Light Blue)
                  TextSpan(
                    text: ' $time',
                    style: TextStyles.regular14(color: MyColors.lightBlue400),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Action Button (Conditional)
          if (actionButtonText != null && onActionTap != null)
            SizedBox(
              height: AppDimens.h36,
              child: ElevatedButton(
                onPressed: onActionTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r8,
                  ),
                  padding: AppPadding.h16v8,
                  elevation: AppDimens.elevation0,
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  actionButtonText!,
                  style: TextStyles.semiBold12(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
