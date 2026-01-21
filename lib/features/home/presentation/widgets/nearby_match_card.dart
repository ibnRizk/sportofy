import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
              color: MyColors.black.withValues(alpha: AppDimens.opacity05),
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
            width: AppDimens.containerWidth100,
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
                  style: TextStyles.semiBold13(
                    color: context.colors.textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppDimens.h4),

                // Organizer Label
                Text(
                  'organizer'.tr(context),
                  style: TextStyles.medium11(
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
                      style: TextStyles.semiBold10(
                        color: MyColors.greyText,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimens.h6),

                // Progress Bar
                ClipRRect(
                  borderRadius: AppRadius.r10,
                  child: LinearProgressIndicator(
                    value: progressPercentage,
                    backgroundColor: MyColors.greyText
                        .withValues(alpha: AppDimens.opacity2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      MyColors.greenButton,
                    ),
                    minHeight: AppDimens.h8,
                  ),
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
                              Icon(
                                Icons.stadium_outlined,
                                size: AppDimens.iconSize16,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: AppDimens.w6),
                              Expanded(
                                child: Text(
                                  match.stadiumName,
                                  style: TextStyles.regular12(
                                    color: context.colors.textColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: AppDimens.h6),

                          // Date Row
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: AppDimens.iconSize16,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: AppDimens.w6),
                              Text(
                                match.date,
                                style: TextStyles.regular12(
                                  color: context.colors.textColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: AppDimens.h6),

                          // Time Row
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: AppDimens.iconSize16,
                                color: MyColors.greyText,
                              ),
                              SizedBox(width: AppDimens.w6),
                              Text(
                                match.time,
                                style: TextStyles.regular12(
                                  color: context.colors.textColor,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                            side: BorderSide(
                              color: context.colors.textColor
                                  .withValues(alpha: AppDimens.opacity3),
                              width: AppDimens.borderWidth1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.r8,
                            ),
                            padding: AppPadding.h16v8,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'join_now'.tr(context),
                                style: TextStyles.medium11(
                                  color: context.colors.textColor,
                                ),
                              ),
                              SizedBox(width: AppDimens.w4),
                              Icon(
                                Icons.arrow_forward,
                                size: AppDimens.iconSize12,
                                color: context.colors.textColor,
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
