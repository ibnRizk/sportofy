import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

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
      padding: EdgeInsets.all(8.r), // Reduced padding to prevent overflow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18.r, // Slightly smaller avatar
            backgroundImage: AssetImage(avatarPath ?? ImgAssets.userAvatar),
          ),
          SizedBox(width: 8.w), // Reduced spacing
          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1, // Prevent text wrapping
                  overflow: TextOverflow.ellipsis, // Truncate with ...
                  style: TextStyle(
                    fontSize: 13.sp, // Slightly smaller font
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  role,
                  maxLines: 1, // Prevent text wrapping
                  overflow: TextOverflow.ellipsis, // Truncate with ...
                  style: TextStyle(
                    fontSize: 11.sp, // Slightly smaller font
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Remove Button
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.cancel,
              size: 18.w, // Slightly smaller icon
              color: Colors.grey,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
