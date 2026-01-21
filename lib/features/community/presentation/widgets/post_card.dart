import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class PostCard extends StatelessWidget {
  final String authorName;
  final String authorAvatar;
  final String timestamp;
  final bool isPublic;
  final String content;
  final int likesCount;
  final String likedBy;
  final int commentsCount;

  const PostCard({
    super.key,
    required this.authorName,
    required this.authorAvatar,
    required this.timestamp,
    required this.isPublic,
    required this.content,
    required this.likesCount,
    required this.likedBy,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.h16),
      padding: AppPadding.h20v16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Timestamp, Public Icon
          Row(
            children: [
              CircleAvatar(
                radius: AppDimens.avatarSize25,
                backgroundImage: AssetImage(authorAvatar),
              ),
              SizedBox(width: AppDimens.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: TextStyles.bold15(
                        color: MyColors.black87,
                      ),
                    ),
                    SizedBox(height: AppDimens.h2),
                    Row(
                      children: [
                        Text(
                          timestamp,
                          style: TextStyles.regular12(
                            color: MyColors.grey600,
                          ),
                        ),
                        if (isPublic) ...[
                          SizedBox(width: AppDimens.w4),
                          Icon(
                            Icons.public,
                            size: AppDimens.badgeSize12,
                            color: MyColors.grey600,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Content Text
          Text(
            content,
            style: TextStyles.regular14(
              color: MyColors.black87,
            ).copyWith(height: 1.5),
          ),

          SizedBox(height: AppDimens.h16),

          // Social Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Likes with overlapping icons
              Row(
                children: [
                  // Overlapping reaction icons using provided asset
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: AppDimens.badgeSize20,
                        height: AppDimens.badgeSize20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColors.white,
                            width: AppDimens.borderWidth1 + 0.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImgAssets.communityPariOnly,
                            width: AppDimens.badgeSize20,
                            height: AppDimens.badgeSize20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: MyColors.blue100,
                                child: Icon(
                                  Icons.thumb_up,
                                  size: AppDimens.badgeSize12,
                                  color: MyColors.blue700,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: AppDimens.w12,
                        child: Container(
                          width: AppDimens.badgeSize20,
                          height: AppDimens.badgeSize20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.red100,
                            border: Border.all(
                              color: MyColors.white,
                              width: AppDimens.borderWidth1 + 0.5,
                            ),
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: AppDimens.badgeSize12,
                            color: MyColors.red700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: AppDimens.w8),
                  Text(
                    '$likedBy and $likesCount others',
                    style: TextStyles.medium13(
                      color: MyColors.black87,
                    ),
                  ),
                ],
              ),
              // Comments Count (Clickable)
              InkWell(
                onTap: () {
                  // Navigate to comments screen
                  if (!context.mounted) return;
                  try {
                    context.push(
                      Routes.commentsRoute,
                      extra: {
                        'postId': 0, // TODO: Pass actual post ID
                        'likedBy': likedBy,
                        'likesCount': likesCount,
                        'commentsCount': commentsCount,
                      },
                    );
                  } catch (e) {
                    debugPrint('Navigation error to CommentsView: $e');
                  }
                },
                child: Text(
                  '$commentsCount comments',
                  style: TextStyles.medium13(
                    color: MyColors.black87,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h12),

          // Divider
          Divider(
            height: AppDimens.dividerThickness1,
            color: MyColors.grey300,
            thickness: AppDimens.dividerThickness1,
          ),

          SizedBox(height: AppDimens.h8),

          // Action Buttons
          Row(
            children: [
              // Like Button
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: Handle like action
                  },
                  icon: Icon(
                    Icons.thumb_up_outlined,
                    size: AppDimens.iconSize20,
                    color: MyColors.grey700,
                  ),
                  label: Text(
                    'Like',
                    style: TextStyles.medium14(
                      color: MyColors.grey700,
                    ),
                  ),
                ),
              ),
              // Vertical Divider between buttons
              VerticalDivider(
                width: AppDimens.borderWidth1,
                thickness: AppDimens.dividerThickness1,
                color: MyColors.grey300,
                indent: AppDimens.h8,
                endIndent: AppDimens.h8,
              ),
              // Comment Button
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // Navigate to comments screen
                    if (!context.mounted) return;
                    try {
                      context.push(
                        Routes.commentsRoute,
                        extra: {
                          'postId': 0, // TODO: Pass actual post ID
                          'likedBy': likedBy,
                          'likesCount': likesCount,
                          'commentsCount': commentsCount,
                        },
                      );
                    } catch (e) {
                      debugPrint('Navigation error to CommentsView: $e');
                    }
                  },
                  icon: Icon(
                    Icons.comment_outlined,
                    size: AppDimens.iconSize20,
                    color: MyColors.grey700,
                  ),
                  label: Text(
                    'Comment',
                    style: TextStyles.medium14(
                      color: MyColors.grey700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Divider under buttons
          Divider(
            height: AppDimens.dividerThickness1,
            color: MyColors.grey300,
            thickness: AppDimens.dividerThickness1,
          ),
        ],
      ),
    );
  }
}
