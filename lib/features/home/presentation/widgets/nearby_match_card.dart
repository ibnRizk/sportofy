import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
            width: 100.w,
            child: Column(
              children: [
                // Organizer Avatar
                Container(
                  width: 40.w,
                  height: 40.h,
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

                SizedBox(height: 8.h),

                // Organizer Name
                Text(
                  match.organizerName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 4.h),

                // Organizer Label
                Text(
                  'organizer'.tr(context),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.greenButton,
                  ),
                ),

                SizedBox(height: 12.h),

                // Overlapping Participant Avatars
                _buildParticipantStack(),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          // ═══════════════════════════════════════════════
          // SECTION 2: RIGHT SIDE (DETAILS)
          // ═══════════════════════════════════════════════
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─────────────────────────────────────────
                // A. PROGRESS SECTION (TOP)
                // ─────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${match.currentPlayers} ${'out_of'.tr(context)} ${match.totalPlayers}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.greyText,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: progressPercentage,
                    backgroundColor: MyColors.greyText
                        .withOpacity(0.2),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                          MyColors.greenButton,
                        ),
                    minHeight: 8.h,
                  ),
                ),

                SizedBox(height: 16.h),

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
                              Icon(
                                Icons.stadium_outlined,
                                size: 16.w,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  match.stadiumName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight:
                                        FontWeight.w400,
                                    color: context
                                        .colors
                                        .textColor,
                                  ),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),

                          // Date Row
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .calendar_today_outlined,
                                size: 16.w,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                match.date,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight:
                                      FontWeight.w400,
                                  color: context
                                      .colors
                                      .textColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),

                          // Time Row
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 16.w,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                match.time,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight:
                                      FontWeight.w400,
                                  color: context
                                      .colors
                                      .textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // ─── RIGHT: PRICE & BUTTON COLUMN ───
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Price
                        Text(
                          '${match.price.toStringAsFixed(2)} ${'egp'.tr(context)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.greenButton,
                            height: 1.2,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Join Button
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: context
                                  .colors
                                  .textColor
                                  .withOpacity(0.3),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                    8.r,
                                  ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            minimumSize: Size(0, 0),
                            tapTargetSize:
                                MaterialTapTargetSize
                                    .shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'join_now'.tr(context),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: context
                                      .colors
                                      .textColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 12.w,
                                color: context
                                    .colors
                                    .textColor,
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
      height: 32.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Show visible avatars
          ...List.generate(visibleAvatars, (index) {
            return Positioned(
              left: index * 20.0.w,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
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
              left: visibleAvatars * 20.0.w,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
