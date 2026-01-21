import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity05,
            ),
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
                style: TextStyles.semiBold16(
                  color: MyColors.black87,
                ),
              ),
              const Spacer(),
              _buildStatusBadge(statusLabel),
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
                      iconSvg: ImgAssets.icStadium,
                      text: stadiumName,
                    ),
                    SizedBox(height: AppDimens.h8),
                    _InfoRow(
                      iconSvg: ImgAssets.icClock,
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
                      iconSvg: ImgAssets.icCalendar,
                      text: date,
                    ),
                    SizedBox(height: AppDimens.h8),
                    _InfoRow(
                      iconSvg: ImgAssets.icTimer,
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
            color: MyColors.grey.withValues(
              alpha: AppDimens.opacity2,
            ),
          ),

          SizedBox(height: AppDimens.h12),

          // Footer Row (Date + Action Button)
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                footerDate,
                style: TextStyles.regular13(
                  color: MyColors.darkGrayColor,
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

  // Helper method to build status badge with pastel colors
  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'open':
      case 'reserved':
        bgColor = const Color(0xFFE3F2FD); // Light Blue
        textColor = MyColors.blue;
        break;
      case 'locked':
        bgColor = const Color(0xFFFFEBEE); // Light Red
        textColor = MyColors.red700;
        break;
      case 'pending':
        bgColor = const Color(0xFFFFF3E0); // Light Orange
        textColor = MyColors.orange;
        break;
      case 'finished':
        bgColor = const Color(0xFFE8F5E9); // Light Green
        textColor = MyColors.green;
        break;
      default:
        bgColor = MyColors.grey200;
        textColor = MyColors.grey700;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

/// Info row helper widget
class _InfoRow extends StatelessWidget {
  final String iconSvg;
  final String text;

  const _InfoRow({
    required this.iconSvg,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconSvg,
          width: AppDimens.iconSize16,
          height: AppDimens.iconSize16,
          colorFilter: ColorFilter.mode(
            MyColors
                .darkGrayColor, // Grey icons (no red/blue tint)
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: AppDimens.w6),
        Expanded(
          child: Text(
            text,
            style: TextStyles.regular13(
              color: MyColors.grey700,
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
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: MyColors.darkGrayColor,
        side: BorderSide(
          color: MyColors.darkGrayColor,
          width: 1, // Thin grey border (NOT black)
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 38.w,
          vertical: 8.h,
        ),
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showResellIcon) ...[
            SvgPicture.asset(
              ImgAssets
                  .icMenuActivity, // Using activity icon as refresh alternative, or we can add a refresh icon
              width: AppDimens.iconSize16,
              height: AppDimens.iconSize16,
              colorFilter: ColorFilter.mode(
                MyColors.darkGrayColor, // Grey icon
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: AppDimens.w6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color:
                  MyColors.darkGrayColor, // Dark grey text
            ),
          ),
        ],
      ),
    );
  }
}
