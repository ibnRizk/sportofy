import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable date header widget for tournament rounds
class MatchDateHeader extends StatelessWidget {
  final String date;
  final String month;

  const MatchDateHeader({
    super.key,
    required this.date,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: Colors.grey[300], thickness: 1),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3688A6),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(color: Colors.grey[300], thickness: 1),
          ),
        ],
      ),
    );
  }
}

/// Match data model
class MatchData {
  final String team1Name;
  final String team1Avatar;
  final int team1Score;
  final String team2Name;
  final String team2Avatar;
  final int team2Score;
  final String stadiumInfo;

  MatchData({
    required this.team1Name,
    required this.team1Avatar,
    required this.team1Score,
    required this.team2Name,
    required this.team2Avatar,
    required this.team2Score,
    required this.stadiumInfo,
  });
}

/// Reusable symmetrical match card widget
class SymmetricalMatchCard extends StatelessWidget {
  final MatchData match;

  const SymmetricalMatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage(match.team1Avatar),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${match.team1Score}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Text(
                        match.team1Name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 40.w,
                child: Text(
                  'V',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        match.team2Name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '${match.team2Score}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage(match.team2Avatar),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              match.stadiumInfo,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
