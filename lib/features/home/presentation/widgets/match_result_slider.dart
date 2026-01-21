import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class MatchResultSlider extends StatefulWidget {
  const MatchResultSlider({super.key});

  @override
  State<MatchResultSlider> createState() => _MatchResultSliderState();
}

class _MatchResultSliderState extends State<MatchResultSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Mock data for 4 match results
  final List<Map<String, dynamic>> _matches = [
    {
      'title': 'Semi final',
      'date': '22. Dec. 2023',
      'team1': 'Team 3',
      'team2': 'Team 5',
      'score1': '3',
      'score2': '3',
      'penalty': 'Penalties: 2 - 4',
    },
    {
      'title': 'Quarter final',
      'date': '18. Dec. 2023',
      'team1': 'Team 3',
      'team2': 'Team 5',
      'score1': '2',
      'score2': '1',
      'penalty': '',
    },
    {
      'title': 'Group Stage',
      'date': '15. Dec. 2023',
      'team1': 'Team 3',
      'team2': 'Team 5',
      'score1': '1',
      'score2': '1',
      'penalty': '',
    },
    {
      'title': 'Friendly Match',
      'date': '10. Dec. 2023',
      'team1': 'Team 3',
      'team2': 'Team 5',
      'score1': '4',
      'score2': '2',
      'penalty': '',
    },
  ];

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
      child: Stack(
        children: [
          // PageView
          SizedBox(
            height: AppDimens.containerHeight180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _matches.length,
              itemBuilder: (context, index) {
                final match = _matches[index];
                return _buildMatchResultCard(
                  context: context,
                  title: match['title'],
                  date: match['date'],
                  team1Name: match['team1'],
                  team1Score: match['score1'],
                  team2Name: match['team2'],
                  team2Score: match['score2'],
                  penaltyInfo: match['penalty'],
                );
              },
            ),
          ),
          // Page Indicator Overlay
          Positioned(
            bottom: AppDimens.h20,
            left: 0,
            right: 0,
            child: _buildPageIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _matches.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: AppDimens.w3),
          width: _currentPage == index ? AppDimens.w20 : AppDimens.w6,
          height: AppDimens.h6,
          decoration: BoxDecoration(
            borderRadius: AppRadius.r3,
            color: _currentPage == index
                ? MyColors.white
                : MyColors.white.withValues(alpha: AppDimens.opacity5),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchResultCard({
    required BuildContext context,
    required String title,
    required String date,
    required String team1Name,
    required String team1Score,
    required String team2Name,
    required String team2Score,
    required String penaltyInfo,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.w16),
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: AppRadius.r16,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$title  $date',
            style: TextStyles.semiBold14(
              color: context.colors.textColor,
            ),
          ),
          SizedBox(height: AppDimens.h16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Team 1
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team3,
                teamName: team1Name,
              ),

              // Score
              Text(
                '$team1Score  -  $team2Score',
                style: TextStyles.bold32(
                  color: context.colors.textColor,
                ),
              ),

              // Team 2
              _buildTeamInfo(
                context: context,
                teamImage: ImgAssets.team3,
                teamName: team2Name,
              ),
            ],
          ),
          if (penaltyInfo.isNotEmpty) ...[
            SizedBox(height: AppDimens.h12),
            Text(
              penaltyInfo,
              style: TextStyles.medium12(
                color: MyColors.greyText,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTeamInfo({
    required BuildContext context,
    required String teamImage,
    required String teamName,
  }) {
    return Column(
      children: [
        Container(
          width: AppDimens.containerWidth60,
          height: AppDimens.containerHeight60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(teamImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: AppDimens.h8),
        Text(
          teamName,
          style: TextStyles.semiBold12(
            color: context.colors.textColor,
          ),
        ),
      ],
    );
  }
}
