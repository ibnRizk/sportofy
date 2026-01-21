import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class MediaAttachmentPicker extends StatelessWidget {
  final VoidCallback? onPhotoVideoTap;
  final VoidCallback? onCameraTap;

  const MediaAttachmentPicker({
    super.key,
    this.onPhotoVideoTap,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border(
          top: BorderSide(
            color: MyColors.grey200,
            width: AppDimens.borderWidth1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Photo / Video Option
          ListTile(
            contentPadding: AppPadding.h20v8,
            leading: Icon(
              Icons.photo_library_outlined,
              size: AppDimens.iconSize24,
              color: MyColors.black87,
            ),
            title: Text(
              'Photo / Video',
              style: TextStyles.medium16(color: MyColors.black87),
            ),
            onTap: onPhotoVideoTap,
          ),
          // Divider
          Divider(
            height: AppDimens.dividerThickness1,
            thickness: AppDimens.dividerThickness1,
            color: MyColors.grey200,
            indent: AppDimens.w20,
            endIndent: AppDimens.w20,
          ),
          // Camera Option
          ListTile(
            contentPadding: AppPadding.h20v8,
            leading: Icon(
              Icons.camera_alt_outlined,
              size: AppDimens.iconSize24,
              color: MyColors.black87,
            ),
            title: Text(
              'Camera',
              style: TextStyles.medium16(color: MyColors.black87),
            ),
            onTap: onCameraTap,
          ),
        ],
      ),
    );
  }
}
