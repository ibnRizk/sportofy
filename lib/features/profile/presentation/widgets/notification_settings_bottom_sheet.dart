import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class NotificationSettingsBottomSheet
    extends StatefulWidget {
  const NotificationSettingsBottomSheet({super.key});

  @override
  State<NotificationSettingsBottomSheet> createState() =>
      _NotificationSettingsBottomSheetState();

  /// Static method to show the modal
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      builder: (context) =>
          const NotificationSettingsBottomSheet(),
    );
  }
}

class _NotificationSettingsBottomSheetState
    extends State<NotificationSettingsBottomSheet> {
  // Local state for switches
  bool _messagesEnabled = true;
  bool _notificationsEnabled = true;

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
        children: [
          // ═══════════════════════════════════════════════
          // DRAG HANDLE INDICATOR
          // ═══════════════════════════════════════════════
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 20.h,
              ),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // HEADER: Back Arrow + Title
          // ═══════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24.w,
                    color: Colors.black87,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Notification Setting',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // ═══════════════════════════════════════════════
          // NOTIFICATION OPTIONS
          // ═══════════════════════════════════════════════

          // Messages Option
          _buildNotificationOption(
            iconPath: ImgAssets.icChat,
            title: 'Messages',
            value: _messagesEnabled,
            onChanged: (value) {
              setState(() {
                _messagesEnabled = value;
              });
            },
          ),

          // Divider
          Divider(
            thickness: 1,
            color: Colors.grey.withValues(alpha: 0.2),
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),

          // Notifications Option
          _buildNotificationOption(
            iconPath: ImgAssets.icNotification,
            title: 'Notifications',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Helper widget for notification toggle options
  Widget _buildNotificationOption({
    required String iconPath,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Row(
        children: [
          // Icon (SVG Asset)
          SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 16.w),
          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Switch
          Switch(
            value: value,
            onChanged: onChanged,

            activeTrackColor: MyColors.greenButton
                .withValues(alpha: 0.5),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
