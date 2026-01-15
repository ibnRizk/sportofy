import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_methods_sheet.dart';

class DeliveryAddressSheet extends StatelessWidget {
  const DeliveryAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 20.h),

          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                  size: 24.sp,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(width: 12.w),
              Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Address Options
          Column(
            children: [
              // Option 1: Saved Address
              _buildAddressOption(
                context: context,
                icon: Icons.location_on_outlined,
                text: 'region, street',
                onTap: () {
                  _handleAddressSelection(context, 'saved');
                },
              ),

              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
                indent: 20.w,
                endIndent: 20.w,
              ),

              // Option 2: Current Location
              _buildAddressOption(
                context: context,
                icon: Icons.my_location,
                text: 'Deliver to current location',
                onTap: () {
                  _handleAddressSelection(context, 'current');
                },
              ),

              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
                indent: 20.w,
                endIndent: 20.w,
              ),

              // Option 3: Different Location
              _buildAddressOption(
                context: context,
                icon: Icons.pin_drop_outlined,
                text: 'Deliver to different location',
                onTap: () {
                  _handleAddressSelection(context, 'different');
                },
              ),
            ],
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildAddressOption({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: Colors.black87,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddressSelection(BuildContext context, String option) {
    // Close the delivery address sheet
    Navigator.pop(context);

    // Handle based on selection
    if (option == 'saved' || option == 'current') {
      // Open Payment Methods Sheet
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          builder: (context) => const PaymentMethodsSheet(),
        );
      });
    } else if (option == 'different') {
      // Navigate to Map Screen (placeholder for now)
      // TODO: Navigate to map screen when implemented
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Map screen coming soon',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.grey[700],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }
}
