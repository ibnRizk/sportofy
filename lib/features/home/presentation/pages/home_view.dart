import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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

              SizedBox(height: AppDimens.h16),

              // Match Result Slider - Full Width Edge-to-Edge
              const MatchResultSlider(),

              SizedBox(height: AppDimens.h14),

              // Categories
              Padding(
                padding: AppPadding.h16,
                child: Row(
                  children: [
                    Expanded(
                      child: HomeCategoryCard(
                        image: ImgAssets.stadiumsCategory,
                        title: 'stadiums'.tr(context),
                        onTap: () {
                          context
                              .read<HomeCubit>()
                              .changeBottomNavIndex(3);
                        },
                      ),
                    ),
                    SizedBox(width: AppDimens.w12),
                    Expanded(
                      child: HomeCategoryCard(
                        image: ImgAssets.matchesCategory,
                        title: 'matches'.tr(context),
                        onTap: () {
                          context
                              .read<HomeCubit>()
                              .changeBottomNavIndex(4);
                        },
                      ),
                    ),
                    SizedBox(width: AppDimens.w12),
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

              SizedBox(height: AppDimens.h8),

              // Matches Near You Section
              Padding(
                padding: AppPadding.h16,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'matches_near_you'.tr(context),
                      style: TextStyles.semiBold16(
                        color: context.colors.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<HomeCubit>()
                            .changeBottomNavIndex(4);
                      },
                      child: Text(
                        'view_all'.tr(context),
                        style: TextStyles.medium12(
                          color: MyColors.greenButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppDimens.h4),

              // Matches List (Always Show Mock Data)
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // Force show matches - UI Layer Only
                  return ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    padding: AppPadding.h16,
                    itemCount: state.nearbyMatches.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppDimens.h16),
                    itemBuilder: (context, index) {
                      return NearbyMatchCard(
                        match: state.nearbyMatches[index],
                      );
                    },
                  );
                },
              ),

              SizedBox(height: AppDimens.h12),
            ],
          ),
        ),
      ),
    );
  }
}
