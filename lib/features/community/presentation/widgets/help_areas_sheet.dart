import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class HelpAreasSheet extends StatefulWidget {
  const HelpAreasSheet({super.key});

  @override
  State<HelpAreasSheet> createState() => _HelpAreasSheetState();
}

class _HelpAreasSheetState extends State<HelpAreasSheet> {
  final List<String> _allHelpAreas = ['Marketing', 'Assets', 'Fund'];
  final List<String> _selectedHelpAreas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 20.h),

          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24.sp,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(width: 12.w),
              Text(
                'Help Areas',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Options List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allHelpAreas.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey[200],
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final area = _allHelpAreas[index];
              final isSelected = _selectedHelpAreas.contains(area);

              return CheckboxListTile(
                title: Text(
                  area,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                value: isSelected,
                activeColor: MyColors.greenButton,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedHelpAreas.add(area);
                    } else {
                      _selectedHelpAreas.remove(area);
                    }
                  });
                },
              );
            },
          ),

          SizedBox(height: 20.h),

          // Divider
          Divider(
            height: 1,
            color: Colors.grey[200],
            thickness: 1,
          ),

          SizedBox(height: 16.h),

          // Footer Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Clear All Button
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedHelpAreas.clear();
                  });
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),

              // Add Button
              ElevatedButton(
                onPressed: () {
                  // Close sheet and navigate to CreatePostView with selected areas
                  Navigator.pop(context);
                  _navigateToCreatePost(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  void _navigateToCreatePost(BuildContext context) {
    if (!context.mounted) return;
    try {
      context.push(
        Routes.createPostRoute,
        extra: {
          'postType': 'project',
          'helpAreas': _selectedHelpAreas,
        },
      );
    } catch (e) {
      debugPrint('Navigation error to CreatePostView: $e');
    }
  }
}
