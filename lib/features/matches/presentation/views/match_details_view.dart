import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
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
      backgroundColor: Colors.white,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
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
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight:
                                        FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '(4.87)',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight:
                                        FontWeight.w500,
                                    color: Colors.black87,
                                  ),
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
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                      8.r,
                                    ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text(
                                  'View Stadium',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: MyColors
                                        .greenButton,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 14.sp,
                                  color:
                                      MyColors.greenButton,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Tags Row
                      Text(
                        '5 X 5  |  Indoor',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(height: 1, color: Colors.grey[300]),

                // The Date Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Date',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            match.date,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                match.time,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 16.sp,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '08:00 PM',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Divider(height: 1, color: Colors.grey[300]),

                // Note Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(height: 1, color: Colors.grey[300]),

                // The Team Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
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
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
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
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: MyColors.greenButton,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Team Content Row
                      Row(
                        children: [
                          // Left: Organizer
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundImage: AssetImage(
                                  match.organizerAvatar,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    match.organizerName,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'organizer'.tr(context),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight:
                                          FontWeight.w500,
                                      color: MyColors
                                          .greenButton,
                                    ),
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
                              SizedBox(height: 8.h),
                              Text(
                                '${match.currentPlayers} ${'out_of'.tr(context)} ${match.totalPlayers}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        child: LinearProgressIndicator(
                          value: progressPercentage,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              const AlwaysStoppedAnimation<
                                Color
                              >(MyColors.greenButton),
                          minHeight: 8.h,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom padding to account for fixed action bar
                SizedBox(height: 100.h),
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
      height: 250
          .h, // Fixed height to prevent unbounded constraints
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image
          Container(
            height: 250.h,
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
            height: 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),

          // Top Navigation Buttons
          Positioned(
            top: 40.h,
            left: 16.w,
            child: Row(
              children: [
                // Back Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20.sp,
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
                SizedBox(width: 12.w),
                // Match Title
                Text(
                  'Match',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Share Button
          Positioned(
            top: 40.h,
            right: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 20.sp,
                ),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ),
          ),

          // Page Indicators (Bottom Center)
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  width: index == 0 ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.white
                        : Colors.white.withValues(
                            alpha: 0.5,
                          ),
                    borderRadius: BorderRadius.circular(
                      4.r,
                    ),
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
        (visibleAvatars - 1) * 24.0.w +
        40.w +
        (remainingCount > 0 ? 40.w : 0);

    return SizedBox(
      height: 40.h,
      width: totalWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Show visible avatars
          ...List.generate(visibleAvatars, (index) {
            return Positioned(
              left: index * 24.0.w,
              child: Container(
                width: 40.w,
                height: 40.h,
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
              left: visibleAvatars * 24.0.w,
              child: Container(
                width: 40.w,
                height: 40.h,
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
                      fontSize: 12.sp,
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

  // Bottom Action Bar
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
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
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${match.price.toStringAsFixed(0)} ${'egp'.tr(context)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.greenButton,
                  ),
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
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
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                  ),
                ),
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
