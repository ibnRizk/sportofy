import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
            boxShadow: [
              BoxShadow(
                color: MyColors.black.withValues(alpha: AppDimens.opacity05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: AppDimens.bottomNavBarHeight + AppDimens.h10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context: context,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'home'.tr(context),
                    index: 0,
                    isActive: state.currentNavIndex == 0,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.store_outlined,
                    activeIcon: Icons.store,
                    label: 'market'.tr(context),
                    index: 1,
                    isActive: state.currentNavIndex == 1,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.people_outline,
                    activeIcon: Icons.people,
                    label: 'community'.tr(context),
                    index: 2,
                    isActive: state.currentNavIndex == 2,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.stadium_outlined,
                    activeIcon: Icons.stadium,
                    label: 'stadiums'.tr(context),
                    index: 3,
                    isActive: state.currentNavIndex == 3,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.sports_soccer_outlined,
                    activeIcon: Icons.sports_soccer,
                    label: 'matches'.tr(context),
                    index: 4,
                    isActive: state.currentNavIndex == 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().changeBottomNavIndex(
          index,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: AppPadding.h12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active Top Border
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: AppDimens.h3,
              width: AppDimens.w40,
              decoration: BoxDecoration(
                color: isActive
                    ? MyColors.greenButton
                    : MyColors.transparent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppDimens.w2),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h8),

            // Icon
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? MyColors.greenButton
                  : MyColors.greyText,
              size: AppDimens.iconSize24,
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
            ),
          ],
        ),
      ),
    );
  }
}
