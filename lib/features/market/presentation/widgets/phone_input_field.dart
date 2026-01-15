import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;

  const PhoneInputField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Flag Icon and Country Code
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                // Egypt Flag (using placeholder - you can replace with actual flag asset)
                Container(
                  width: 24.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Center(
                    child: Container(
                      width: 24.w,
                      height: 5.h,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '+20',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(
            width: 1,
            height: 30.h,
            color: Colors.grey[300],
          ),

          // Phone Number Input
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your Phone number',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
