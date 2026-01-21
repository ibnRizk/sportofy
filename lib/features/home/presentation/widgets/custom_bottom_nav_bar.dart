import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: AppRadius.top20, // Rounded corners only on top
            boxShadow: [
              BoxShadow(
                color: MyColors.black.withValues(alpha: AppDimens.opacity05),
                blurRadius: 10,
                offset: const Offset(0, -2), // Shadow at the top (floating effect)
                spreadRadius: 0,
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green Indicator Line - Absolute Top Edge
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppDimens.h3, // 3px height
                        decoration: BoxDecoration(
                          color: state.currentNavIndex == 0
                              ? MyColors.greenButton
                              : MyColors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r), // Match container top radius
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppDimens.h3,
                        color: state.currentNavIndex == 1
                            ? MyColors.greenButton
                            : MyColors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppDimens.h3,
                        color: state.currentNavIndex == 2
                            ? MyColors.greenButton
                            : MyColors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppDimens.h3,
                        color: state.currentNavIndex == 3
                            ? MyColors.greenButton
                            : MyColors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppDimens.h3,
                        decoration: BoxDecoration(
                          color: state.currentNavIndex == 4
                              ? MyColors.greenButton
                              : MyColors.transparent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r), // Match container top radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Navigation Items Row
                SizedBox(
                  height: AppDimens.bottomNavBarHeight,
                  child: Row(
                    children: [
                      _buildNavItem(
                        context: context,
                        iconPath: ImgAssets.icHome,
                        label: 'home'.tr(context),
                        index: 0,
                        isActive: state.currentNavIndex == 0,
                      ),
                      _buildNavItem(
                        context: context,
                        iconPath: ImgAssets.icMarket,
                        label: 'market'.tr(context),
                        index: 1,
                        isActive: state.currentNavIndex == 1,
                      ),
                      _buildNavItem(
                        context: context,
                        iconPath: ImgAssets.icCommunity,
                        label: 'community'.tr(context),
                        index: 2,
                        isActive: state.currentNavIndex == 2,
                      ),
                      _buildNavItem(
                        context: context,
                        iconPath: ImgAssets.icStadiums,
                        label: 'stadiums'.tr(context),
                        index: 3,
                        isActive: state.currentNavIndex == 3,
                      ),
                      _buildNavItem(
                        context: context,
                        iconPath: ImgAssets.icMatches,
                        label: 'matches'.tr(context),
                        index: 4,
                        isActive: state.currentNavIndex == 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String iconPath,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<HomeCubit>().changeBottomNavIndex(
            index,
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.w8,
            vertical: AppDimens.h8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Icon with fallback
              _buildIcon(
                iconPath: iconPath,
                isActive: isActive,
              ),

              SizedBox(height: AppDimens.h4),

              // Label
              Text(
                label,
                style: isActive
                    ? TextStyles.semiBold11(
                        color: MyColors.greenButton,
                      )
                    : TextStyles.regular11(
                        color: MyColors.greyText,
                      ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon({
    required String iconPath,
    required bool isActive,
  }) {
    return Builder(
      builder: (context) {
        try {
          return SvgPicture.asset(
            iconPath,
            width: AppDimens.iconSize24,
            height: AppDimens.iconSize24,
            colorFilter: ColorFilter.mode(
              isActive ? MyColors.greenButton : MyColors.greyText,
              BlendMode.srcIn,
            ),
          );
        } catch (e) {
          // Fallback to Material icon if SVG fails to load
          debugPrint('Failed to load SVG: $iconPath, using fallback icon');
          IconData fallbackIcon;
          switch (iconPath) {
            case ImgAssets.icHome:
              fallbackIcon = isActive ? Icons.home : Icons.home_outlined;
              break;
            case ImgAssets.icMarket:
              fallbackIcon = isActive ? Icons.store : Icons.store_outlined;
              break;
            case ImgAssets.icCommunity:
              fallbackIcon = isActive ? Icons.people : Icons.people_outline;
              break;
            case ImgAssets.icStadiums:
              fallbackIcon = isActive ? Icons.stadium : Icons.stadium_outlined;
              break;
            case ImgAssets.icMatches:
              fallbackIcon =
                  isActive ? Icons.sports_soccer : Icons.sports_soccer_outlined;
              break;
            default:
              fallbackIcon = Icons.circle;
          }
          return Icon(
            fallbackIcon,
            size: AppDimens.iconSize24,
            color: isActive ? MyColors.greenButton : MyColors.greyText,
          );
        }
      },
    );
  }
}
