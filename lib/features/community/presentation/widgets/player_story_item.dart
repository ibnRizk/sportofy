import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class PlayerStoryItem extends StatelessWidget {
  final String name;
  final String avatar;

  const PlayerStoryItem({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with Online Indicator
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: AppDimens.avatarSize35,
              backgroundImage: AssetImage(avatar),
            ),
            // Green Online Indicator
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: AppDimens.badgeSize16,
                height: AppDimens.badgeSize16,
                decoration: BoxDecoration(
                  color: MyColors.greenButton,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors.white,
                    width: AppDimens.borderWidth2,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimens.h8),
        // Name
        Text(
          name,
          style: TextStyles.medium12(
            color: MyColors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
