import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/join_team_sheet.dart';

class TournamentDetailsView extends StatelessWidget {
  const TournamentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Hero Image with AppBar
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.w,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.1,
                        ),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ),
                onPressed: () {
                  // TODO: Implement share
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/fifa_cup.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // About Section
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Joined Teams Section
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Joined Teams',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(
                            Routes.joinedTeamsRoute,
                          );
                        },
                        child: Text(
                          'View teams',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greenButton,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Teams Progress
                  Row(
                    children: [
                      Text(
                        '8/16 Teams',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 8.h,
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(
                            MyColors.greenButton,
                          ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Team Cards List
                  _TeamCard(
                    teamName: 'Team Name',
                    memberCount: '17 member',
                    avatarImage: 'assets/images/team3.png',
                    extraMembersCount: 6,
                  ),
                  SizedBox(height: 12.h),
                  _TeamCard(
                    teamName: 'Team Name',
                    memberCount: '15 member',
                    avatarImage: 'assets/images/team3.png',
                    extraMembersCount: 4,
                  ),

                  SizedBox(height: 24.h),

                  // Schedule Section - Navigate to MatchDetailsView which has the Schedule
                  InkWell(
                    onTap: () {
                      context.push(
                        Routes.matchDetailsRoute,
                      );
                    },
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Schedule',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // The Date Section
                  Text(
                    'The Date',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Starting: 15 Aug 2023',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ending: 25 Aug 2023',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Award Section
                  Text(
                    'Award',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'A financial reward of 20,000 Egyptian pounds',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  SizedBox(
                    height: 80.h,
                  ), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'For Team',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '300 EGP',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.greenButton,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Show "Join with your team" sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) =>
                        const JoinTeamSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PIXEL-PERFECT TEAM CARD WIDGET
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
      // ROOT CONTAINER
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      // MAIN LAYOUT (Row)
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CHILD 1: LEADING AVATAR (Fixed Size)
          CircleAvatar(
            radius: 24.r,
            backgroundImage: AssetImage(avatarImage),
          ),

          // SPACING
          SizedBox(width: 16.w),

          // CHILD 2: TEAM INFO (Expanded Area)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Team Name
                Text(
                  teamName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // SPACING
                SizedBox(height: 4.h),

                // Member Count
                Text(
                  memberCount,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // CHILD 3: TRAILING SECTION (Fixed Size & Stacked)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The Avatar Stack
              SizedBox(
                width: 70.w,
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

                    // Avatar 3 (The "+X")
                    Positioned(
                      left: 30.w,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundColor: Colors.black87,
                          child: Text(
                            '+$extraMembersCount',
                            style: TextStyle(
                              fontSize: 10.sp,
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

              // SPACING
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
