import 'package:flutter/material.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/home/domain/entities/match_entity.dart';
import 'package:sportify_app/features/matches/presentation/views/team_members_view.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_methods_sheet.dart';
import 'package:sportify_app/features/stadiums/presentation/views/stadium_details_view.dart';

class MatchDetailsView extends StatelessWidget {
  final MatchEntity match;

  const MatchDetailsView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final progressPercentage =
        match.currentPlayers / match.totalPlayers;

    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Header
                _buildImageHeader(context),

                // Stadium Info Section
                Padding(
                  padding: AppPadding.h20v15,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  match.stadiumName,
                                  style: TextStyles.bold18(color: MyColors.black87),
                                ),
                                SizedBox(width: AppDimens.w8),
                                Icon(
                                  Icons.star,
                                  color: MyColors.amber,
                                  size: AppDimens.iconSize18,
                                ),
                                SizedBox(width: AppDimens.w4),
                                Text(
                                  '(4.87)',
                                  style: TextStyles.medium16(color: MyColors.black87),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StadiumDetailsView(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: MyColors.greenButton,
                                width: AppDimens.borderWidth1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppRadius.r8,
                              ),
                              padding: AppPadding.h12v8,
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text(
                                  'View Stadium',
                                  style: TextStyles.semiBold12(color: MyColors.greenButton),
                                ),
                                SizedBox(width: AppDimens.w4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: AppDimens.iconSize14,
                                  color:
                                      MyColors.greenButton,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppDimens.h8),

                      // Tags Row
                      Text(
                        '5 X 5  |  Indoor',
                        style: TextStyles.regular14(color: MyColors.grey600),
                      ),
                    ],
                  ),
                ),

                Divider(height: AppDimens.dividerThickness1, color: MyColors.grey300),

                // The Date Section
                Padding(
                  padding: AppPadding.h20v15,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Date',
                        style: TextStyles.bold16(color: MyColors.black87),
                      ),
                      SizedBox(height: AppDimens.h12),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            match.date,
                            style: TextStyles.medium14(color: MyColors.black87),
                          ),
                          Row(
                            children: [
                              Text(
                                match.time,
                                style: TextStyles.medium14(color: MyColors.black87),
                              ),
                              SizedBox(width: AppDimens.w8),
                              Icon(
                                Icons.arrow_forward,
                                size: AppDimens.iconSize16,
                                color: MyColors.grey600,
                              ),
                              SizedBox(width: AppDimens.w8),
                              Text(
                                '08:00 PM',
                                style: TextStyles.medium14(color: MyColors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Divider(height: AppDimens.dividerThickness1, color: MyColors.grey300),

                // Note Section
                Padding(
                  padding: AppPadding.h20v15,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note',
                        style: TextStyles.bold16(color: MyColors.black87),
                      ),
                      SizedBox(height: AppDimens.h12),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: TextStyles.regular14(color: MyColors.grey600).copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),

                Divider(height: AppDimens.dividerThickness1, color: MyColors.grey300),

                // The Team Section
                Padding(
                  padding: AppPadding.h20v15,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'The Team',
                            style: TextStyles.bold16(color: MyColors.black87),
                          ),
                          TextButton(
                            onPressed: () {
                              if (!context.mounted) return;
                              try {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TeamMembersView(),
                                  ),
                                );
                              } catch (e) {
                                debugPrint(
                                  'Navigation error to TeamMembersView: $e',
                                );
                              }
                            },
                            child: Text(
                              'View All',
                              style: TextStyles.semiBold14(color: MyColors.greenButton),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppDimens.h16),

                      // Team Content Row
                      Row(
                        children: [
                          // Left: Organizer
                          Row(
                            children: [
                              CircleAvatar(
                                radius: AppDimens.avatarSize30,
                                backgroundImage: AssetImage(
                                  match.organizerAvatar,
                                ),
                              ),
                              SizedBox(width: AppDimens.w12),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    match.organizerName,
                                    style: TextStyles.bold15(color: MyColors.black87),
                                  ),
                                  SizedBox(height: AppDimens.h4),
                                  Text(
                                    'organizer'.tr(context),
                                    style: TextStyles.medium12(color: MyColors.greenButton),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Right: Participants Stack
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildParticipantStack(),
                              SizedBox(height: AppDimens.h8),
                              Text(
                                '${match.currentPlayers} ${'out_of'.tr(context)} ${match.totalPlayers}',
                                style: TextStyles.medium12(color: MyColors.grey600),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: AppDimens.h16),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: AppRadius.r10,
                        child: LinearProgressIndicator(
                          value: progressPercentage,
                          backgroundColor: MyColors.grey300,
                          valueColor:
                              const AlwaysStoppedAnimation<
                                Color
                              >(MyColors.greenButton),
                          minHeight: AppDimens.h8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom padding to account for fixed action bar
                SizedBox(height: AppDimens.h100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  // Image Header with Back/Share buttons and indicators
  Widget _buildImageHeader(BuildContext context) {
    return SizedBox(
      height: AppDimens.containerHeight250,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image
          Container(
            height: AppDimens.containerHeight250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImgAssets.lightYard),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay Gradient (optional, for better button visibility)
          Container(
            height: AppDimens.containerHeight250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.black.withValues(alpha: AppDimens.opacity3),
                  MyColors.transparent,
                  MyColors.transparent,
                  MyColors.black.withValues(alpha: AppDimens.opacity2),
                ],
              ),
            ),
          ),

          // Top Navigation Buttons
          Positioned(
            top: AppDimens.h40,
            left: AppDimens.w16,
            child: Row(
              children: [
                // Back Button
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColors.black,
                      size: AppDimens.iconSize20,
                    ),
                    onPressed: () {
                      // Ensure we pop from the correct navigator with safety checks
                      if (!context.mounted) return;
                      if (Navigator.canPop(context)) {
                        try {
                          Navigator.pop(context);
                        } catch (e) {
                          debugPrint(
                            'Navigation pop error: $e',
                          );
                        }
                      }
                    },
                  ),
                ),
                SizedBox(width: AppDimens.w12),
                // Match Title
                Text(
                  'Match',
                  style: TextStyles.bold18(color: MyColors.white),
                ),
              ],
            ),
          ),

          // Share Button
          Positioned(
            top: AppDimens.h40,
            right: AppDimens.w16,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: MyColors.black,
                  size: AppDimens.iconSize20,
                ),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ),
          ),

          // Page Indicators (Bottom Center)
          Positioned(
            bottom: AppDimens.h16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: AppPadding.h4,
                  width: index == 0 ? AppDimens.w24 : AppDimens.w8,
                  height: AppDimens.h8,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? MyColors.white
                        : MyColors.white.withValues(
                            alpha: AppDimens.opacity5,
                          ),
                    borderRadius: AppRadius.r4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Participant Avatars Stack
  Widget _buildParticipantStack() {
    // Calculate how many avatars to show (max 4 visible + count badge)
    final visibleAvatars =
        match.participantAvatars.length > 4
        ? 4
        : match.participantAvatars.length;
    final remainingCount =
        match.participantAvatars.length > 4
        ? match.participantAvatars.length - 4
        : 0;

    // Calculate width: (visibleAvatars - 1) * overlap + avatar_width + badge_width(if exists)
    final totalWidth =
        (visibleAvatars - 1) * AppDimens.w24 +
        AppDimens.avatarSize40 +
        (remainingCount > 0 ? AppDimens.avatarSize40 : 0);

    return SizedBox(
      height: AppDimens.avatarSize40,
      width: totalWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Show visible avatars
          ...List.generate(visibleAvatars, (index) {
            return Positioned(
              left: index * AppDimens.w24,
              child: Container(
                width: AppDimens.avatarSize40,
                height: AppDimens.avatarSize40,
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
              left: visibleAvatars * AppDimens.w24,
              child: Container(
                width: AppDimens.avatarSize40,
                height: AppDimens.avatarSize40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.grey700,
                  border: Border.all(
                    color: MyColors.white,
                    width: AppDimens.borderWidth2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyles.bold12(color: MyColors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Bottom Action Bar
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: AppPadding.h20v16,
      decoration: BoxDecoration(
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity1),
            blurRadius: AppDimens.w10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Left: Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'For one',
                  style: TextStyles.regular12(color: MyColors.grey600),
                ),
                SizedBox(height: AppDimens.h4),
                Text(
                  '${match.price.toStringAsFixed(0)} ${'egp'.tr(context)}',
                  style: TextStyles.bold18(color: MyColors.greenButton),
                ),
              ],
            ),

            const Spacer(),

            // Right: Join Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Show Payment Methods Sheet
                  if (!context.mounted) return;
                  try {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: MyColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.top30,
                      ),
                      builder: (context) =>
                          PaymentMethodsSheet(
                            organizerName:
                                match.organizerName,
                            organizerAvatar:
                                match.organizerAvatar,
                          ),
                    );
                  } catch (e) {
                    debugPrint(
                      'Error showing payment methods sheet: $e',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r12,
                  ),
                  padding: AppPadding.v14,
                ),
                child: Text(
                  'Join',
                  style: TextStyles.bold16(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
