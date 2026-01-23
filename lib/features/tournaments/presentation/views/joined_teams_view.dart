import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/injection_container.dart';

class JoinedTeamsView extends StatelessWidget {
  const JoinedTeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for 8 teams
    final teams = List.generate(
      8,
      (index) => {
        'teamName': 'Team Name',
        'memberCount': '17 member',
        'avatarImage': 'assets/images/team3.png',
        'extraMembersCount': 6,
      },
    );

    return Scaffold(
      backgroundColor: context.colors.backGround,
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
          'Joined Teams',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: MyColors.darkGrayColor,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: teams.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final team = teams[index];
          return _TeamCard(
            teamName: team['teamName'] as String,
            memberCount: team['memberCount'] as String,
            avatarImage: team['avatarImage'] as String,
            extraMembersCount:
                team['extraMembersCount'] as int,
          );
        },
      ),
    );
  }
}

// TEAM CARD WIDGET FOR JOINED TEAMS LIST
class _TeamCard extends StatelessWidget {
  final String teamName;
  final String memberCount;
  final String avatarImage;
  final int extraMembersCount;

  const _TeamCard({
    required this.teamName,
    required this.memberCount,
    required this.avatarImage,
    required this.extraMembersCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEADING: Team Logo
          CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage(avatarImage),
          ),

          SizedBox(width: 12.w),

          // TITLE SECTION: Team Info (Expanded)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teamName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.darkGrayColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  memberCount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: MyColors.darkGrayColor,
                  ),
                ),
              ],
            ),
          ),

          // TRAILING SECTION: Stacked Avatars + Arrow
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The Avatar Stack
              SizedBox(
                width: 80.w,
                height: 30.h,
                child: Stack(
                  children: [
                    // Avatar 1
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 2
                    Positioned(
                      left: 15.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 3
                    Positioned(
                      left: 30.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundImage: AssetImage(
                            avatarImage,
                          ),
                        ),
                      ),
                    ),

                    // Avatar 4 (The "+X")
                    Positioned(
                      left: 45.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundColor: Colors.black87,
                          child: Text(
                            '+$extraMembersCount',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // The Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
