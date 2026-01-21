import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class MatchResultSlider extends StatefulWidget {
  const MatchResultSlider({super.key});

  @override
  State<MatchResultSlider> createState() =>
      _MatchResultSliderState();
}

class _MatchResultSliderState
    extends State<MatchResultSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSlides = 4;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.containerHeight200,
      width: double.infinity, // Full width
      child: PageView.builder(
        controller: _pageController,
        itemCount: _totalSlides,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildSlide1CompletedMatch(context);
            case 1:
              return _buildSlide2TournamentInvite(context);
            case 2:
              return _buildSlide3Congratulations(context);
            case 3:
              return _buildSlide4UpcomingMatch(context);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // SLIDE 1: Completed Match (Scoreboard)
  // ═══════════════════════════════════════════════
  Widget _buildSlide1CompletedMatch(BuildContext context) {
    return _buildBaseCard(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Semi final 22. Dec. 2023',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.darkGrayColor,
              ),
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Score Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              // Team 3
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team3,
                teamName: 'Team 3',
              ),

              // Score Section
              Column(
                children: [
                  Text(
                    '3 - 3',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: MyColors
                          .textColor, // Dark Blue/Navy
                    ),
                  ),
                  SizedBox(height: AppDimens.h4),
                  Text(
                    'Penalties: 2 - 4',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.greyText,
                    ),
                  ),
                ],
              ),

              // Team 5
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team5,
                teamName: 'Team 5',
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Pagination Dots
          _buildPageIndicator(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // SLIDE 2: Tournament Invite (Rich Content)
  // ═══════════════════════════════════════════════
  Widget _buildSlide2TournamentInvite(
    BuildContext context,
  ) {
    return _buildBaseCard(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament Text with RichText
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.darkGrayColor,
              ),
              children: [
                const TextSpan(
                  text:
                      'There is a football tournament in the ',
                ),
                TextSpan(
                  text: 'Shams',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' field starting on '),
                TextSpan(
                  text: 'May 30, 2023',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Bottom Row: Avatars + Text + Button
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              // Stacked Avatars + Text
              Row(
                children: [
                  // Overlapping Avatars Stack
                  SizedBox(
                    width: AppDimens.w100,
                    height: AppDimens.containerHeight40,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Avatar 1
                        Positioned(
                          left: 0,
                          child: _buildSmallAvatar(
                            ImgAssets.team3,
                          ),
                        ),
                        // Avatar 2
                        Positioned(
                          left: AppDimens.w20,
                          child: _buildSmallAvatar(
                            ImgAssets.team5,
                          ),
                        ),
                        // Avatar 3
                        Positioned(
                          left: AppDimens.w40,
                          child: _buildSmallAvatar(
                            ImgAssets.team10,
                          ),
                        ),
                        // Empty Placeholder (Grey Circle)
                        Positioned(
                          left: AppDimens.w60,
                          child: Container(
                            width:
                                AppDimens.containerHeight40,
                            height:
                                AppDimens.containerHeight40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.grey300,
                              border: Border.all(
                                color: MyColors.white,
                                width:
                                    AppDimens.borderWidth2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: AppDimens.w8),

                  // Text
                  Text(
                    '3 teams out of 4',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                ],
              ),

              // Join Now Button
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: MyColors.greenButton,
                    width: AppDimens.borderWidth1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.w12,
                    vertical: AppDimens.h6,
                  ),
                  minimumSize: Size(0, 0),
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Join now',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.greenButton,
                      ),
                    ),
                    SizedBox(width: AppDimens.w4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10.sp,
                      color: MyColors.greenButton,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Pagination Dots
          _buildPageIndicator(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // SLIDE 3: Congratulations (Golden Card)
  // ═══════════════════════════════════════════════
  Widget _buildSlide3Congratulations(BuildContext context) {
    return _buildBaseCard(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row: Text (Left) + Image (Right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Text with Emojis
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.darkGrayColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Congratulations ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      const TextSpan(text: '🎉 '),
                      const TextSpan(text: 'to the '),
                      TextSpan(
                        text: 'Team 10',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' 🥇 '),
                      const TextSpan(
                        text: 'for winning the ',
                      ),
                      TextSpan(
                        text: 'Champions League title',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      const TextSpan(text: ' ✨'),
                    ],
                  ),
                ),
              ),

              SizedBox(width: AppDimens.w12),

              // Right: Team 10 Image
              Container(
                width: AppDimens.containerWidth80,
                height: AppDimens.containerWidth80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: _buildTeamAvatar(
                    ImgAssets.team10,
                    AppDimens.containerWidth80,
                    AppDimens.containerWidth80,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Pagination Dots
          _buildPageIndicator(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // SLIDE 4: Upcoming Match (Coming Soon)
  // ═══════════════════════════════════════════════
  Widget _buildSlide4UpcomingMatch(BuildContext context) {
    return _buildBaseCard(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Match name 22. Dec. 2023',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.darkGrayColor,
              ),
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Score Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              // Team 6 (using team3 as placeholder)
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team3,
                teamName: 'Team 6',
              ),

              // Center: Large "V" + "Coming soon"
              Column(
                children: [
                  Text(
                    'V',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                  SizedBox(height: AppDimens.h4),
                  Text(
                    'Coming soon',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.greyText,
                    ),
                  ),
                ],
              ),

              // Team 9 (using team5 as placeholder)
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team5,
                teamName: 'Team 9',
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          // Pagination Dots
          _buildPageIndicator(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // BASE CARD CONTAINER (Shared Styling)
  // ═══════════════════════════════════════════════
  Widget _buildBaseCard({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.w16,
        vertical: AppDimens.h16,
      ),
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
      child: child,
    );
  }

  // ═══════════════════════════════════════════════
  // PAGINATION INDICATOR
  // ═══════════════════════════════════════════════
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalSlides, (index) {
        final isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(
            horizontal: AppDimens.w3,
          ),
          width: isActive
              ? AppDimens.w20
              : AppDimens
                    .w6, // Wide line for active, small circle for inactive
          height: AppDimens.h6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimens.w3,
            ),
            color: isActive
                ? MyColors
                      .main // Teal/Green for active (wide line)
                : MyColors.greyText.withValues(
                    alpha: 0.5,
                  ), // Grey for inactive (small circle)
          ),
        );
      }),
    );
  }

  // ═══════════════════════════════════════════════
  // TEAM AVATAR BUILDER (Supports SVG & PNG)
  // ═══════════════════════════════════════════════
  Widget _buildTeamAvatar(
    String imagePath,
    double width,
    double height,
  ) {
    // Check file extension to determine render method
    if (imagePath.endsWith('.svg')) {
      // SVG files - use SvgPicture
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholderBuilder: (context) =>
            _buildPlaceholder(width, height),
        errorBuilder: (context, error, stackTrace) {
          debugPrint(
            'SVG Error loading $imagePath: $error',
          );
          return _buildPlaceholder(width, height);
        },
      );
    } else {
      // PNG/JPG files - use Image.asset
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint(
            'Image Error loading $imagePath: $error',
          );
          return _buildPlaceholder(width, height);
        },
      );
    }
  }

  // Placeholder widget
  Widget _buildPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.grey300,
      ),
      child: Icon(
        Icons.sports_soccer,
        size: width * 0.5,
        color: MyColors.greyText,
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // TEAM INFO WIDGET (Reusable)
  // ═══════════════════════════════════════════════
  Widget _buildTeamInfo({
    required BuildContext context,
    required String teamImage,
    required String teamName,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimens.containerWidth60,
          height: AppDimens.containerHeight60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: _buildTeamAvatar(
              teamImage,
              AppDimens.containerWidth60,
              AppDimens.containerHeight60,
            ),
          ),
        ),
        SizedBox(height: AppDimens.h8),
        Text(
          teamName,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: MyColors.darkGrayColor,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  // SMALL AVATAR (For Overlapping Stack)
  // ═══════════════════════════════════════════════
  Widget _buildSmallAvatar(String imagePath) {
    return Container(
      width: AppDimens.containerHeight40,
      height: AppDimens.containerHeight40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: MyColors.white,
          width: AppDimens.borderWidth2,
        ),
      ),
      child: ClipOval(
        child: _buildTeamAvatar(
          imagePath,
          AppDimens.containerHeight40,
          AppDimens.containerHeight40,
        ),
      ),
    );
  }
}
