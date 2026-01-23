import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/tournament_match_widgets.dart';

class _DateGroup {
  final String date;
  final String month;
  final List<MatchData> matches;

  _DateGroup({
    required this.date,
    required this.month,
    required this.matches,
  });
}

class RoundOf16View extends StatelessWidget {
  const RoundOf16View({super.key});

  static final List<_DateGroup> _matchGroups = [
    _DateGroup(
      date: '15',
      month: 'Aug',
      matches: [
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
          team1Avatar: 'assets/images/team2.png',
          team1Score: 3,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team3.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
        MatchData(
          team1Name: 'Team one',
          team1Avatar: 'assets/images/team3.png',
          team1Score: 1,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team2.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
        MatchData(
          team1Name: 'Team one',
          team1Avatar: 'assets/images/team2.png',
          team1Score: 0,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team3.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
      ],
    ),
    _DateGroup(
      date: '15',
      month: 'Aug',
      matches: [
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
          team1Avatar: 'assets/images/team2.png',
          team1Score: 3,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team3.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
        MatchData(
          team1Name: 'Team one',
          team1Avatar: 'assets/images/team3.png',
          team1Score: 1,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team2.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
        MatchData(
          team1Name: 'Team one',
          team1Avatar: 'assets/images/team2.png',
          team1Score: 0,
          team2Name: 'Team one',
          team2Avatar: 'assets/images/team3.png',
          team2Score: 2,
          stadiumInfo: '8 PM at stadium name',
        ),
      ],
    ),
  ];

  List<Widget> _buildItemList() {
    final List<Widget> items = [];
    
    for (int i = 0; i < _matchGroups.length; i++) {
      final group = _matchGroups[i];
      items.add(MatchDateHeader(date: group.date, month: group.month));
      items.add(SizedBox(height: 8.h));
      for (final match in group.matches) {
        items.add(SymmetricalMatchCard(match: match));
      }
      if (i < _matchGroups.length - 1) {
        items.add(SizedBox(height: 20.h));
      }
    }
    
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backGround,
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
          'Round of 16',
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
        itemCount: _buildItemList().length,
        itemBuilder: (context, index) {
          return _buildItemList()[index];
        },
      ),
    );
  }
}
