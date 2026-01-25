import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/profile/presentation/widgets/account_settings_bottom_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/contact_info_bottom_sheet.dart';
import 'package:sportify_app/injection_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══════════════════════════════════════════════
              // FIRST CONTAINER: BLUE BACKGROUND
              // ═══════════════════════════════════════════════
              Container(
                width: double.infinity,
                height: 90.h,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.w4,
                  vertical: AppDimens.h8,
                ),
                color: Color(0xFFEBF5F8),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        size: AppDimens.iconSize24,
                        color: MyColors.black87,
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
                        size: AppDimens.iconSize24,
                        color: MyColors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // ═══════════════════════════════════════════════
              // SECOND CONTAINER: WHITE BACKGROUND WITH CONTENT
              // ═══════════════════════════════════════════════
              Container(
                padding: EdgeInsets.only(
                  top: AppDimens.h20,
                  left: AppDimens.w20,
                  right: AppDimens.w20,
                  bottom: AppDimens.h20,
                ),
                color: MyColors.white,
                child: Column(
                  children: [
                    // Badges Row
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBadge(
                          icon: Icons.monetization_on,
                          text: '336',
                          color: Color(0xFF3C9BBE),
                        ),
                        _buildBadge(
                          icon: Icons.male,
                          text: '24',
                          color: Color(0xFF3C9BBE),
                        ),
                      ],
                    ),

                    SizedBox(height: AppDimens.h12),

                    // Profile Name and ID
                    Text(
                      'Ahmed Hassan',
                      style: TextStyles.bold18(
                        color: MyColors.black87,
                      ),
                    ),
                    SizedBox(height: AppDimens.h4),
                    Text(
                      'ID: Rmk4C1',
                      style: TextStyles.regular12(
                        color: MyColors.greenButton,
                      ),
                    ),

                    SizedBox(height: AppDimens.h20),

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
                        SizedBox(width: AppDimens.w12),
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

                    SizedBox(height: AppDimens.h12),
                  ],
                ),
              ),

              SizedBox(height: AppDimens.h12),

              // ═══════════════════════════════════════════════
              // HEIGHT & ADDRESS ROW (After Second Container)
              // ═══════════════════════════════════════════════
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.w20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        title: 'Height',
                        value: '183 CM',
                      ),
                    ),
                    SizedBox(width: AppDimens.w12),
                    Expanded(
                      child: _buildInfoCard(
                        title: 'Address',
                        value: 'Hadyek Elmaadi',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppDimens.h12),

              // ═══════════════════════════════════════════════
              // REST OF CONTENT SECTION
              // ═══════════════════════════════════════════════
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.w20,
                ),
                color: Color(0xFFf6f6f6),
                child: Column(
                  children: [
                    // ═══════════════════════════════════════════════
                    // ABOUT ME SECTION
                    // ═══════════════════════════════════════════════
                    _buildProfileCard(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About me',
                            style: TextStyles.semiBold16(
                              color:
                                  context.colors.textColor,
                            ),
                          ),
                          SizedBox(height: AppDimens.h12),
                          Text(
                            'Lorem Ipsum is simply a printable and proforma text typesetting industry. Lorem Ipsum was the master of the industry Standard dummy text since the fifteenth century AD.',
                            style: TextStyles.regular14(
                              color: context
                                  .colors
                                  .textColor
                                  .withValues(
                                    alpha:
                                        AppDimens.opacity6,
                                  ),
                            ).copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppDimens.h12),

                    // ═══════════════════════════════════════════════
                    // SPORTS SECTION
                    // ═══════════════════════════════════════════════
                    _buildProfileCard(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Text(
                                'Sports',
                                style:
                                    TextStyles.semiBold16(
                                      color: context
                                          .colors
                                          .textColor,
                                    ),
                              ),
                              Text(
                                'Level 60',
                                style: TextStyles.regular12(
                                  color: context
                                      .colors
                                      .textColor
                                      .withValues(
                                        alpha: AppDimens
                                            .opacity5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppDimens.h12),
                          // Custom Progress Bar with Blue to Green Gradient
                          ClipRRect(
                            borderRadius: AppRadius.r10,
                            child: Container(
                              height: AppDimens.h6,
                              decoration: BoxDecoration(
                                color: MyColors.grey
                                    .withValues(
                                      alpha: AppDimens
                                          .opacity2,
                                    ),
                                borderRadius: AppRadius.r10,
                              ),
                              child: Stack(
                                children: [
                                  FractionallySizedBox(
                                    widthFactor: 0.6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            MyColors
                                                .blue, // Blue start
                                            MyColors
                                                .greenButton, // Green end
                                          ],
                                          begin: Alignment
                                              .centerLeft,
                                          end: Alignment
                                              .centerRight,
                                        ),
                                        borderRadius:
                                            AppRadius.r10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimens.h16),
                          Text(
                            'Football : Goalkeeper',
                            style: TextStyles.semiBold15(
                              color:
                                  context.colors.textColor,
                            ),
                          ),
                          SizedBox(height: AppDimens.h12),
                          Row(
                            children: [
                              _buildStatItem(
                                iconSvg:
                                    ImgAssets.icMatches,
                                text: '53 Matches',
                              ),
                              SizedBox(
                                width: AppDimens.w16,
                              ),
                              _buildStatItem(
                                iconSvg:
                                    ImgAssets.icTournaments,
                                text: '13 Tournament',
                              ),
                              SizedBox(
                                width: AppDimens.w16,
                              ),
                              _buildStatItem(
                                iconSvg:
                                    ImgAssets.icOrganized,
                                text: '15 Organized',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppDimens.h12),

                    // ═══════════════════════════════════════════════
                    // MY TEAMS SECTION
                    // ═══════════════════════════════════════════════
                    InkWell(
                      onTap: () {
                        context.push(Routes.myTeamRoute);
                      },
                      borderRadius: AppRadius.r12,
                      child: _buildProfileCard(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Teams',
                              style: TextStyles.semiBold16(
                                color: context
                                    .colors
                                    .textColor,
                              ),
                            ),
                            SizedBox(height: AppDimens.h4),
                            Text(
                              'This teams to join the tournaments',
                              style: TextStyles.regular10(
                                color: context
                                    .colors
                                    .textColor
                                    .withValues(
                                      alpha: AppDimens
                                          .opacity5,
                                    ),
                              ),
                            ),
                            SizedBox(height: AppDimens.h16),
                            _buildTeamItem(),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimens.h20),
                  ],
                ),
              ),
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
      padding: AppPadding.h12v6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.r20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppDimens.iconSize18,
            color: MyColors.white,
          ),
          SizedBox(width: AppDimens.w4),
          Text(
            text,
            style: TextStyles.semiBold14(
              color: MyColors.white,
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
        side: BorderSide(
          color: MyColors.grey,
          width: AppDimens.borderWidth1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.r8,
        ),
        padding: AppPadding.v12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppDimens.iconSize20,
            color: MyColors.black87,
          ),
          SizedBox(width: AppDimens.w6),
          Text(
            text,
            style: TextStyles.medium14(
              color: MyColors.black87,
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
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity03,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.semiBold16(
              color: MyColors.darkGrayColor,
            ),
          ),
          SizedBox(height: AppDimens.h8),
          Text(
            value,
            style: TextStyles.regular14(
              color: MyColors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity03,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatItem({
    required String iconSvg,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconSvg,
          width: AppDimens.iconSize18,
          height: AppDimens.iconSize18,
          colorFilter: ColorFilter.mode(
            MyColors.black54,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: AppDimens.w4),
        Text(
          text,
          style: TextStyles.regular10(
            color: MyColors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamItem() {
    return Row(
      children: [
        CircleAvatar(
          radius: AppDimens.avatarSize24,
          backgroundImage: AssetImage(ImgAssets.team3),
        ),
        SizedBox(width: AppDimens.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Team Name',
                style: TextStyles.semiBold15(
                  color: MyColors.black87,
                ),
              ),
              SizedBox(height: AppDimens.h2),
              Row(
                children: [
                  Text(
                    'Football team',
                    style: TextStyles.regular10(
                      color: MyColors.greenButton,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Overlapping Avatars
        SizedBox(
          width: AppDimens.containerWidth80,
          height: AppDimens.h32,
          child: Stack(
            children: [
              ...List.generate(3, (index) {
                return Positioned(
                  left: index * AppDimens.w20,
                  child: Container(
                    width: AppDimens.w32,
                    height: AppDimens.h32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MyColors.white,
                        width: AppDimens.borderWidth2,
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
                left: AppDimens.w60,
                child: Container(
                  width: AppDimens.w32,
                  height: AppDimens.h32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.grey700,
                    border: Border.all(
                      color: MyColors.white,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+6',
                      style: TextStyles.bold10(
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimens.w8),
        Icon(
          Icons.arrow_forward_ios,
          size: AppDimens.iconSize16,
          color: MyColors.black38,
        ),
      ],
    );
  }
}
