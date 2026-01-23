import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class PositionSelectionSheet extends StatefulWidget {
  final String? initialPosition;

  const PositionSelectionSheet({
    super.key,
    this.initialPosition,
  });

  @override
  State<PositionSelectionSheet> createState() => _PositionSelectionSheetState();
}

class _PositionSelectionSheetState extends State<PositionSelectionSheet> {
  late String _selectedPosition;

  // Hardcoded positions list for UI
  final List<String> _positions = [
    'Goalkeeper',
    'Attacking',
    'Striker',
    'Defensive',
    'Full - back',
    'Center - back',
  ];

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition ?? 'Goalkeeper';
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
                'Select your position',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Positions List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _positions.length,
            separatorBuilder: (context, index) => SizedBox(height: 4.h),
            itemBuilder: (context, index) {
              final position = _positions[index];
              return _PositionTile(
                name: position,
                isSelected: _selectedPosition == position,
                onTap: () {
                  setState(() {
                    _selectedPosition = position;
                  });
                },
              );
            },
          ),

          SizedBox(height: 24.h),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Return selected position and close sheet
                Navigator.pop(context, _selectedPosition);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

/// Private reusable widget for each position option
class _PositionTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _PositionTile({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        child: Row(
          children: [
            // Custom Radio Button
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

            SizedBox(width: 15.w),

            // Position Name
            Text(
              name,
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
