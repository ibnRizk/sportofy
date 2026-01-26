import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class TeamMemberTile extends StatelessWidget {
  final String name;
  final String role;
  final String? avatarPath;
  final VoidCallback? onRemove;

  const TeamMemberTile({
    super.key,
    required this.name,
    required this.role,
    this.avatarPath,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Content Row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 18.r,
                backgroundImage: AssetImage(avatarPath ?? ImgAssets.userAvatar),
              ),
              SizedBox(width: 8.w),
              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.medium10(
                        color: MyColors.darkGrayColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.regular10(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Remove Button in Corner (Top Right)
          Positioned(
            top: -4.h,
            right: -4.w,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.close,
                  size: 12.w,
                  color: MyColors.darkGrayColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
