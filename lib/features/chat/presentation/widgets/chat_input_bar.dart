import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onPlusTap;
  final VoidCallback? onSendTap;
  final VoidCallback? onMicTap;
  final VoidCallback? onEmojiTap;
  final bool showAttachments;

  const ChatInputBar({
    super.key,
    required this.controller,
    this.onPlusTap,
    this.onSendTap,
    this.onMicTap,
    this.onEmojiTap,
    this.showAttachments = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.trim().isNotEmpty;

    return Container(
      padding: AppPadding.h16v8,
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border(
          top: BorderSide(
            color: MyColors.grey300,
            width: AppDimens.borderWidth1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Plus Icon Button
          IconButton(
            onPressed: onPlusTap,
            icon: Container(
              width: AppDimens.w36,
              height: AppDimens.w36,
              decoration: BoxDecoration(
                color: MyColors.grey200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: AppDimens.iconSize24,
                color: MyColors.black87,
              ),
            ),
            padding: AppPadding.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: AppDimens.w8),

          // Text Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.grey100,
                borderRadius: AppRadius.r24,
              ),
              child: Row(
                children: [
                  // Emoji Icon
                  IconButton(
                    onPressed: onEmojiTap,
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      size: AppDimens.iconSize20,
                      color: MyColors.grey600,
                    ),
                    padding: AppPadding.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: AppDimens.w4),

                  // Text Field
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyles.regular14(color: MyColors.darkGrayColor),
                        border: InputBorder.none,
                        contentPadding: AppPadding.v10,
                        isDense: true,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      style: TextStyles.regular14(color: MyColors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppDimens.w8),

          // Send or Microphone Icon
          IconButton(
            onPressed: hasText ? onSendTap : onMicTap,
            icon: Icon(
              hasText ? Icons.send : Icons.mic,
              size: AppDimens.iconSize24,
              color: MyColors.black87,
            ),
            padding: AppPadding.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
