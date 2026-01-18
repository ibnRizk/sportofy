import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class ContactInfoBottomSheet extends StatelessWidget {
  final String email;
  final String phone;
  final String connectedDate;

  const ContactInfoBottomSheet({
    super.key,
    required this.email,
    required this.phone,
    required this.connectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ═══════════════════════════════════════════════
          // DRAG HANDLE INDICATOR (Visual Pill)
          // ═══════════════════════════════════════════════
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha:0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // CONTENT PADDING
          // ═══════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Back Arrow + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24.w,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Contact Info',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Email Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: email,
                ),

                SizedBox(height: 28.h),

                // Phone Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: phone,
                ),

                SizedBox(height: 28.h),

                // Connected Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.link,
                  label: 'Connected',
                  value: connectedDate,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha:0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 20.w,
            color: Colors.black54,
          ),
        ),

        SizedBox(width: 16.w),

        // Label + Value Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.greenButton,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Static method to show the modal
  static void show(
    BuildContext context, {
    required String email,
    required String phone,
    required String connectedDate,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true, // ✅ Allow drag to dismiss
      isDismissible: true, // ✅ Allow tap outside to dismiss
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      builder: (context) => ContactInfoBottomSheet(
        email: email,
        phone: phone,
        connectedDate: connectedDate,
      ),
    );
  }
}
