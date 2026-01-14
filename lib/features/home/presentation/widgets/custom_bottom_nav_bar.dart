import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 70.h,
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
        context.read<HomeCubit>().changeBottomNavIndex(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active Top Border
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: isActive
                    ? MyColors.greenButton
                    : Colors.transparent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // Icon
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? MyColors.greenButton
                  : MyColors.greyText,
              size: 24.w,
            ),

            SizedBox(height: 4.h),

            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? MyColors.greenButton
                    : MyColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
