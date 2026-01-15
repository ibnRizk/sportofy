import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class AddSportSheet extends StatefulWidget {
  const AddSportSheet({super.key});

  @override
  State<AddSportSheet> createState() => _AddSportSheetState();
}

class _AddSportSheetState extends State<AddSportSheet> {
  // All available sports
  final List<String> _allSports = [
    'Football',
    'Basketball',
    'Padel',
    'Volleyball',
    'Tennis',
    'Squash',
  ];

  // Selected sports (default: Football, Basketball, Tennis to match image)
  List<String> _selectedSports = [
    'Football',
    'Basketball',
    'Tennis',
  ];

  void _clearAll() {
    setState(() {
      _selectedSports.clear();
    });
  }

  void _addSports() {
    Navigator.pop(context, _selectedSports);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black87,
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Add Sport',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Sports List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _allSports.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final sport = _allSports[index];
                final isSelected = _selectedSports.contains(sport);

                return CheckboxListTile(
                  title: Text(
                    sport,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  value: isSelected,
                  onChanged: (bool? isChecked) {
                    setState(() {
                      if (isChecked == true) {
                        _selectedSports.add(sport);
                      } else {
                        _selectedSports.remove(sport);
                      }
                    });
                  },
                  activeColor: MyColors.greenButton,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16.h),

          // Footer
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: _clearAll,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.greenButton,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _addSports,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
