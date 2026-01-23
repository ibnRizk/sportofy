import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String selectedPrivacy;
  final VoidCallback onPrivacyTap;

  const UserHeader({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.selectedPrivacy,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: AppDimens.avatarSize25,
          backgroundImage: AssetImage(userAvatar),
        ),
        SizedBox(width: AppDimens.w12),
        // Name and Privacy Dropdown
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: TextStyles.medium14(
                  color: MyColors.darkGrayColor,
                ),
              ),
              SizedBox(height: AppDimens.h8),
              // Privacy Dropdown
              GestureDetector(
                onTap: onPrivacyTap,
                child: Container(
                  padding: AppPadding.h12v6,
                  decoration: BoxDecoration(
                    color: MyColors.grey100,
                    borderRadius: AppRadius.r20,
                    border: Border.all(
                      color: MyColors.grey300,
                      width: AppDimens.borderWidth1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people,
                        size: AppDimens.iconSize16,
                        color: MyColors.greenButton,
                      ),
                      SizedBox(width: AppDimens.w6),
                      Text(
                        selectedPrivacy,
                        style: TextStyles.medium13(
                          color: MyColors.black87,
                        ),
                      ),
                      SizedBox(width: AppDimens.w4),
                      Icon(
                        Icons.arrow_drop_down,
                        size: AppDimens.iconSize18,
                        color: MyColors.grey600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
