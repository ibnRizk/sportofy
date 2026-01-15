import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
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
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Center(
              child: isGif
                  ? Text(
                      'GIF',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  : Icon(
                      icon,
                      size: 24.sp,
                      color: Colors.black87,
                    ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
