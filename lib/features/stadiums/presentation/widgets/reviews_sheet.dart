import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';

class ReviewsSheet extends StatelessWidget {
  const ReviewsSheet({super.key});

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
                  'Reviews',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                // Aggregate Rating
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '4.87',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reviews List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              itemCount: _reviews.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[300],
              ),
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return _ReviewItem(
                  name: review['name'] as String,
                  rating: review['rating'] as String,
                  comment: review['comment'] as String?,
                );
              },
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  // Mock Data matching the image
  static const List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Hussain Alghazal',
      'rating': '2/5',
      'comment': null,
    },
    {
      'name': 'Mahmoud Hassan',
      'rating': '4/5',
      'comment': 'amazing and clean stadium',
    },
    {
      'name': 'Hussain Alghazal',
      'rating': '2/5',
      'comment': null,
    },
    {
      'name': 'Mahmoud Hassan',
      'rating': '4/5',
      'comment': 'amazing and clean stadium',
    },
    {
      'name': 'Hussain Alghazal',
      'rating': '2/5',
      'comment': null,
    },
    {
      'name': 'Mahmoud Hassan',
      'rating': '4/5',
      'comment': 'amazing and clean stadium',
    },
    {
      'name': 'Hussain Alghazal',
      'rating': '2/5',
      'comment': null,
    },
  ];
}

// Review Item Widget
class _ReviewItem extends StatelessWidget {
  final String name;
  final String rating;
  final String? comment;

  const _ReviewItem({
    required this.name,
    required this.rating,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.grey[200],
            backgroundImage: AssetImage(ImgAssets.userAvatar),
            onBackgroundImageError: (exception, stackTrace) {},
            child: Icon(
              Icons.person,
              size: 30.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 12.w),

          // Name and Comment
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (comment != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    comment!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Rating
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                rating,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
