import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Data model for large match cards (used in Semi Final and Final)
class LargeMatchData {
  final String team1Name;
  final String team1Avatar;
  final int team1Score;
  final int? team1Penalties;
  final String team2Name;
  final String team2Avatar;
  final int team2Score;
  final int? team2Penalties;
  final String stadiumInfo;

  LargeMatchData({
    required this.team1Name,
    required this.team1Avatar,
    required this.team1Score,
    this.team1Penalties,
    required this.team2Name,
    required this.team2Avatar,
    required this.team2Score,
    this.team2Penalties,
    required this.stadiumInfo,
  });
}

/// Reusable large match card widget (used in Semi Final and Final screens)
class LargeMatchCard extends StatelessWidget {
  final LargeMatchData match;

  const LargeMatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Aligned Time
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              match.stadiumInfo,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 15.h),

          // Match Content Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Column: Avatar + Team Name
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(match.team1Avatar),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      match.team1Name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Center Column: Score + Penalties (if available)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${match.team1Score} - ${match.team2Score}',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (match.team1Penalties != null && match.team2Penalties != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        'Penalties: ${match.team1Penalties} - ${match.team2Penalties}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Right Column: Avatar + Team Name
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(match.team2Avatar),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      match.team2Name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
