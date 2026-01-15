import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class TeamMembersView extends StatefulWidget {
  const TeamMembersView({super.key});

  @override
  State<TeamMembersView> createState() => _TeamMembersViewState();
}

class _TeamMembersViewState extends State<TeamMembersView> {
  String _selectedAgeGroup = 'ALL';

  // Mock team members data
  final List<Map<String, String>> _teamMembers = [
    {
      'name': 'Mohamed Abdallah',
      'avatar': ImgAssets.mohamedAhmed,
    },
    {
      'name': 'Alaa Youssef',
      'avatar': ImgAssets.salahMostafa,
    },
    {
      'name': 'Hany Adel',
      'avatar': ImgAssets.userAvatar,
    },
    {
      'name': 'Mahmoud Mohamed',
      'avatar': ImgAssets.mohamedAhmed,
    },
    {
      'name': 'Mahmoud Mohamed',
      'avatar': ImgAssets.salahMostafa,
    },
    {
      'name': 'Mahmoud Mohamed',
      'avatar': ImgAssets.userAvatar,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () {
            if (!context.mounted) return;
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'The Team',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Age Group Filter Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Row(
              children: [
                // Group Icon
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.people,
                    size: 18.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 12.w),
                // Age Group Text
                Text(
                  'Age Group : ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  _selectedAgeGroup,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Team Members List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _teamMembers.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[300],
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final member = _teamMembers[index];
                return _buildMemberRow(member);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberRow(Map<String, String> member) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage(member['avatar']!),
          ),
          SizedBox(width: 16.w),
          // Name
          Expanded(
            child: Text(
              member['name']!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Chat Icon Button
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.blue[700],
                size: 20.sp,
              ),
              onPressed: () {
                // TODO: Implement chat functionality
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
