import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
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
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Timestamp, Public Icon
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage(authorAvatar),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          timestamp,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (isPublic) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.public,
                            size: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Content Text
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              height: 1.5,
            ),
          ),

          SizedBox(height: 16.h),

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
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImgAssets.communityPariOnly,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.blue[100],
                                child: Icon(
                                  Icons.thumb_up,
                                  size: 12.sp,
                                  color: Colors.blue[700],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red[100],
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 12.sp,
                            color: Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '$likedBy and $likesCount others',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
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
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Divider
          Divider(
            height: 1,
            color: Colors.grey[300],
            thickness: 1,
          ),

          SizedBox(height: 8.h),

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
                    size: 20.sp,
                    color: Colors.grey[700],
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
              // Vertical Divider between buttons
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.grey[300],
                indent: 8.h,
                endIndent: 8.h,
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
                    size: 20.sp,
                    color: Colors.grey[700],
                  ),
                  label: Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Divider under buttons
          Divider(
            height: 1,
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
