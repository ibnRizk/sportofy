import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class SportSelectionSheet extends StatefulWidget {
  final String? initialSport;

  const SportSelectionSheet({
    super.key,
    this.initialSport,
  });

  @override
  State<SportSelectionSheet> createState() => _SportSelectionSheetState();
}

class _SportSelectionSheetState extends State<SportSelectionSheet> {
  late String _selectedSport;

  // Hardcoded sports list for UI
  final List<String> _sports = [
    'Football',
    'basketball',
    'Padle',
    'Volleyball',
    'Tennis',
    'Squash',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSport = widget.initialSport ?? 'Football';
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
                'Select Sport',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Sports List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sports.length,
            separatorBuilder: (context, index) => SizedBox(height: 4.h),
            itemBuilder: (context, index) {
              final sport = _sports[index];
              return _SportTile(
                name: sport,
                isSelected: _selectedSport == sport,
                onTap: () {
                  setState(() {
                    _selectedSport = sport;
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
                // Return selected sport and close sheet
                Navigator.pop(context, _selectedSport);
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

/// Private reusable widget for each sport option
class _SportTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _SportTile({
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

            // Sport Name
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
