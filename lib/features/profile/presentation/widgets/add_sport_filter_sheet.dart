import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class AddSportFilterSheet extends StatefulWidget {
  final List<String>? initialSelectedSports;

  const AddSportFilterSheet({
    super.key,
    this.initialSelectedSports,
  });

  @override
  State<AddSportFilterSheet> createState() => _AddSportFilterSheetState();
}

class _AddSportFilterSheetState extends State<AddSportFilterSheet> {
  // Hardcoded sports list
  final List<String> _allSports = [
    'Football',
    'Basketball',
    'Padel',
    'Volleyball',
    'Tennis',
    'Squash',
  ];

  // Selected sports state
  late List<String> _selectedSports;

  @override
  void initState() {
    super.initState();
    // Pre-select Football, Basketball, and Tennis to match screenshot
    _selectedSports = widget.initialSelectedSports ??
        ['Football', 'Basketball', 'Tennis'];
  }

  void _toggleSport(String sport) {
    setState(() {
      if (_selectedSports.contains(sport)) {
        _selectedSports.remove(sport);
      } else {
        _selectedSports.add(sport);
      }
    });
  }

  void _clearAll() {
    setState(() {
      _selectedSports.clear();
    });
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
                'Add Sport',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Sports List with Checkboxes
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allSports.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final sport = _allSports[index];
              final isChecked = _selectedSports.contains(sport);
              return _SportCheckboxTile(
                label: sport,
                isChecked: isChecked,
                onTap: () => _toggleSport(sport),
              );
            },
          ),

          SizedBox(height: 20.h),

          // Footer (Divider + Clear All + Add Button)
          Column(
            children: [
              Divider(
                height: 1.h,
                thickness: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    // Clear All Button
                    InkWell(
                      onTap: _clearAll,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greenButton,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Add Button
                    SizedBox(
                      width: 120.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Return selected sports and close sheet
                          Navigator.pop(context, _selectedSports);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.greenButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ],
      ),
    );
  }
}

/// Private widget for each sport checkbox tile
class _SportCheckboxTile extends StatelessWidget {
  final String label;
  final bool isChecked;
  final VoidCallback onTap;

  const _SportCheckboxTile({
    required this.label,
    required this.isChecked,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sport Label (Left)
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            // Custom Checkbox (Right)
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: isChecked ? MyColors.greenButton : Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: isChecked ? MyColors.greenButton : Colors.grey,
                  width: 2,
                ),
              ),
              child: isChecked
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
