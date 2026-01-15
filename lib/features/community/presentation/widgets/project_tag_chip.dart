import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class ProjectTagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onDeleted;

  const ProjectTagChip({
    super.key,
    required this.label,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: MyColors.greenButton.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: MyColors.greenButton,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: MyColors.greenButton,
            ),
          ),
          if (onDeleted != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                Icons.close,
                size: 16.sp,
                color: MyColors.greenButton,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
