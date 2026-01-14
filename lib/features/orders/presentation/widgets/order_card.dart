import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String receivedDate;
  final String status;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.receivedDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/order-details');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
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
            // Header Row: Order ID + Status Badge
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID : $orderId',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                _buildStatusBadge(),
              ],
            ),

            SizedBox(height: 12.h),

            // Info Section
            Text(
              'Order date: $orderDate',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Received date: $receivedDate',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),

            // Divider
            Divider(
              height: 24.h,
              thickness: 1,
              color: Colors.grey[200],
            ),

            // Footer Action Button
            Align(
              alignment: Alignment.centerRight,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'ordered':
        bgColor = const Color(0xFFE3F2FD); // Light Blue
        textColor = const Color(0xFF1976D2); // Blue
        break;
      case 'canceled':
        bgColor = const Color(0xFFFFEBEE); // Light Red
        textColor = const Color(0xFFD32F2F); // Red
        break;
      case 'shipped':
        bgColor = const Color(0xFFFFF3E0); // Light Orange
        textColor = const Color(0xFFFF9800); // Orange
        break;
      case 'delivered':
        bgColor = const Color(0xFFE8F5E9); // Light Green
        textColor = const Color(0xFF4CAF50); // Green
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    // Determine button properties based on status
    String buttonText;
    Color borderColor;
    Color textColor;
    bool isDisabled = false;
    IconData? icon;

    if (status.toLowerCase() == 'ordered') {
      buttonText = 'Cancel';
      borderColor = const Color(0xFFD32F2F); // Red
      textColor = const Color(0xFFD32F2F);
    } else if (status.toLowerCase() == 'shipped') {
      buttonText = 'Cancel';
      borderColor = Colors.grey[300]!;
      textColor = Colors.grey[400]!;
      isDisabled = true;
    } else if (status.toLowerCase() == 'canceled' ||
        status.toLowerCase() == 'delivered') {
      buttonText = 'Reorder';
      borderColor = const Color(0xFF4CAF50); // Green
      textColor = const Color(0xFF4CAF50);
      icon = Icons.refresh;
    } else {
      buttonText = 'Action';
      borderColor = Colors.grey[300]!;
      textColor = Colors.grey[700]!;
    }

    return OutlinedButton(
      onPressed: isDisabled
          ? null
          : () {
              // TODO: Implement action logic
            },
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 10.h,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18.w, color: textColor),
            SizedBox(width: 6.w),
          ],
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
