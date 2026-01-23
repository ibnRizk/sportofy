import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressOptionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const AddressOptionTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: Colors.black87),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
