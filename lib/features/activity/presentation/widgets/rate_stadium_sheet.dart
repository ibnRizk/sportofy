import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class RateStadiumSheet extends StatefulWidget {
  const RateStadiumSheet({super.key});

  @override
  State<RateStadiumSheet> createState() =>
      _RateStadiumSheetState();
}

class _RateStadiumSheetState
    extends State<RateStadiumSheet> {
  int _selectedRating =
      4; // Default to 4 stars as shown in image
  final TextEditingController _commentController =
      TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h20v16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top25,
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
            'What is your experience?',
            style: TextStyles.bold18(color: MyColors.black),
          ),

          SizedBox(height: AppDimens.h8),

          // Subtitle
          Text(
            'Your feedback will help improve our service',
            style: TextStyles.regular14(
              color: MyColors.grey600,
            ),
          ),

          SizedBox(height: AppDimens.h24),

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
                  padding: AppPadding.h4,
                  child: Icon(
                    Icons.star,
                    size: AppDimens.iconSize48,
                    color: index < _selectedRating
                        ? MyColors
                              .amber // Yellow/Gold
                        : MyColors.grey300,
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: AppDimens.h24),

          // Comment TextField
          Container(
            decoration: BoxDecoration(
              color: MyColors.grey100,
              borderRadius: AppRadius.r12,
              border: Border.all(
                color: MyColors.grey300,
                width: AppDimens.borderWidth1,
              ),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Additional comments...',
                hintStyle: TextStyles.regular14(
                  color: MyColors.grey400,
                ),
                border: InputBorder.none,
                contentPadding: AppPadding.p16,
              ),
              style: TextStyles.regular14(
                color: MyColors.black87,
              ),
            ),
          ),

          SizedBox(height: AppDimens.h24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed:
                  (_selectedRating > 0 ||
                      _commentController.text
                          .trim()
                          .isNotEmpty)
                  ? () {
                      // Close this sheet and return the rating data
                      Navigator.pop(context, {
                        'rating': _selectedRating,
                        'comment': _commentController.text,
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (_selectedRating > 0 ||
                        _commentController.text
                            .trim()
                            .isNotEmpty)
                    ? MyColors.greenButton
                    : MyColors.grey300,
                foregroundColor: MyColors.white,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r10,
                ),
                elevation: AppDimens.elevation0,
              ),
              child: Text(
                'Submit Review',
                style: TextStyles.bold16(
                  color: MyColors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: AppDimens.h20),
        ],
      ),
    );
  }
}
