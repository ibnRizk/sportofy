import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class GenderSelectionSheet extends StatefulWidget {
  final String? initialGender;

  const GenderSelectionSheet({
    super.key,
    this.initialGender,
  });

  @override
  State<GenderSelectionSheet> createState() => _GenderSelectionSheetState();
}

class _GenderSelectionSheetState extends State<GenderSelectionSheet> {
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender ?? 'Male';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
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

          SizedBox(height: 16.h),

          // Header (Back Button + Title)
          Row(
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
                'Gender',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Male Option
          _GenderTile(
            label: 'Male',
            icon: Icons.male,
            isSelected: _selectedGender == 'Male',
            onTap: () {
              setState(() {
                _selectedGender = 'Male';
              });
              // Return selected gender and close sheet
              Future.delayed(const Duration(milliseconds: 200), () {
                if (mounted) {
                  Navigator.pop(context, 'Male');
                }
              });
            },
          ),

          // Divider
          Divider(
            height: 1.h,
            thickness: 1,
            color: Colors.grey[300],
          ),

          // Female Option
          _GenderTile(
            label: 'Female',
            icon: Icons.female,
            isSelected: _selectedGender == 'Female',
            onTap: () {
              setState(() {
                _selectedGender = 'Female';
              });
              // Return selected gender and close sheet
              Future.delayed(const Duration(milliseconds: 200), () {
                if (mounted) {
                  Navigator.pop(context, 'Female');
                }
              });
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

/// Private reusable widget for each gender option
class _GenderTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? MyColors.greenButton : Colors.transparent,
                border: Border.all(
                  color: isSelected ? MyColors.greenButton : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),

            SizedBox(width: 16.w),

            // Gender Icon
            Icon(
              icon,
              size: 24.sp,
              color: Colors.black87,
            ),

            SizedBox(width: 12.w),

            // Label Text
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
