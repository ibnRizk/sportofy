import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/tournament_match_widgets.dart';

class RoundOf8View extends StatelessWidget {
  const RoundOf8View({super.key});

  static final List<MatchData> _matches = [
    MatchData(
      team1Name: 'Team one',
      team1Avatar: 'assets/images/team3.png',
      team1Score: 3,
      team2Name: 'Team one',
      team2Avatar: 'assets/images/team2.png',
      team2Score: 1,
      stadiumInfo: '8 PM at stadium name',
    ),
    MatchData(
      team1Name: 'Team one',
      team1Avatar: 'assets/images/team3.png',
      team1Score: 4,
      team2Name: 'Team one',
      team2Avatar: 'assets/images/team2.png',
      team2Score: 2,
      stadiumInfo: '8 PM at stadium name',
    ),
    MatchData(
      team1Name: 'Team one',
      team1Avatar: 'assets/images/team3.png',
      team1Score: 5,
      team2Name: 'Team one',
      team2Avatar: 'assets/images/team2.png',
      team2Score: 1,
      stadiumInfo: '8 PM at stadium name',
    ),
    MatchData(
      team1Name: 'Team one',
      team1Avatar: 'assets/images/team3.png',
      team1Score: 3,
      team2Name: 'Team one',
      team2Avatar: 'assets/images/team2.png',
      team2Score: 3,
      stadiumInfo: '8 PM at stadium name',
    ),
  ];

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
          'Round of 8',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: _matches.length + 1, // +1 for the date header
        itemBuilder: (context, index) {
          if (index == 0) {
            // Date header
            return MatchDateHeader(date: '15', month: 'Aug');
          } else {
            // Match item
            return SymmetricalMatchCard(match: _matches[index - 1]);
          }
        },
      ),
    );
  }
}
