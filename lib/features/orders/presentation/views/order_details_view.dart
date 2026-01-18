import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Arriving Date',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),

            // Section 1: Arriving Date (Tracker Card)
            _buildArrivingDateCard(),

            SizedBox(height: 24.h),

            // Section 2: Delivery Location
            Text(
              'Delivery Location',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            _buildDeliveryLocationCard(),

            SizedBox(height: 24.h),

            // Section 3: Order Summary
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            _buildOrderSummaryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildArrivingDateCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arriving by 10 July',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Order ID : 9287KJ',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // The Custom Tracker
          _buildProgressTracker(),

          SizedBox(height: 24.h),

          // Buttons Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: null, // Disabled
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[400],
                    side: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                  ),
                  child: Text(
                    'Cancel Order',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Implement help & support
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MyColors.greenButton,
                    side: BorderSide(
                      color: MyColors.greenButton,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                  ),
                  child: Text(
                    'Help & Support',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracker() {
    const Color activeColor = Color(0xFF00BCD4); // Cyan
    final Color inactiveColor = Colors.grey[400]!;

    return Column(
      children: [
        // Labels Row
        Row(
          children: [
            Expanded(
              child: Text(
                'Ordered',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: activeColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Shipped',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: activeColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Delivered',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: inactiveColor,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Dots and Lines Row
        Row(
          children: [
            // First Dot (Active)
            Container(
              width: 12.w,
              height: 12.w,
              decoration: const BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),

            // First Line (Active)
            Expanded(
              child: Container(
                height: 2.h,
                color: activeColor,
              ),
            ),

            // Second Dot (Active)
            Container(
              width: 12.w,
              height: 12.w,
              decoration: const BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),

            // Second Line (Inactive)
            Expanded(
              child: Container(
                height: 2.h,
                color: inactiveColor,
              ),
            ),

            // Third Dot (Inactive)
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryLocationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Map Image Placeholder
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.r),
              ),
            ),
            child: Stack(
              children: [
                // Map pattern (you can replace with actual map asset)
                Center(
                  child: Icon(
                    Icons.map,
                    size: 60.w,
                    color: Colors.grey[400],
                  ),
                ),
                // Green Location Pin
                Center(
                  child: Icon(
                    Icons.location_on,
                    size: 40.w,
                    color: MyColors.greenButton,
                  ),
                ),
              ],
            ),
          ),

          // Address Info
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20.w,
                  color: Colors.black87,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cairo (Maadi)',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '8 street 9, floor 5, department 15',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Mobile: 01101110101',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/images/shoes.png',
                width: 80.w,
                height: 80.w,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 X Adidas barricade',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '3200 EGP',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xFF8BC34A,
                        ), // Light Green
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '41',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
