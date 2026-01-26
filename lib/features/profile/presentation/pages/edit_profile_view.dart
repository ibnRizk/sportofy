import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/location/presentation/views/detect_location_view.dart';
import 'package:sportify_app/features/profile/presentation/widgets/add_sport_filter_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/add_team_member_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/date_selection_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/edit_profile/profile_field.dart';
import 'package:sportify_app/features/profile/presentation/widgets/edit_profile/section_title.dart';
import 'package:sportify_app/features/profile/presentation/widgets/edit_profile/team_member_tile.dart';
import 'package:sportify_app/features/profile/presentation/widgets/gender_selection_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/image_picker_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/position_selection_sheet.dart';
import 'package:sportify_app/features/profile/presentation/widgets/sport_selection_sheet.dart';
import 'package:sportify_app/features/booking/presentation/widgets/audience_sheet.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController
  _descriptionController = TextEditingController(
    text:
        'Lorem Ipsum is simply a printable and proforma text typesetting industry. Lorem Ipsum was the master of the industry Standard dummy text since the fifteenth century AD.',
  );
  String _selectedAudience = 'Friends';

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 24.w,
            color: Colors.black87,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // ═══════════════════════════════════════════════
            // PROFILE IMAGE HEADER
            // ═══════════════════════════════════════════════
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: AssetImage(
                      ImgAssets.userAvatar,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              Colors.transparent,
                          builder: (context) =>
                              const ImagePickerSheet(),
                        );
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.greenButton,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // ═══════════════════════════════════════════════
                  // BASIC INFORMATION
                  // ═══════════════════════════════════════════════
                  const SectionTitle(
                    title: 'Basic information',
                  ),
                  SizedBox(height: 12.h),

                  // Row 1: Full name & Height
                  Row(
                    children: [
                      Expanded(
                        child: ProfileField(
                          title: 'Full name',
                          value: 'Ahmed Hassan',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ProfileField(
                          title: 'Height',
                          value: '183 CM',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Row 2: Gender & Date of Birth
                  Row(
                    children: [
                      Expanded(
                        child: ProfileField(
                          title: 'Gender',
                          value: 'Male',
                          isSelector: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor:
                                  Colors.transparent,
                              builder: (context) =>
                                  const GenderSelectionSheet(
                                    initialGender: 'Male',
                                  ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ProfileField(
                          title: 'Date of Birth',
                          value: '13 Jan 1996',
                          isSelector: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  Colors.transparent,
                              builder: (context) =>
                                  DateSelectionSheet(
                                    initialDate: DateTime(
                                      1996,
                                      1,
                                      13,
                                    ),
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Location
                  ProfileField(
                    title: 'Location',
                    value: 'Hadyek Elmaadi',
                    isSelector: true,
                    leadingIcon: Image.asset(
                      ImgAssets.egyptFlag,
                      width: 20.w,
                      height: 20.h,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const DetectLocationView(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 24.h),

                  // ═══════════════════════════════════════════════
                  // SELF-DESCRIPTION
                  // ═══════════════════════════════════════════════
                  const SectionTitle(
                    title: 'Self-description',
                  ),
                  SizedBox(height: 12.h),

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                      border: Border.all(
                        color: Colors.grey.withValues(
                          alpha: 0.2,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller:
                              _descriptionController,
                          maxLines: 4,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            hintText:
                                'Write about yourself...',
                          ),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${_descriptionController.text.length}/1000',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: MyColors.darkGrayColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ═══════════════════════════════════════════════
                  // CONTACT INFO
                  // ═══════════════════════════════════════════════
                  const SectionTitle(title: 'Contact Info'),
                  SizedBox(height: 12.h),

                  // Phone
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                      border: Border.all(
                        color: Colors.grey.withValues(
                          alpha: 0.2,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight:
                                      FontWeight.w400,
                                  color: MyColors
                                      .darkGrayColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '010010001001',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result =
                                await showModalBottomSheet<
                                  String
                                >(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor:
                                      Colors.transparent,
                                  builder: (context) =>
                                      AudienceSheet(
                                        selected:
                                            _selectedAudience,
                                      ),
                                );
                            if (result != null && mounted) {
                              setState(() {
                                _selectedAudience = result;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    MyColors.darkGrayColor,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                    6.r,
                                  ),
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 14.w,
                                  color: MyColors
                                      .darkGrayColor,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _selectedAudience,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: MyColors
                                        .darkGrayColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 16.w,
                                  color: MyColors
                                      .darkGrayColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Email Address
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        border: Border.all(
                          color: Colors.grey.withValues(
                            alpha: 0.2,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: MyColors.darkGrayColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'ahmedhassan123@gmail.com',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ═══════════════════════════════════════════════
                  // SPORTS
                  // ═══════════════════════════════════════════════
                  const SectionTitle(title: 'Sports'),
                  SizedBox(height: 12.h),

                  // Sport & Position Cards (Two Separate Boxes)
                  Row(
                    children: [
                      // Sport Field (Separate Container)
                      Expanded(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor:
                                      Colors.transparent,
                                  builder: (context) =>
                                      const SportSelectionSheet(
                                        initialSport:
                                            'Football',
                                      ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                  16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(
                                        10.r,
                                      ),
                                  border: Border.all(
                                    color: Colors.grey
                                        .withValues(
                                          alpha: 0.2,
                                        ),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withValues(
                                            alpha: 0.03,
                                          ),
                                      blurRadius: 8,
                                      offset: const Offset(
                                        0,
                                        2,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Sport',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight:
                                            FontWeight.w400,
                                        color: MyColors
                                            .darkGrayColor,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Football',
                                            style: TextStyle(
                                              fontSize:
                                                  16.sp,
                                              fontWeight:
                                                  FontWeight
                                                      .w500,
                                              color: Colors
                                                  .black87,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons
                                              .arrow_forward_ios,
                                          size: 14.w,
                                          color: MyColors
                                              .darkGrayColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 20.w,
                                  height: 20.h,

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey
                                        .withValues(
                                          alpha: 0.2,
                                        ),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 12.w,
                                    color: MyColors
                                        .darkGrayColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 15.w),

                      // Position Field (Separate Container)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor:
                                  Colors.transparent,
                              builder: (context) =>
                                  const PositionSelectionSheet(
                                    initialPosition:
                                        'Goalkeeper',
                                  ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(
                                    10.r,
                                  ),
                              border: Border.all(
                                color: Colors.grey
                                    .withValues(alpha: 0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(
                                        alpha: 0.03,
                                      ),
                                  blurRadius: 8,
                                  offset: const Offset(
                                    0,
                                    2,
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Position',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight:
                                        FontWeight.w400,
                                    color: MyColors
                                        .darkGrayColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Goalkeeper',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight:
                                              FontWeight
                                                  .w500,
                                          color: Colors
                                              .black87,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons
                                          .arrow_forward_ios,
                                      size: 14.w,
                                      color: MyColors
                                          .darkGrayColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Add Sport Button
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            const AddSportFilterSheet(),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      size: 18.w,
                      color: MyColors.greenButton,
                    ),
                    label: Text(
                      'Add sport',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.greenButton,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ═══════════════════════════════════════════════
                  // MY TEAM
                  // ═══════════════════════════════════════════════
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionTitle(title: 'My Team'),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap,
                        ),
                        child: Text(
                          'Remove team',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Team Name and Photo
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                      border: Border.all(
                        color: Colors.grey.withValues(
                          alpha: 0.2,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team Name and Photo',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            // Text on LEFT
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    'Team Name',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight:
                                          FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Football team',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight:
                                          FontWeight.w400,
                                      color: MyColors
                                          .greenButton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Image on RIGHT
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage:
                                      AssetImage(
                                        ImgAssets.team3,
                                      ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 16.w,
                                    height: 16.h,
                                    decoration:
                                        BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: MyColors
                                              .greenButton,
                                        ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 10.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Team Members Grid (2 columns)
                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio:
                              3.0, // Increased to give more vertical space
                        ),
                    itemCount: _mockTeamMembers.length,
                    itemBuilder: (context, index) {
                      final member =
                          _mockTeamMembers[index];
                      return TeamMemberTile(
                        name: member['name']!,
                        role: member['role']!,
                        onRemove: () {},
                      );
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Add Member & Add New Team
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor:
                                Colors.transparent,
                            builder: (context) =>
                                const AddTeamMemberSheet(),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          size: 18.w,
                          color: MyColors.greenButton,
                        ),
                        label: Text(
                          'Add Member',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greenButton,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '16 / 20 Member',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 18.w,
                      color: MyColors.greenButton,
                    ),
                    label: Text(
                      'Add New Team',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.greenButton,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),

                  SizedBox(
                    height: 80.h,
                  ), // Space for fixed button
                ],
              ),
            ),
          ],
        ),
      ),
      // ═══════════════════════════════════════════════
      // STICKY SAVE BUTTON
      // ═══════════════════════════════════════════════
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement Save Logic
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.greenButton,
            disabledBackgroundColor: MyColors.grey300,
            disabledForegroundColor: MyColors.white,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            'Save Changes',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Mock Team Members Data
  static final List<Map<String, String>> _mockTeamMembers =
      [
        {'name': 'Mostafa Mohamed', 'role': 'Winger'},
        {'name': 'Mohamed Yousri', 'role': 'Striker'},
        {'name': 'Elsayed Ayman', 'role': 'Attacking'},
        {'name': 'Hossam Mamduh', 'role': 'Defensive'},
        {'name': 'Elsayed Ayman', 'role': 'Attacking'},
        {'name': 'Hossam Mamduh', 'role': 'Defensive'},
      ];
}
