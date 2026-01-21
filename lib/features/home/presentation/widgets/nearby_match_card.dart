import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/home/domain/entities/match_entity.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/injection_container.dart';

class NearbyMatchCard extends StatelessWidget {
  final MatchEntity match;

  const NearbyMatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final progressPercentage =
        match.currentPlayers / match.totalPlayers;

    return InkWell(
      onTap: () {
        // Navigate to matches screen in bottom navigation bar (index 4)
        context.read<HomeCubit>().changeBottomNavIndex(4);
      },
      borderRadius: AppRadius.r12,
      child: Container(
        padding: AppPadding.p16,
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: AppRadius.r12,
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withValues(
                alpha: AppDimens.opacity05,
              ),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ═══════════════════════════════════════════════
            // SECTION 1: LEFT SIDE (ORGANIZER)
            // ═══════════════════════════════════════════════
            SizedBox(
              width: AppDimens.containerWidth120,
              child: Column(
                children: [
                  // Organizer Avatar
                  Container(
                    width: AppDimens.avatarSize40,
                    height: AppDimens.avatarSize40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          match.organizerAvatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimens.h8),

                  // Organizer Name
                  Text(
                    match.organizerName,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold12(
                      color: MyColors.darkGrayColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: AppDimens.h4),

                  // Organizer Label
                  Text(
                    'organizer'.tr(context),
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.greenButton,
                    ),
                  ),

                  SizedBox(height: AppDimens.h12),

                  // Overlapping Participant Avatars
                  _buildParticipantStack(),
                ],
              ),
            ),

            SizedBox(width: AppDimens.w16),

            // ═══════════════════════════════════════════════
            // SECTION 2: RIGHT SIDE (DETAILS)
            // ═══════════════════════════════════════════════
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // ─────────────────────────────────────────
                  // A. PROGRESS SECTION (TOP)
                  // ─────────────────────────────────────────
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      Text(
                        '${match.currentPlayers} ${'out_of'.tr(context)} ${match.totalPlayers}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.greyText,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimens.h6),

                  // Custom Progress Bar with Gradient
                  _buildCustomProgressBar(
                    progressPercentage,
                  ),

                  SizedBox(height: AppDimens.h16),

                  // ─────────────────────────────────────────
                  // B. INFO & ACTION SECTION (THE SPLIT)
                  // ─────────────────────────────────────────
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      // ─── LEFT: INFO COLUMN ───
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // Stadium Row
                            Row(
                              children: [
                                _buildSvgIcon(
                                  iconPath:
                                      ImgAssets.icStadium,
                                  size:
                                      AppDimens.iconSize16,
                                ),
                                SizedBox(
                                  width: AppDimens.w6,
                                ),
                                Expanded(
                                  child: Text(
                                    match.stadiumName,
                                    style:
                                        TextStyles.regular12(
                                          color: MyColors
                                              .darkGrayColor,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow
                                        .ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: AppDimens.h14),

                            // Date Row
                            Row(
                              children: [
                                _buildSvgIcon(
                                  iconPath:
                                      ImgAssets.icCalendar,
                                  size:
                                      AppDimens.iconSize16,
                                ),
                                SizedBox(
                                  width: AppDimens.w6,
                                ),
                                Text(
                                  match.date,
                                  style:
                                      TextStyles.regular12(
                                        color: MyColors
                                            .darkGrayColor,
                                      ),
                                ),
                              ],
                            ),

                            SizedBox(height: AppDimens.h14),

                            // Time Row
                            Row(
                              children: [
                                _buildSvgIcon(
                                  iconPath:
                                      ImgAssets.icClock,
                                  size:
                                      AppDimens.iconSize16,
                                ),
                                SizedBox(
                                  width: AppDimens.w6,
                                ),
                                Text(
                                  match.time,
                                  style:
                                      TextStyles.regular12(
                                        color: MyColors
                                            .darkGrayColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: AppDimens.w12),

                      // ─── RIGHT: PRICE & BUTTON COLUMN ───
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Price
                          Text(
                            '${match.price.toStringAsFixed(2)} ${'egp'.tr(context)}',
                            style: TextStyles.bold18(
                              color: MyColors.greenButton,
                            ).copyWith(height: 1.2),
                          ),

                          SizedBox(height: AppDimens.h8),

                          // Join Button
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent,
                              side: BorderSide(
                                color: MyColors.grey700,
                                width:
                                    AppDimens.borderWidth1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppRadius.r8,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.w12,
                                vertical: AppDimens.h6,
                              ),
                              minimumSize: Size(0, 0),
                              tapTargetSize:
                                  MaterialTapTargetSize
                                      .shrinkWrap,
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text(
                                  'join_now'.tr(context),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight:
                                        FontWeight.w500,
                                    color: MyColors
                                        .darkGrayColor,
                                  ),
                                ),
                                SizedBox(
                                  width: AppDimens.w4,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10.sp,
                                  color: MyColors
                                      .darkGrayColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // CUSTOM PROGRESS BAR WITH GRADIENT
  // ═══════════════════════════════════════════════
  Widget _buildCustomProgressBar(double progress) {
    return Column(
      children: [
        // Progress Bar Container
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 6.h, // Thin height (4-6px)
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.grey300.withValues(
                alpha: 0.3,
              ), // Light grey/green opacity background
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              children: [
                // Progress Fill with Gradient
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyColors
                              .main, // Teal/Cyan start (0xff00A9B8)
                          MyColors
                              .greenButton, // Primary Green end (0xFF4CAF50)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  // SVG ICON BUILDER
  // ═══════════════════════════════════════════════
  Widget _buildSvgIcon({
    required String iconPath,
    required double size,
  }) {
    try {
      return SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          MyColors.greyText, // Light Grey color
          BlendMode.srcIn,
        ),
      );
    } catch (e) {
      // Fallback to Material icon if SVG fails
      debugPrint('Failed to load SVG: $iconPath');
      IconData fallbackIcon;
      if (iconPath == ImgAssets.icStadium) {
        fallbackIcon = Icons.stadium_outlined;
      } else if (iconPath == ImgAssets.icCalendar) {
        fallbackIcon = Icons.calendar_today_outlined;
      } else if (iconPath == ImgAssets.icClock) {
        fallbackIcon = Icons.access_time_outlined;
      } else {
        fallbackIcon = Icons.circle;
      }
      return Icon(
        fallbackIcon,
        size: size,
        color: MyColors.greyText,
      );
    }
  }

  // ═══════════════════════════════════════════════
  // OVERLAPPING AVATARS STACK
  // ═══════════════════════════════════════════════
  Widget _buildParticipantStack() {
    // Calculate how many avatars to show (max 3 visible + count badge)
    final visibleAvatars =
        match.participantAvatars.length > 3
        ? 3
        : match.participantAvatars.length;
    final remainingCount =
        match.participantAvatars.length > 3
        ? match.participantAvatars.length - 3
        : 0;

    return SizedBox(
      height: AppDimens.avatarSize32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Show visible avatars
          ...List.generate(visibleAvatars, (index) {
            return Positioned(
              left: index * AppDimens.w20,
              child: Container(
                width: AppDimens.avatarSize32,
                height: AppDimens.avatarSize32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors.white,
                    width: AppDimens.borderWidth2,
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      match.participantAvatars[index],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),

          // Show count badge if there are more participants
          if (remainingCount > 0)
            Positioned(
              left: visibleAvatars * AppDimens.w20,
              child: Container(
                width: AppDimens.avatarSize32,
                height: AppDimens.avatarSize32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.grey800,
                  border: Border.all(
                    color: MyColors.white,
                    width: AppDimens.borderWidth2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyles.bold10(
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
