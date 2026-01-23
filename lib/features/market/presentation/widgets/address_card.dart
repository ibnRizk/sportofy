import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class AddressCard extends StatelessWidget {
  final String address;
  final String street;
  final String mobile;
  final VoidCallback? onEdit;

  const AddressCard({
    super.key,
    required this.address,
    required this.street,
    required this.mobile,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.r),
                ),
                child: Image.asset(
                  ImgAssets.mapPlaceholder,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 180.h,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.map,
                            size: 50.sp,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                ),
              ),
              // Green Pin Icon Centered
              Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    size: 40.sp,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ],
          ),

          // Address Details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                    ),
                    if (onEdit != null)
                      GestureDetector(
                        onTap: onEdit,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: MyColors.greenButton,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Street Address
                Text(
                  street,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: MyColors.darkGrayColor,
                  ),
                ),
                SizedBox(height: 4.h),

                // Mobile Number
                Text(
                  'Mobile: $mobile',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
