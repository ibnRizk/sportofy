import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String value;
  final bool isSelector;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final Widget? leadingIcon;

  const ProfileField({
    super.key,
    required this.title,
    required this.value,
    this.isSelector = false,
    this.isReadOnly = false,
    this.onTap,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelector ? onTap : null,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.grey.withValues(alpha:0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                if (leadingIcon != null) ...[
                  leadingIcon!,
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (isSelector)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                    color: Colors.grey,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
