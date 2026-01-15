import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class StadiumLocationCard extends StatelessWidget {
  final String address;
  final String detailedAddress;
  final String mobile;

  const StadiumLocationCard({
    super.key,
    required this.address,
    required this.detailedAddress,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: MyColors.greenButton,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Delivery Location',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Map Stack
          Stack(
            alignment: Alignment.center,
            children: [
              // Map Image (Layer 1)
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                  child: Image.asset(
                    ImgAssets.mapPlaceholder,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to a colored container if image not found
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.map,
                            size: 48.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Location Pin (Layer 2)
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.2,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: MyColors.greenButton,
                    size: 32.sp,
                  ),
                ),
              ),
            ],
          ),

          // Footer Info
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  detailedAddress,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Mobile: $mobile',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
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
