import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/community/presentation/widgets/help_areas_sheet.dart';

class PostTypeSelectionSheet extends StatelessWidget {
  const PostTypeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
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

          SizedBox(height: 24.h),

          // Title
          Text(
            'Create your post as',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24.h),

          // Illustration
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              ImgAssets.pana,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[100],
                  child: Icon(
                    Icons.person,
                    size: 80.sp,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 24.h),

          // Description
          Text(
            'You can create your post as a project to request experience and help others or as a usual post to interact with other players and get to know them more',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30.h),

          // Action Buttons
          Row(
            children: [
              // As Project Button (Outlined)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showHelpAreasSheet(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: MyColors.greenButton,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'As Project',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.greenButton,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // As Usual Button (Elevated)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToCreatePost(context, 'usual');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                  ),
                  child: Text(
                    'As usual',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  void _navigateToCreatePost(BuildContext context, String postType) {
    if (!context.mounted) return;
    try {
      context.push(
        Routes.createPostRoute,
        extra: {
          'postType': postType,
        },
      );
    } catch (e) {
      debugPrint('Navigation error to CreatePostView: $e');
    }
  }

  void _showHelpAreasSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      builder: (context) => const HelpAreasSheet(),
    );
  }
}
