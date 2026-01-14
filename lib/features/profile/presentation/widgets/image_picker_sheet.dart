import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 24.h),

          // 3 Options Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Take a Photo
              _OptionItem(
                label: 'Take a Photo',
                icon: Icons.camera_alt_outlined,
                color: Colors.black87,
                onTap: () {
                  // TODO: Implement camera logic
                  Navigator.pop(context);
                },
              ),

              // From Gallery
              _OptionItem(
                label: 'From Gallery',
                icon: Icons.photo_library_outlined,
                color: Colors.black87,
                onTap: () {
                  // TODO: Implement gallery logic
                  Navigator.pop(context);
                },
              ),

              // Remove Image
              _OptionItem(
                label: 'Remove Image',
                icon: Icons.delete_outline,
                color: Colors.red,
                onTap: () {
                  // TODO: Implement remove logic
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

/// Private reusable widget for each option item
class _OptionItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _OptionItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle Container with Icon
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                size: 24.sp,
                color: color,
              ),
            ),

            SizedBox(height: 8.h),

            // Label Text
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
