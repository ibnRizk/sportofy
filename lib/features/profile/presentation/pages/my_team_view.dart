import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class MyTeamView extends StatelessWidget {
  const MyTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backGround,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══════════════════════════════════════════════
              // SECTION A: CUSTOM APP BAR
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                child: Row(
                  children: [
                    // Back Arrow
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24.w,
                        color: Colors.black87,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 16.w),
                    // Title
                    Expanded(
                      child: Text(
                        'My Team',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                    ),
                    // Leave Team Button
                    TextButton(
                      onPressed: () {
                        // TODO: Implement Leave Team Logic
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap,
                      ),
                      child: Text(
                        'Leave Team',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // ═══════════════════════════════════════════════
              // SECTION B: TEAM HEADER
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Row(
                  children: [
                    // Team Logo
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(
                        ImgAssets.team3,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Team Info
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.sports_soccer,
                              size: 14.w,
                              color: MyColors.greenButton,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Football team',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: MyColors.greenButton,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ═══════════════════════════════════════════════
              // SECTION C: MEMBERS GRID
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Team Members',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '17 member',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Members Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio:
                                3.0, // Wide rectangles
                          ),
                      itemCount: _mockMembers.length,
                      itemBuilder: (context, index) {
                        final member = _mockMembers[index];
                        return _buildMemberItem(
                          avatarPath: member['avatar']!,
                          name: member['name']!,
                          role: member['role']!,
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Member Item Widget
  Widget _buildMemberItem({
    required String avatarPath,
    required String name,
    required String role,
  }) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 22.r,
          backgroundImage: AssetImage(avatarPath),
        ),
        SizedBox(width: 10.w),
        // Name and Role
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                role,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.darkGrayColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Mock Data for Team Members
  static final List<Map<String, String>> _mockMembers = [
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'You ( Organizer )',
      'role': 'Goal Keeper',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Mostafa Mohamed',
      'role': 'Attacking',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Mohamed Yousri',
      'role': 'Striker',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Elsayed Ayman',
      'role': 'Attacking',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Hossam Mamduh',
      'role': 'Defensive',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Ali Mohamed',
      'role': 'Full - back',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Seif Ahmed',
      'role': 'Full - back',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Ayman Mahmoud',
      'role': 'Center - back',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Hassan Elsayed',
      'role': 'Center - back',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Adham Ibrahim',
      'role': 'Second striker',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Omar Elsayed',
      'role': 'Central Mid fonder',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Adham Ibrahim',
      'role': 'Second striker',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Omar Elsayed',
      'role': 'Central Mid fonder',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Adham Ibrahim',
      'role': 'Second striker',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Omar Elsayed',
      'role': 'Central Mid fonder',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Adham Ibrahim',
      'role': 'Second striker',
    },
    {
      'avatar': ImgAssets.userAvatar,
      'name': 'Omar Elsayed',
      'role': 'Central Mid fonder',
    },
  ];
}
