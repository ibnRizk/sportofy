import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class ActivityCard extends StatelessWidget {
  final String userName;
  final String? userImage;
  final String statusLabel;
  final Color statusBgColor;
  final Color statusTextColor;
  final String stadiumName;
  final String date;
  final String time;
  final String duration;
  final String footerDate;
  final String? actionButtonText;
  final VoidCallback? onActionTap;
  final bool showResellIcon;

  const ActivityCard({
    super.key,
    required this.userName,
    this.userImage,
    required this.statusLabel,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.stadiumName,
    required this.date,
    required this.time,
    required this.duration,
    required this.footerDate,
    this.actionButtonText,
    this.onActionTap,
    this.showResellIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Avatar + Name + Status Badge)
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: userImage != null
                    ? AssetImage(userImage!)
                    : AssetImage(ImgAssets.userAvatar),
              ),
              SizedBox(width: 12.w),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Info Grid (2x2)
          Row(
            children: [
              // Column 1
              Expanded(
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.stadium_outlined,
                      text: stadiumName,
                    ),
                    SizedBox(height: 8.h),
                    _InfoRow(
                      icon: Icons.access_time,
                      text: time,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Column 2
              Expanded(
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: date,
                    ),
                    SizedBox(height: 8.h),
                    _InfoRow(
                      icon: Icons.timer_outlined,
                      text: duration,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Divider
          Divider(
            height: 1.h,
            thickness: 1,
            color: Colors.grey.withValues(alpha: 0.2),
          ),

          SizedBox(height: 12.h),

          // Footer Row (Date + Action Button)
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                footerDate,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
              if (actionButtonText != null)
                _ActionButton(
                  text: actionButtonText!,
                  onTap: onActionTap,
                  showResellIcon: showResellIcon,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Info row helper widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Action button helper widget
class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool showResellIcon;

  const _ActionButton({
    required this.text,
    this.onTap,
    this.showResellIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showResellIcon) ...[
              Icon(
                Icons.refresh,
                size: 16.sp,
                color: Colors.black87,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
