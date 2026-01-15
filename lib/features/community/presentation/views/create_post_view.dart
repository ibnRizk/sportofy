import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/community/presentation/widgets/user_header.dart';
import 'package:sportify_app/features/community/presentation/widgets/project_tag_chip.dart';
import 'package:sportify_app/features/community/presentation/widgets/media_attachment_picker.dart';

class CreatePostView extends StatefulWidget {
  final String postType; // 'project' or 'usual'
  final List<String> helpAreas; // Selected help areas for project posts

  const CreatePostView({
    super.key,
    required this.postType,
    this.helpAreas = const [],
  });

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _postController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _selectedPrivacy = 'Friends';
  late List<String> _helpAreas;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _helpAreas = List<String>.from(widget.helpAreas);
  }

  @override
  void dispose() {
    _postController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canPost => _postController.text.trim().isNotEmpty && !_isPosting;

  Future<void> _handlePost() async {
    if (!_canPost) return;

    setState(() {
      _isPosting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Post created successfully!',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: MyColors.greenButton,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate back
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _showPrivacyOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPrivacyOption(context, 'Public', Icons.public),
            _buildPrivacyOption(context, 'Friends', Icons.people),
            _buildPrivacyOption(context, 'Only me', Icons.lock),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyOption(
    BuildContext context,
    String option,
    IconData icon,
  ) {
    final isSelected = _selectedPrivacy == option;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? MyColors.greenButton : Colors.grey[600],
        size: 24.sp,
      ),
      title: Text(
        option,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? MyColors.greenButton : Colors.black87,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: MyColors.greenButton,
              size: 20.sp,
            )
          : null,
      onTap: () {
        setState(() {
          _selectedPrivacy = option;
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () {
            if (!context.mounted) return;
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Create Post',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          // Post Button
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(
              onPressed: _canPost ? _handlePost : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                disabledForegroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                elevation: 0,
              ),
              child: _isPosting
                  ? SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      'Post',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Header
                  UserHeader(
                    userName: 'Mohamed Abdallah',
                    userAvatar: ImgAssets.mohamedAhmed,
                    selectedPrivacy: _selectedPrivacy,
                    onPrivacyTap: _showPrivacyOptions,
                  ),

                  // Project Tags (Help Areas) - Only for project posts
                  if (widget.postType == 'project' && _helpAreas.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _helpAreas.map((area) {
                        return ProjectTagChip(
                          label: area,
                          onDeleted: () {
                            setState(() {
                              _helpAreas.remove(area);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // Post Input Area
                  TextField(
                    controller: _postController,
                    focusNode: _focusNode,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'What is in your mind ?',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Rebuild to update Post button state
                    },
                  ),
                ],
              ),
            ),
          ),

          // Media Attachment Picker (Always visible at bottom)
          MediaAttachmentPicker(
            onPhotoVideoTap: () {
              // TODO: Implement photo/video picker
              debugPrint('Photo/Video tapped');
            },
            onCameraTap: () {
              // TODO: Implement camera
              debugPrint('Camera tapped');
            },
          ),
        ],
      ),
    );
  }
}
