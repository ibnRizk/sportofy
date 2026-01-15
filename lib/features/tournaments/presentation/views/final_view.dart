import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/tournament_match_widgets.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/large_match_card.dart';

class FinalView extends StatelessWidget {
  const FinalView({super.key});

  static final LargeMatchData _firstSecondMatch = LargeMatchData(
    team1Name: 'Team 1',
    team1Avatar: 'assets/images/team3.png',
    team1Score: 3,
    team1Penalties: 2,
    team2Name: 'Team 2',
    team2Avatar: 'assets/images/team2.png',
    team2Score: 3,
    team2Penalties: 4,
    stadiumInfo: '8 PM at stadium name',
  );

  static final LargeMatchData _thirdFourthMatch = LargeMatchData(
    team1Name: 'Team 1',
    team1Avatar: 'assets/images/team2.png',
    team1Score: 3,
    team1Penalties: 2,
    team2Name: 'Team 2',
    team2Avatar: 'assets/images/team3.png',
    team2Score: 3,
    team2Penalties: 4,
    stadiumInfo: '8 PM at stadium name',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Final',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        children: [
          // SECTION 1: First and Second
          MatchDateHeader(date: '15', month: 'Aug'),
          SizedBox(height: 10.h),
          _buildStageLabel('First and Second'),
          SizedBox(height: 10.h),
          LargeMatchCard(match: _firstSecondMatch),

          SizedBox(height: 20.h),

          // SECTION 2: Third and fourth
          MatchDateHeader(date: '15', month: 'Aug'),
          SizedBox(height: 10.h),
          _buildStageLabel('Third and fourth'),
          SizedBox(height: 10.h),
          LargeMatchCard(match: _thirdFourthMatch),
        ],
      ),
    );
  }

  Widget _buildStageLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.center,
    );
  }
}
