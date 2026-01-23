import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/profile/presentation/widgets/notification_settings_bottom_sheet.dart';

class AccountSettingsBottomSheet extends StatelessWidget {
  const AccountSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top25,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ═══════════════════════════════════════════════
          // DRAG HANDLE INDICATOR
          // ═══════════════════════════════════════════════
          Center(
            child: Container(
              margin: AppPadding.top10.copyWith(
                bottom: AppDimens.h20,
              ),
              width: AppDimens.w40,
              height: AppDimens.h4,
              decoration: BoxDecoration(
                color: MyColors.grey.withValues(
                  alpha: AppDimens.opacity3,
                ),
                borderRadius: AppRadius.r2,
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // SECTION A: QUICK ACTIONS (4 Items Row)
          // ═══════════════════════════════════════════════
          Padding(
            padding: AppPadding.h20,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                _buildQuickActionItem(
                  icon: Icons.edit_outlined,
                  label: 'Edit Account',
                  iconColor: MyColors.darkGrayColor,
                  borderColor: MyColors.grey.withValues(
                    alpha: AppDimens.opacity4,
                  ),
                  textColor: MyColors.darkGrayColor,
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
                  iconColor: MyColors.black87,
                  borderColor: MyColors.grey.withValues(
                    alpha: AppDimens.opacity4,
                  ),
                  textColor: MyColors.black87,
                  onTap: () {
                    // TODO: Implement Share Account
                  },
                ),
                _buildQuickActionItem(
                  icon: Icons.link,
                  label: 'Account Link',
                  iconColor: MyColors.black87,
                  borderColor: MyColors.grey.withValues(
                    alpha: AppDimens.opacity4,
                  ),
                  textColor: MyColors.black87,
                  onTap: () {
                    // TODO: Implement Account Link
                  },
                ),
                _buildQuickActionItem(
                  icon: Icons.delete_outline,
                  label: 'Delete Account',
                  iconColor: MyColors.red,
                  borderColor: MyColors.red,
                  textColor: MyColors.red,
                  onTap: () {
                    // TODO: Show Delete Account Confirmation
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: AppDimens.h20),

          // ═══════════════════════════════════════════════
          // DIVIDER 1
          // ═══════════════════════════════════════════════
          Divider(
            thickness: AppDimens.dividerThickness1,
            color: MyColors.grey.withValues(
              alpha: AppDimens.opacity2,
            ),
            height: AppDimens.dividerThickness1,
          ),

          // ═══════════════════════════════════════════════
          // SECTION B: NOTIFICATION SETTING
          // ═══════════════════════════════════════════════
          InkWell(
            onTap: () {
              // Get the root navigator context BEFORE popping
              final rootNavigator = Navigator.of(
                context,
                rootNavigator: true,
              );

              // Close current sheet
              Navigator.of(context).pop();

              // Show new sheet using root navigator's context after a delay
              Future.delayed(
                const Duration(milliseconds: 250),
                () {
                  showModalBottomSheet(
                    context: rootNavigator.context,
                    backgroundColor: MyColors.transparent,
                    isScrollControlled: true,
                    enableDrag: true,
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.top25,
                    ),
                    builder: (ctx) =>
                        const NotificationSettingsBottomSheet(),
                  );
                },
              );
            },
            child: Padding(
              padding: AppPadding.h20v16,
              child: Row(
                children: [
                  SvgPicture.asset(
                    ImgAssets.icNotification,
                  ),
                  SizedBox(width: AppDimens.w16),
                  Text(
                    'Notification Setting',
                    style: TextStyles.regular14(
                      color: MyColors.darkGrayColor,
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
            thickness: AppDimens.dividerThickness1,
            color: MyColors.grey.withValues(
              alpha: AppDimens.opacity2,
            ),
            height: AppDimens.dividerThickness1,
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
              padding: AppPadding.h20v16,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: AppDimens.iconSize24,
                    color: MyColors.red,
                  ),
                  SizedBox(width: AppDimens.w16),
                  Text(
                    'Logout',
                    style: TextStyles.medium16(
                      color: MyColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: AppDimens.h20),
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
      borderRadius: AppRadius.r50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Icon Container
          Container(
            width: AppDimens.containerHeight56,
            height: AppDimens.containerHeight56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: AppDimens.borderWidth2,
              ),
            ),
            child: Icon(
              icon,
              size: AppDimens.iconSize24,
              color: iconColor,
            ),
          ),
          SizedBox(height: AppDimens.h8),
          // Label Text
          SizedBox(
            width: AppDimens.w70,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyles.regular10(color: textColor),
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
      backgroundColor: MyColors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.top25,
      ),
      builder: (context) =>
          const AccountSettingsBottomSheet(),
    );
  }
}
