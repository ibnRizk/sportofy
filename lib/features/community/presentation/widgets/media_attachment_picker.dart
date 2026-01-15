import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Photo / Video Option
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 8.h,
            ),
            leading: Icon(
              Icons.photo_library_outlined,
              size: 24.sp,
              color: Colors.black87,
            ),
            title: Text(
              'Photo / Video',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            onTap: onPhotoVideoTap,
          ),
          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: 20.w,
            endIndent: 20.w,
          ),
          // Camera Option
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 8.h,
            ),
            leading: Icon(
              Icons.camera_alt_outlined,
              size: 24.sp,
              color: Colors.black87,
            ),
            title: Text(
              'Camera',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            onTap: onCameraTap,
          ),
        ],
      ),
    );
  }
}
