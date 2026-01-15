import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  // State Variables
  int _selectedDurationIndex = 0; // Default: "60 minutes"
  RangeValues _priceRange = const RangeValues(10, 100);
  List<bool> _selectedStadiumTypes = [
    false, // 5 X 5 stadiums
    false, // 6 X 6 stadiums
    false, // 11 X 11 stadiums
    false, // Indoor stadiums
    false, // Opening stadiums
  ];

  final List<String> _durations = [
    '60 minutes',
    '90 minutes',
    '120 minutes',
  ];

  final List<String> _stadiumTypes = [
    '5 X 5 stadiums',
    '6 X 6 stadiums',
    '11 X 11 stadiums',
    'Indoor stadiums',
    'Opening stadiums',
  ];

  void _clearAll() {
    setState(() {
      _selectedDurationIndex = 0;
      _priceRange = const RangeValues(10, 100);
      _selectedStadiumTypes = List.filled(_stadiumTypes.length, false);
    });
  }

  void _applyFilters() {
    Navigator.pop(context);
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
                  'Filter',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Match Duration Section
                  _buildMatchDurationSection(),

                  Divider(height: 32.h, color: Colors.grey[300]),

                  // Price Range Section
                  _buildPriceRangeSection(),

                  Divider(height: 32.h, color: Colors.grey[300]),

                  // Type of Stadium Section
                  _buildStadiumTypesSection(),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Footer Actions
          _buildFooter(),
        ],
      ),
    );
  }

  // Match Duration Section
  Widget _buildMatchDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Match duration',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: _durations.asMap().entries.map((entry) {
            final index = entry.key;
            final duration = entry.value;
            final isSelected = _selectedDurationIndex == index;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < _durations.length - 1 ? 8.w : 0,
                ),
                child: _DurationButton(
                  label: duration,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedDurationIndex = index;
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Price Range Section
  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_priceRange.start.toInt()} EGP',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '${_priceRange.end.toInt()} EGP',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        RangeSlider(
          values: _priceRange,
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
          min: 10,
          max: 100,
          activeColor: MyColors.greenButton,
          inactiveColor: Colors.grey[300],
        ),
      ],
    );
  }

  // Type of Stadium Section
  Widget _buildStadiumTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type of stadium',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        ...List.generate(
          _stadiumTypes.length,
          (index) => _StadiumTypeCheckbox(
            label: _stadiumTypes[index],
            isChecked: _selectedStadiumTypes[index],
            onChanged: (value) {
              setState(() {
                _selectedStadiumTypes[index] = value ?? false;
              });
            },
          ),
        ),
      ],
    );
  }

  // Footer Actions
  Widget _buildFooter() {
    return Container(
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
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Duration Button Widget
class _DurationButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DurationButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? MyColors.greenButton
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? MyColors.greenButton
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}

// Stadium Type Checkbox Widget
class _StadiumTypeCheckbox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const _StadiumTypeCheckbox({
    required this.label,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      value: isChecked,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: EdgeInsets.zero,
      activeColor: MyColors.greenButton,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
