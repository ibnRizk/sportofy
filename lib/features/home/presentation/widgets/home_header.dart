import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const HomeHeader({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white, // White background
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.w16,
        vertical: AppDimens.h12,
      ),
      child: Row(
        children: [
          // User Avatar (Opens Drawer)
          GestureDetector(
            onTap: onMenuTap,
            child: CircleAvatar(
              radius: AppDimens.avatarSize24,
              backgroundImage: AssetImage(
                ImgAssets.userAvatar,
              ),
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Location Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my_location'.tr(context),
                  style: TextStyles.regular12(
                    color: MyColors.greyText,
                  ),
                ),
                SizedBox(height: AppDimens.h2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Hadyek Elmaadi',
                        style: TextStyles.semiBold14(
                          color: context.colors.textColor,
                        ),
                        overflow: TextOverflow
                            .visible, // Show full text
                      ),
                    ),
                    SizedBox(width: AppDimens.w4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: AppDimens.iconSize18,
                      color: context.colors.textColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Notification Icon
          GestureDetector(
            onTap: () {
              context.push(Routes.notificationsRoute);
            },
            child: SvgPicture.asset(
              ImgAssets.icNotification,
              width: AppDimens.iconSize24,
              height: AppDimens.iconSize24,
            ),
          ),

          SizedBox(width: AppDimens.w1),

          // Chat Icon
          IconButton(
            onPressed: () {
              context.push(Routes.chatsRoute);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImgAssets.icChat,
              width: AppDimens.iconSize24,
              height: AppDimens.iconSize24,
            ),
          ),
        ],
      ),
    );
  }
}
