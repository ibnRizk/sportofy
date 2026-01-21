import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

enum MessageType { sent, received }

class MessageBubble extends StatelessWidget {
  final String message;
  final MessageType type;
  final String? userAvatar;
  final String timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.type,
    this.userAvatar,
    this.timestamp = '',
  });

  @override
  Widget build(BuildContext context) {
    final isSent = type == MessageType.sent;

    return Padding(
      padding: AppPadding.h20v4,
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar (only for received messages, on the left)
          if (!isSent && userAvatar != null)
            Padding(
              padding: AppPadding.right8,
              child: CircleAvatar(
                radius: AppDimens.avatarSize16,
                backgroundImage: AssetImage(userAvatar!),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle error silently
                },
              ),
            ),

          // Message Bubble
          Flexible(
            child: Container(
              padding: AppPadding.h16v10,
              decoration: BoxDecoration(
                color: isSent
                    ? const Color(0xFF2F9DA5) // Teal/Blue for sent
                    : MyColors.grey100, // Light grey for received
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.h16),
                  topRight: Radius.circular(AppDimens.h16),
                  bottomLeft: isSent ? Radius.circular(AppDimens.h16) : Radius.circular(AppDimens.h4),
                  bottomRight: isSent ? Radius.circular(AppDimens.h4) : Radius.circular(AppDimens.h16),
                ),
              ),
              child: Text(
                message,
                style: TextStyles.regular14(color: isSent ? MyColors.white : MyColors.black87).copyWith(height: 1.4),
              ),
            ),
          ),

          // Avatar (only for sent messages, on the right - optional)
          if (isSent && userAvatar != null)
            Padding(
              padding: AppPadding.left8,
              child: CircleAvatar(
                radius: AppDimens.avatarSize16,
                backgroundImage: AssetImage(userAvatar!),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle error silently
                },
              ),
            ),
        ],
      ),
    );
  }
}
