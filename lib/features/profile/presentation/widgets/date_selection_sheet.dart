import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class DateSelectionSheet extends StatefulWidget {
  final DateTime? initialDate;

  const DateSelectionSheet({
    super.key,
    this.initialDate,
  });

  @override
  State<DateSelectionSheet> createState() => _DateSelectionSheetState();
}

class _DateSelectionSheetState extends State<DateSelectionSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime(1993, 10, 16);
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
                'Date of Birth',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Date Picker Container (Cupertino Style)
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumYear: 1950,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
                backgroundColor: const Color(0xFFF5F7F9),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Save Changes Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Return selected date and close sheet
                Navigator.pop(context, _selectedDate);
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
                'Save Changes',
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
