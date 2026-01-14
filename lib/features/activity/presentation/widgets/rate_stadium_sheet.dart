import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class RateStadiumSheet extends StatefulWidget {
  const RateStadiumSheet({super.key});

  @override
  State<RateStadiumSheet> createState() => _RateStadiumSheetState();
}

class _RateStadiumSheetState extends State<RateStadiumSheet> {
  int _selectedRating = 4; // Default to 4 stars as shown in image
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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

          SizedBox(height: 24.h),

          // Title
          Text(
            'What is your experience?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8.h),

          // Subtitle
          Text(
            'Your feedback will help improve our service',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 24.h),

          // Star Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    Icons.star,
                    size: 48.sp,
                    color: index < _selectedRating
                        ? const Color(0xFFFFC107) // Yellow/Gold
                        : Colors.grey[300],
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 24.h),

          // Comment TextField
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Additional comments...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.w),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Close this sheet and return the rating data
                Navigator.pop(context, {
                  'rating': _selectedRating,
                  'comment': _commentController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
