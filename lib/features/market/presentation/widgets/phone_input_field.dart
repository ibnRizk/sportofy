import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;

  const PhoneInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),

        border: Border.all(
          color: MyColors.darkGrayColor,
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
                // Egypt Flag
                Image.asset(
                  ImgAssets.egyptFlag,
                  width: 24.w,
                  height: 16.h,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                        return Container(
                          width: 24.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(2.r),
                          ),
                        );
                      },
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
                color: MyColors.darkGrayColor,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your Phone number',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[400]!,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.darkGrayColor,
                    width: 1,
                  ),
                ),
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
