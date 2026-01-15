import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/tournament_match_widgets.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/large_match_card.dart';

class SemiFinalView extends StatelessWidget {
  const SemiFinalView({super.key});

  static final List<LargeMatchData> _matches = [
    LargeMatchData(
      team1Name: 'Team 1',
      team1Avatar: 'assets/images/team3.png',
      team1Score: 3,
      team1Penalties: 2,
      team2Name: 'Team 2',
      team2Avatar: 'assets/images/team2.png',
      team2Score: 3,
      team2Penalties: 4,
      stadiumInfo: '8 PM at stadium name',
    ),
    LargeMatchData(
      team1Name: 'Team 1',
      team1Avatar: 'assets/images/team2.png',
      team1Score: 3,
      team1Penalties: 2,
      team2Name: 'Team 2',
      team2Avatar: 'assets/images/team3.png',
      team2Score: 3,
      team2Penalties: 4,
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
          'Semi Final',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: _matches.length * 2, // Each match has a date header
        separatorBuilder: (context, index) {
          // Add spacing between date header and match, or between matches
          if (index % 2 == 0) {
            return SizedBox(height: 8.h); // Between date header and match
          } else {
            return SizedBox(height: 20.h); // Between match groups
          }
        },
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            // Date header (every even index)
            return MatchDateHeader(date: '15', month: 'Aug');
          } else {
            // Match card (every odd index)
            final matchIndex = (index - 1) ~/ 2;
            return LargeMatchCard(match: _matches[matchIndex]);
          }
        },
      ),
    );
  }
}
