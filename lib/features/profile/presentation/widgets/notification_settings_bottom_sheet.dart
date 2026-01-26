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
      elevation: 0, // Remove elevation/shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r), // More sharp
          topRight: Radius.circular(12.r), // More sharp
        ),
      ),
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height *
            0.3, // Minimize size
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
          topLeft: Radius.circular(12.r), // More sharp
          topRight: Radius.circular(12.r), // More sharp
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ═══════════════════════════════════════════════
            // DRAG HANDLE INDICATOR
            // ═══════════════════════════════════════════════
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 6.h,
                  bottom: 12.h,
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 20.w, // Reduced size
                      color: Colors.black87,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 8.w), // Reduced spacing
                  Expanded(
                    child: Text(
                      'Notification Setting',
                      style: TextStyle(
                        fontSize:
                            16.sp, // Reduced font size
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h), // Reduced spacing
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
              indent: 20.w,
              endIndent: 20.w,
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

            // Bottom padding for safe area
            SizedBox(
              height:
                  MediaQuery.of(context).padding.bottom +
                  12.h, // Reduced padding
            ),
          ],
        ),
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
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 12.h, // Reduced padding
        ),
        child: Row(
          children: [
            // Icon (Simple, no background - like photo)
            SvgPicture.asset(
              iconPath,
              width: 20.w, // Reduced icon size
              height: 20.h, // Reduced icon size
              colorFilter: ColorFilter.mode(
                Colors.grey[700]!, // Dark gray like photo
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w), // Reduced spacing
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp, // Reduced font size
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800], // Dark gray text
                ),
              ),
            ),
            // Custom Switch (Minimized size, like photo - white thumb moves inside)
            GestureDetector(
              onTap: () => onChanged(!value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 44.w, // Minimized width
                height: 24.h, // Minimized height
                decoration: BoxDecoration(
                  color: value
                      ? MyColors.greenButton
                      : Colors
                            .grey[300]!, // Green track when active, gray when inactive
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Stack(
                  children: [
                    // White Thumb (moves from left to right)
                    AnimatedPositioned(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      curve: Curves.easeInOut,
                      left: value
                          ? 22.w
                          : 2.w, // Move to right when ON, left when OFF
                      top: 2.h,
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        width: 20.w, // Minimized thumb size
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // White interior (always white)
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: value
                                ? MyColors.greenButton
                                : Colors
                                      .transparent, // Green border when active
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
