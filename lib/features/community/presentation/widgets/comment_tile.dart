import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class CommentReply {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final String timestamp;
  final int likesCount;

  CommentReply({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.timestamp,
    required this.likesCount,
  });
}

class CommentTile extends StatelessWidget {
  final String commentId;
  final String authorName;
  final String authorAvatar;
  final String content;
  final String timestamp;
  final int likesCount;
  final bool hasPreviousReplies;
  final int previousRepliesCount;
  final List<CommentReply>? replies;

  const CommentTile({
    super.key,
    required this.commentId,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.timestamp,
    required this.likesCount,
    this.hasPreviousReplies = false,
    this.previousRepliesCount = 0,
    this.replies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Comment
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(authorAvatar),
              ),
              SizedBox(width: 12.w),
              // Comment Bubble
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author Name
                      Text(
                        authorName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Comment Content
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Actions Row
          Padding(
            padding: EdgeInsets.only(left: 52.w, top: 8.h),
            child: Row(
              children: [
                // Timestamp
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: MyColors.darkGrayColor,
                  ),
                ),
                SizedBox(width: 16.w),
                // Like Button
                InkWell(
                  onTap: () {
                    // TODO: Handle like comment
                  },
                  child: Text(
                    'Like',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Reply Button
                InkWell(
                  onTap: () {
                    // TODO: Handle reply
                  },
                  child: Text(
                    'Reply',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                // Like Count
                if (likesCount > 0) ...[
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.thumb_up,
                    size: 14.sp,
                    color: MyColors.darkGrayColor,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '$likesCount',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // View Previous Replies
          if (hasPreviousReplies && previousRepliesCount > 0)
            Padding(
              padding: EdgeInsets.only(left: 52.w, top: 8.h),
              child: InkWell(
                onTap: () {
                  // TODO: Show previous replies
                },
                child: Text(
                  'View $previousRepliesCount previous reply${previousRepliesCount > 1 ? 'ies' : ''}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ),

          // Replies (Nested)
          if (replies != null && replies!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 32.w, top: 12.h),
              child: Column(
                children: replies!.map((reply) {
                  return _buildReplyTile(reply);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReplyTile(CommentReply reply) {
    return Padding(
      padding: AppPadding.bottom12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Smaller Avatar for Reply
          CircleAvatar(
            radius: AppDimens.avatarSize16,
            backgroundImage: AssetImage(reply.authorAvatar),
          ),
          SizedBox(width: AppDimens.w12),
          // Reply Bubble
          Expanded(
            child: Container(
              padding: EdgeInsets.all(AppDimens.w10),
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: AppRadius.r12,
                border: Border.all(
                  color: MyColors.grey200,
                  width: AppDimens.borderWidth1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Name
                  Text(
                    reply.authorName,
                    style: TextStyles.bold13(
                      color: MyColors.black87,
                    ),
                  ),
                  SizedBox(height: AppDimens.h4),
                  // Reply Content
                  Text(
                    reply.content,
                    style: TextStyles.regular13(
                      color: MyColors.black87,
                    ).copyWith(height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
