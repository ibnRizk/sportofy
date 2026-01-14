import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/profile/presentation/widgets/account_settings_bottom_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/contact_info_bottom_sheet.dart';
import 'package:sportify_app/injection_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══════════════════════════════════════════════
              // HEADER SECTION
              // ═══════════════════════════════════════════════
              Container(
                padding: EdgeInsets.all(20.w),
                color: context.colors.white,
                child: Column(
                  children: [
                    // Top Row: Back Button + Menu
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            size: 24.w,
                            color: context.colors.textColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AccountSettingsBottomSheet.show(
                              context,
                            );
                          },
                          icon: Icon(
                            Icons.more_vert,
                            size: 24.w,
                            color: context.colors.textColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // Profile Info Row
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Left Badge (336 coins)
                        _buildBadge(
                          icon: Icons.monetization_on,
                          text: '336',
                          color: const Color(0xFF00BCD4),
                        ),

                        // Center: Avatar + Name
                        Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage:
                                      AssetImage(
                                        ImgAssets
                                            .userAvatar,
                                      ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 32.w,
                                    height: 32.h,
                                    decoration:
                                        const BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color:
                                              Colors.white,
                                        ),
                                    padding: EdgeInsets.all(
                                      2.w,
                                    ),
                                    child: Image.asset(
                                      ImgAssets.egyptFlag,
                                      width: 28.w,
                                      height: 28.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Ahmed Hassan',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: context
                                    .colors
                                    .textColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'ID: Rmk4C1',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greenButton,
                              ),
                            ),
                          ],
                        ),

                        // Right Badge (24 age/gender)
                        _buildBadge(
                          icon: Icons.male,
                          text: '24',
                          color: const Color(0xFF00BCD4),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildOutlinedButton(
                            icon: Icons.people_outline,
                            text: '560 Friends',
                            onTap: () {
                              context.push(
                                Routes.friendsRoute,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildOutlinedButton(
                            icon: Icons.phone_outlined,
                            text: 'Contact Info',
                            onTap: () {
                              ContactInfoBottomSheet.show(
                                context,
                                email:
                                    'ahmedhassan123@gmail.com',
                                phone: '010010001001',
                                connectedDate:
                                    'July 5, 2022',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // ═══════════════════════════════════════════════
              // HEIGHT & ADDRESS ROW
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        title: 'Height',
                        value: '183 CM',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInfoCard(
                        title: 'Address',
                        value: 'Hadyek Elmaadi',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // ═══════════════════════════════════════════════
              // ABOUT ME SECTION
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: _buildProfileCard(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About me',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.textColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Lorem Ipsum is simply a printable and proforma text typesetting industry. Lorem Ipsum was the master of the industry Standard dummy text since the fifteenth century AD.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: context.colors.textColor
                              .withOpacity(0.6),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // ═══════════════════════════════════════════════
              // SPORTS SECTION
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: _buildProfileCard(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sports',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color:
                                  context.colors.textColor,
                            ),
                          ),
                          Text(
                            'Level 60',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: context
                                  .colors
                                  .textColor
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        child: LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: Colors.grey
                              .withOpacity(0.2),
                          valueColor:
                              const AlwaysStoppedAnimation<
                                Color
                              >(Color(0xFF00BCD4)),
                          minHeight: 6.h,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Football : Goalkeeper',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colors.textColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          _buildStatItem(
                            icon: Icons
                                .sports_soccer_outlined,
                            text: '53 Matches',
                          ),
                          SizedBox(width: 16.w),
                          _buildStatItem(
                            icon:
                                Icons.emoji_events_outlined,
                            text: '13 Tournament',
                          ),
                          SizedBox(width: 16.w),
                          _buildStatItem(
                            icon: Icons.sports_outlined,
                            text: '15 Organized',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // ═══════════════════════════════════════════════
              // MY TEAMS SECTION
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: InkWell(
                  onTap: () {
                    context.push(Routes.myTeamRoute);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: _buildProfileCard(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Teams',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'This teams to join the tournaments',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: context.colors.textColor
                                .withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildTeamItem(),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // REUSABLE WIDGETS
  // ═══════════════════════════════════════════════

  Widget _buildBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.w, color: Colors.white),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20.w, color: Colors.black87),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.w, color: Colors.black54),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamItem() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundImage: AssetImage(ImgAssets.team3),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Team Name',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Football team',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: MyColors.greenButton,
                ),
              ),
            ],
          ),
        ),
        // Overlapping Avatars
        SizedBox(
          width: 80.w,
          height: 32.h,
          child: Stack(
            children: [
              ...List.generate(3, (index) {
                return Positioned(
                  left: index * 20.0.w,
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          ImgAssets.userAvatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
              Positioned(
                left: 60.w,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[700],
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+6',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
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
        Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Colors.black38,
        ),
      ],
    );
  }
}
