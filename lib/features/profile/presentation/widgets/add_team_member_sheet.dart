import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/profile/presentation/widgets/add_position_sheet.dart';

class AddTeamMemberSheet extends StatefulWidget {
  const AddTeamMemberSheet({super.key});

  @override
  State<AddTeamMemberSheet> createState() => _AddTeamMemberSheetState();
}

class _AddTeamMemberSheetState extends State<AddTeamMemberSheet> {
  // Mock selected members (showing 1 member to demonstrate UI)
  final List<Map<String, String>> _selectedMembers = [
    {
      'name': 'Mohamed',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '', // Will use default
    },
  ];

  // Mock all members data
  final List<Map<String, String>> _allMembers = [
    {
      'name': 'Mohamed Ameen',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '',
    },
    {
      'name': 'Hany Adel',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '',
    },
    {
      'name': 'Hany Adel',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '',
    },
    {
      'name': 'Hany Adel',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '',
    },
    {
      'name': 'Hany Adel',
      'id': 'ID:123kj',
      'phone': '01001001010',
      'avatar': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          ),
        ),
        child: Column(
          children: [
            // Drag Handle
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Header (Back Button + Title)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Add Team Member',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Search Row (Search Field + Position Filter)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    child: Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  // Position Filter Button
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const AddPositionSheet(),
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Position',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Selected Members (Horizontal List)
            if (_selectedMembers.isNotEmpty) ...[
              SizedBox(
                height: 80.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedMembers.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final member = _selectedMembers[index];
                    return _SelectedMemberItem(
                      name: member['name']!,
                      onRemove: () {
                        setState(() {
                          _selectedMembers.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),
            ],

            // All Members List (Vertical, Scrollable)
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: _allMembers.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1.h,
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                itemBuilder: (context, index) {
                  final member = _allMembers[index];
                  return _MemberTile(
                    name: member['name']!,
                    id: member['id']!,
                    phone: member['phone']!,
                    onTap: () {
                      // Mock selection behavior
                      setState(() {
                        if (!_selectedMembers.any((m) => m['name'] == member['name'])) {
                          _selectedMembers.add(member);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            // Footer Button (Sticky at Bottom)
            Container(
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
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: _selectedMembers.isNotEmpty
                        ? () {
                            // Return selected members and close
                            Navigator.pop(context, _selectedMembers);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMembers.isNotEmpty
                          ? MyColors.greenButton
                          : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: Text(
                      'Add Member',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: _selectedMembers.isNotEmpty
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                    ),
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

/// Private widget for selected member item (horizontal)
class _SelectedMemberItem extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;

  const _SelectedMemberItem({
    required this.name,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(ImgAssets.userAvatar),
            ),
            // Remove button (X icon)
            Positioned(
              top: -4.h,
              right: -4.w,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black87,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        // Name
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

/// Private widget for member tile (vertical list)
class _MemberTile extends StatelessWidget {
  final String name;
  final String id;
  final String phone;
  final VoidCallback onTap;

  const _MemberTile({
    required this.name,
    required this.id,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(ImgAssets.userAvatar),
            ),

            SizedBox(width: 12.w),

            // Name and Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name ( $id )',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
