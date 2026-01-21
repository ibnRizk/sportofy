import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class AttachmentPanel extends StatelessWidget {
  final VoidCallback? onAttachmentTap;
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onGifTap;

  const AttachmentPanel({
    super.key,
    this.onAttachmentTap,
    this.onCameraTap,
    this.onGalleryTap,
    this.onGifTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h20v16,
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border(
          top: BorderSide(
            color: MyColors.grey300,
            width: AppDimens.borderWidth1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAttachmentItem(
            icon: Icons.attach_file,
            label: 'Attachment',
            onTap: onAttachmentTap,
          ),
          _buildAttachmentItem(
            icon: Icons.camera_alt,
            label: 'Camera',
            onTap: onCameraTap,
          ),
          _buildAttachmentItem(
            icon: Icons.photo_library,
            label: 'Gallery',
            onTap: onGalleryTap,
          ),
          _buildAttachmentItem(
            icon: null,
            label: 'GIF',
            isGif: true,
            onTap: onGifTap,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem({
    IconData? icon,
    required String label,
    bool isGif = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: AppDimens.avatarSize56,
            height: AppDimens.avatarSize56,
            decoration: BoxDecoration(
              color: MyColors.grey100,
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColors.grey300,
                width: AppDimens.borderWidth1,
              ),
            ),
            child: Center(
              child: isGif
                  ? Text(
                      'GIF',
                      style: TextStyles.bold12(color: MyColors.black87),
                    )
                  : Icon(
                      icon,
                      size: AppDimens.iconSize24,
                      color: MyColors.black87,
                    ),
            ),
          ),
          SizedBox(height: AppDimens.h8),
          Text(
            label,
            style: TextStyles.regular12(color: MyColors.black87),
          ),
        ],
      ),
    );
  }
}
