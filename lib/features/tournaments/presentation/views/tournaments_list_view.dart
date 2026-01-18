import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class TournamentsListView extends StatelessWidget {
  const TournamentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data to alternate between two card types
    final items = [
      {'type': 'match'},
      {'type': 'invite'},
      {'type': 'match'},
      {'type': 'invite'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tournaments',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final item = items[index];
          if (item['type'] == 'match') {
            return const _MatchResultCard();
          } else {
            return const _TournamentInviteCard();
          }
        },
      ),
    );
  }
}

// TYPE A: MATCH RESULT CARD
class _MatchResultCard extends StatelessWidget {
  const _MatchResultCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.matchDetailsRoute);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Time and Location
          Text(
            '8 PM at stadium name',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 16.h),

          // Body: Teams and Score
          Row(
            children: [
              // Team 1
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(ImgAssets.team3),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Team 1',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Score in the middle
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '3  -  3',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Penalties: 2 - 4',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Team 2
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(ImgAssets.userAvatar),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Team 2',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

// TYPE B: TOURNAMENT INVITE CARD
class _TournamentInviteCard extends StatelessWidget {
  const _TournamentInviteCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.tournamentDetailsRoute);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rich Text Description
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.4,
              ),
              children: [
                const TextSpan(
                  text: 'There is a football tournament in the ',
                ),
                TextSpan(
                  text: 'Shams field',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(
                  text: ' starting on ',
                ),
                TextSpan(
                  text: 'May 30, 2023',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Footer Row: Avatar Stack + Join Button
          Row(
            children: [
              // Avatar Stack
              SizedBox(
                width: 80.w,
                height: 35.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 17.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundImage: AssetImage(ImgAssets.team3),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25.w,
                      child: CircleAvatar(
                        radius: 17.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundImage: AssetImage(ImgAssets.userAvatar),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50.w,
                      child: CircleAvatar(
                        radius: 17.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundImage: AssetImage(ImgAssets.team3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Team Count Text
              Text(
                '3 teams out of 4',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),

              const Spacer(),

              // Join Now Button
              OutlinedButton(
                onPressed: () {
                  context.push(Routes.tournamentDetailsRoute);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: MyColors.greenButton,
                  side: BorderSide(
                    color: MyColors.greenButton,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  minimumSize: Size(0, 35.h),
                ),
                child: Text(
                  'Join now >',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
