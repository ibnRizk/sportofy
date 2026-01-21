import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
      margin: AppPadding.bottom16,
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity05),
            blurRadius: AppDimens.elevation8,
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
                radius: AppDimens.avatarSize20,
                backgroundImage: userImage != null
                    ? AssetImage(userImage!)
                    : AssetImage(ImgAssets.userAvatar),
              ),
              SizedBox(width: AppDimens.w12),
              Text(
                userName,
                style: TextStyles.semiBold16(color: MyColors.black87),
              ),
              const Spacer(),
              Container(
                padding: AppPadding.h12v6,
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: AppRadius.r6,
                ),
                child: Text(
                  statusLabel,
                  style: TextStyles.medium12(color: statusTextColor),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

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
                    SizedBox(height: AppDimens.h8),
                    _InfoRow(
                      icon: Icons.access_time,
                      text: time,
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppDimens.w16),
              // Column 2
              Expanded(
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: date,
                    ),
                    SizedBox(height: AppDimens.h8),
                    _InfoRow(
                      icon: Icons.timer_outlined,
                      text: duration,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Divider
          Divider(
            height: AppDimens.dividerThickness1,
            thickness: AppDimens.dividerThickness1,
            color: MyColors.grey.withValues(alpha: AppDimens.opacity2),
          ),

          SizedBox(height: AppDimens.h12),

          // Footer Row (Date + Action Button)
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                footerDate,
                style: TextStyles.regular13(color: MyColors.grey600),
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
        Icon(icon, size: AppDimens.iconSize16, color: MyColors.grey600),
        SizedBox(width: AppDimens.w6),
        Expanded(
          child: Text(
            text,
            style: TextStyles.regular13(color: MyColors.grey700),
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
      borderRadius: AppRadius.r8,
      child: Container(
        padding: AppPadding.h16v8,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.r8,
          border: Border.all(
            color: MyColors.grey300,
            width: AppDimens.borderWidth1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showResellIcon) ...[
              Icon(
                Icons.refresh,
                size: AppDimens.iconSize16,
                color: MyColors.black87,
              ),
              SizedBox(width: AppDimens.w6),
            ],
            Text(
              text,
              style: TextStyles.medium14(color: MyColors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
