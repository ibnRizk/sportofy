import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

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
        color: MyColors.white,
        borderRadius: AppRadius.top25,
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
              margin: AppPadding.top12.copyWith(
                bottom: AppDimens.h8,
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
          // CONTENT PADDING
          // ═══════════════════════════════════════════════
          Padding(
            padding: AppPadding.h20.copyWith(
              bottom:
                  MediaQuery.of(context).viewInsets.bottom +
                  AppDimens.h20,
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
                        size: AppDimens.iconSize24,
                        color: MyColors.black87,
                      ),
                    ),
                    SizedBox(width: AppDimens.w16),
                    Text(
                      'Contact Info',
                      style: TextStyles.semiBold18(
                        color: MyColors.black87,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimens.h32),

                // Email Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: email,
                ),

                SizedBox(height: AppDimens.h28),

                // Phone Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: phone,
                ),

                SizedBox(height: AppDimens.h28),

                // Connected Section
                _buildInfoRow(
                  context: context,
                  icon: Icons.link,
                  label: 'Connected',
                  value: connectedDate,
                ),

                SizedBox(height: AppDimens.h20),
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
          width: AppDimens.containerHeight40,
          height: AppDimens.containerHeight40,
          decoration: BoxDecoration(
            color: MyColors.grey.withValues(
              alpha: AppDimens.opacity1,
            ),
            borderRadius: AppRadius.r8,
          ),
          child: Icon(
            icon,
            size: AppDimens.iconSize20,
            color: MyColors.black54,
          ),
        ),

        SizedBox(width: AppDimens.w16),

        // Label + Value Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.medium16(
                  color: MyColors.darkGrayColor,
                ),
              ),
              SizedBox(height: AppDimens.h6),
              Text(
                value,
                style: TextStyles.regular14(
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
      backgroundColor: MyColors.transparent,
      isScrollControlled: true,
      enableDrag: true, // ✅ Allow drag to dismiss
      isDismissible: true, // ✅ Allow tap outside to dismiss
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.top25,
      ),
      builder: (context) => ContactInfoBottomSheet(
        email: email,
        phone: phone,
        connectedDate: connectedDate,
      ),
    );
  }
}
