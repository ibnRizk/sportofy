import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 4.h,
      ),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar (only for received messages, on the left)
          if (!isSent && userAvatar != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: CircleAvatar(
                radius: 16.r,
                backgroundImage: AssetImage(userAvatar!),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle error silently
                },
              ),
            ),

          // Message Bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: isSent
                    ? const Color(0xFF2F9DA5) // Teal/Blue for sent
                    : const Color(0xFFF2F4F5), // Light grey for received
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: isSent ? Radius.circular(16.r) : Radius.circular(4.r),
                  bottomRight: isSent ? Radius.circular(4.r) : Radius.circular(16.r),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: isSent ? Colors.white : Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),

          // Avatar (only for sent messages, on the right - optional)
          if (isSent && userAvatar != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: CircleAvatar(
                radius: 16.r,
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
