import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/community/presentation/widgets/help_areas_sheet.dart';

class PostTypeSelectionSheet extends StatelessWidget {
  const PostTypeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h20v30,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: AppDimens.w40,
            height: AppDimens.h4,
            decoration: BoxDecoration(
              color: MyColors.grey300,
              borderRadius: AppRadius.r2,
            ),
          ),

          SizedBox(height: AppDimens.h24),

          // Title
          Text(
            'Create your post as',
            style: TextStyles.medium18(
              color: MyColors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppDimens.h24),

          // Illustration
          Container(
            height: AppDimens.containerHeight200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: AppRadius.r12,
            ),
            child: Image.asset(
              "assets/images/create_post.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: MyColors.grey100,
                  child: Icon(
                    Icons.person,
                    size: AppDimens.iconSize50,
                    color: MyColors.grey400,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: AppDimens.h24),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Text(
              'You can create your post as a project to request experience and help others or as a usual post to interact with other players and get to know them more',
              style: TextStyles.regular16(
                color: MyColors.darkGrayColor,
              ).copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: AppDimens.h30),

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
                      width: AppDimens.borderWidth1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r12,
                    ),
                    padding: AppPadding.v14,
                  ),
                  child: Text(
                    'As Project',
                    style: TextStyles.bold16(
                      color: MyColors.greenButton,
                    ),
                  ),
                ),
              ),

              SizedBox(width: AppDimens.w16),

              // As Usual Button (Elevated)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToCreatePost(context, 'usual');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: MyColors.white,
                    disabledBackgroundColor:
                        MyColors.grey300,
                    disabledForegroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r12,
                    ),
                    padding: AppPadding.v14,
                    elevation: 0,
                  ),
                  child: Text(
                    'As usual',
                    style: TextStyles.bold16(),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h20),
        ],
      ),
    );
  }

  void _navigateToCreatePost(
    BuildContext context,
    String postType,
  ) {
    if (!context.mounted) return;
    try {
      context.push(
        Routes.createPostRoute,
        extra: {'postType': postType},
      );
    } catch (e) {
      debugPrint('Navigation error to CreatePostView: $e');
    }
  }

  void _showHelpAreasSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.top30,
      ),
      builder: (context) => const HelpAreasSheet(),
    );
  }
}
