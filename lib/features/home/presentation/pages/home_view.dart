import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/features/home/presentation/widgets/home_header.dart';
import 'package:sportify_app/features/home/presentation/widgets/match_result_slider.dart';
import 'package:sportify_app/features/home/presentation/widgets/home_category_card.dart';
import 'package:sportify_app/features/home/presentation/widgets/nearby_match_card.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class HomeView extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const HomeView({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backGround,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              HomeHeader(onMenuTap: onMenuTap),

              SizedBox(height: 16.h),

              // Match Result Slider
              const MatchResultSlider(),

              SizedBox(height: 24.h),

              // Categories
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: HomeCategoryCard(
                        image: ImgAssets.stadiumsCategory,
                        title: 'stadiums'.tr(context),
                        onTap: () {
                          context.read<HomeCubit>().changeBottomNavIndex(3);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: HomeCategoryCard(
                        image: ImgAssets.matchesCategory,
                        title: 'matches'.tr(context),
                        onTap: () {
                          context.read<HomeCubit>().changeBottomNavIndex(4);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: HomeCategoryCard(
                        image:
                            ImgAssets.tournamentsCategory,
                        title: 'tournaments'.tr(context),
                        onTap: () {
                          context.push(
                            Routes.tournamentsListRoute,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Matches Near You Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'matches_near_you'.tr(context),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'view_all'.tr(context),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: MyColors.greenButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Matches List (Always Show Mock Data)
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // Force show matches - UI Layer Only
                  return ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    itemCount: state.nearbyMatches.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      return NearbyMatchCard(
                        match: state.nearbyMatches[index],
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
