import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class DetectLocationView extends StatelessWidget {
  const DetectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Detect location',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // ═══════════════════════════════════════════════
          // LAYER 1: MAP BACKGROUND (Placeholder)
          // ═══════════════════════════════════════════════
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[200],
              // Optional: Add a map pattern image if available
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/map_pattern.png'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Center(
                child: Text(
                  'Map Placeholder\n(Google Maps will be integrated here)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 2: TOP SEARCH BAR (Floating)
          // ═══════════════════════════════════════════════
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.search,
                      size: 24.sp,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[500],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                  ],
                ),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 3: CENTER PIN (Fixed Marker)
          // ═══════════════════════════════════════════════
          Center(
            child: Icon(
              Icons.location_on,
              size: 50.sp,
              color: MyColors.greenButton,
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 4: BOTTOM CONTROLS (Floating Actions)
          // ═══════════════════════════════════════════════
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // My Location Button (Right-aligned)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, bottom: 20.h),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Get current location
                        },
                        icon: Icon(
                          Icons.my_location,
                          size: 24.sp,
                          color: Colors.black87,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),

                // Select Button (Full width)
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.h,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return selected location and close
                        context.pop();
                        // TODO: Return location data
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.greenButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Select the location',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
