import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const HomeHeader({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      child: Row(
        children: [
          // User Avatar (Opens Drawer)
          GestureDetector(
            onTap: onMenuTap,
            child: CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(
                ImgAssets.userAvatar,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Location Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my_location'.tr(context),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: MyColors.greyText,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Hadyek Elmaadi',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colors.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18.w,
                      color: context.colors.textColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          // Notification Icon
          GestureDetector(
            onTap: () {
              context.push(Routes.notificationsRoute);
            },
            child: SvgPicture.asset(
              ImgAssets.icNotification,
              width: 24.w,
              height: 24.h,
            ),
          ),

          SizedBox(width: 1.w),

          // Chat Icon
          IconButton(
            onPressed: () {
              context.push(Routes.chatsRoute);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImgAssets.icChat,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}
