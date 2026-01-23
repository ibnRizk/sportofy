import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/injection_container.dart';

// Team Standing Model
class _TeamStanding {
  final int rank;
  final String teamName;
  final String teamAvatar;
  final int wins;
  final int draws;
  final int loses;
  final int points;
  final String matchTime;
  final bool isTopTwo;

  _TeamStanding({
    required this.rank,
    required this.teamName,
    required this.teamAvatar,
    required this.wins,
    required this.draws,
    required this.loses,
    required this.points,
    required this.matchTime,
    this.isTopTwo = false,
  });
}

class RoundOf32View extends StatelessWidget {
  const RoundOf32View({super.key});

  static final List<_TeamStanding> _groupA = [
    _TeamStanding(
      rank: 1,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
      isTopTwo: true,
    ),
    _TeamStanding(
      rank: 2,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
      isTopTwo: true,
    ),
    _TeamStanding(
      rank: 3,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 10,
      matchTime: '8 PM at stadium name',
    ),
    _TeamStanding(
      rank: 4,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 10,
      matchTime: '8 PM at stadium name',
    ),
  ];

  static final List<_TeamStanding> _groupB = [
    _TeamStanding(
      rank: 1,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
      isTopTwo: true,
    ),
    _TeamStanding(
      rank: 2,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
      isTopTwo: true,
    ),
    _TeamStanding(
      rank: 3,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
    ),
    _TeamStanding(
      rank: 4,
      teamName: 'Team one',
      teamAvatar: 'assets/images/team3.png',
      wins: 4,
      draws: 6,
      loses: 1,
      points: 13,
      matchTime: '8 PM at stadium name',
    ),
  ];

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
          'Round of 32',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildTableHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildGroupHeader('Group A'),
                ..._groupA.map((team) => _TeamStandingRow(team: team)),
                _buildGroupHeader('Group B'),
                ..._groupB.map((team) => _TeamStandingRow(team: team)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      color: const Color(0xFF3688A6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'Teams',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Win',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Draw',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Lose',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Points',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupHeader(String groupName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              groupName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: MyColors.greenButton,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
    );
  }
}

class _TeamStandingRow extends StatelessWidget {
  final _TeamStanding team;

  const _TeamStandingRow({required this.team});

  @override
  Widget build(BuildContext context) {
    final bool isEvenRow = team.rank % 2 == 0;
    final Color rowColor = isEvenRow ? Colors.white : Colors.grey[50]!;

    return Container(
      color: rowColor,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  child: Text(
                    '${team.rank}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                team.isTopTwo
                    ? Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18.sp,
                      )
                    : Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8E6D1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 10.sp,
                        ),
                      ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: AssetImage(team.teamAvatar),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    team.teamName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${team.wins}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${team.draws}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${team.loses}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${team.points}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.greenButton,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  team.matchTime,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
