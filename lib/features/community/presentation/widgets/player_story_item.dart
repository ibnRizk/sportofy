import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class PlayerStoryItem extends StatelessWidget {
  final String name;
  final String avatar;

  const PlayerStoryItem({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with Online Indicator
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 35.r,
              backgroundImage: AssetImage(avatar),
            ),
            // Green Online Indicator
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: MyColors.greenButton,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Name
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
