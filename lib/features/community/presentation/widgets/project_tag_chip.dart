import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class ProjectTagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onDeleted;

  const ProjectTagChip({
    super.key,
    required this.label,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h12v8,
      decoration: BoxDecoration(
        color: MyColors.greenButton.withValues(alpha: AppDimens.opacity1),
        borderRadius: AppRadius.r20,
        border: Border.all(
          color: MyColors.greenButton,
          width: AppDimens.borderWidth1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyles.medium13(color: MyColors.greenButton),
          ),
          if (onDeleted != null) ...[
            SizedBox(width: AppDimens.w6),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                Icons.close,
                size: AppDimens.iconSize16,
                color: MyColors.greenButton,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
