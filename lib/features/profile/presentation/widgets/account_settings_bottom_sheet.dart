import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/features/profile/presentation/widgets/notification_settings_bottom_sheet.dart';

class AccountSettingsBottomSheet extends StatelessWidget {
  const AccountSettingsBottomSheet({super.key});

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
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // SECTION A: QUICK ACTIONS (4 Items Row)
          // ═══════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickActionItem(
                  icon: Icons.edit_outlined,
                  label: 'Edit Account',
                  iconColor: Colors.black87,
                  borderColor: Colors.grey.withOpacity(0.4),
                  textColor: Colors.black87,
                  onTap: () {
                    // Close current sheet
                    context.pop();
                    // Navigate to Edit Profile
                    context.push(Routes.editProfileRoute);
                  },
                ),
                _buildQuickActionItem(
                  icon: Icons.share_outlined,
                  label: 'Share Account',
                  iconColor: Colors.black87,
                  borderColor: Colors.grey.withOpacity(0.4),
                  textColor: Colors.black87,
                  onTap: () {
                    // TODO: Implement Share Account
                  },
                ),
                _buildQuickActionItem(
                  icon: Icons.link,
                  label: 'Account Link',
                  iconColor: Colors.black87,
                  borderColor: Colors.grey.withOpacity(0.4),
                  textColor: Colors.black87,
                  onTap: () {
                    // TODO: Implement Account Link
                  },
                ),
                _buildQuickActionItem(
                  icon: Icons.delete_outline,
                  label: 'Delete Account',
                  iconColor: Colors.red,
                  borderColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    // TODO: Show Delete Account Confirmation
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // ═══════════════════════════════════════════════
          // DIVIDER 1
          // ═══════════════════════════════════════════════
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.2),
            height: 1,
          ),

          // ═══════════════════════════════════════════════
          // SECTION B: NOTIFICATION SETTING
          // ═══════════════════════════════════════════════
          InkWell(
            onTap: () {
              // Get the root navigator context BEFORE popping
              final rootNavigator = Navigator.of(context, rootNavigator: true);
              
              // Close current sheet
              Navigator.of(context).pop();
              
              // Show new sheet using root navigator's context after a delay
              Future.delayed(const Duration(milliseconds: 250), () {
                showModalBottomSheet(
                  context: rootNavigator.context,
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
                  builder: (ctx) => const NotificationSettingsBottomSheet(),
                );
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 24.w,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Notification Setting',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // DIVIDER 2
          // ═══════════════════════════════════════════════
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.2),
            height: 1,
          ),

          // ═══════════════════════════════════════════════
          // SECTION C: LOGOUT
          // ═══════════════════════════════════════════════
          InkWell(
            onTap: () {
              // TODO: Implement Logout Logic
              context.pop();
              // Show logout confirmation or proceed with logout
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 24.w,
                    color: Colors.red,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Helper widget for Quick Action Items
  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Icon Container
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 24.w,
              color: iconColor,
            ),
          ),
          SizedBox(height: 8.h),
          // Label Text
          SizedBox(
            width: 70.w,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

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
      builder: (context) => const AccountSettingsBottomSheet(),
    );
  }
}
