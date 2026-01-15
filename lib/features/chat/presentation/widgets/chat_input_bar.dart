import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Plus Icon Button
          IconButton(
            onPressed: onPlusTap,
            icon: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 24.sp,
                color: Colors.black87,
              ),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 8.w),

          // Text Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  // Emoji Icon
                  IconButton(
                    onPressed: onEmojiTap,
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      size: 20.sp,
                      color: Colors.grey[600],
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 4.w),

                  // Text Field
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        isDense: true,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Send or Microphone Icon
          IconButton(
            onPressed: hasText ? onSendTap : onMicTap,
            icon: Icon(
              hasText ? Icons.send : Icons.mic,
              size: 24.sp,
              color: Colors.black87,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
