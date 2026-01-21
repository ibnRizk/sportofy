import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/community/presentation/widgets/user_header.dart';
import 'package:sportify_app/features/community/presentation/widgets/project_tag_chip.dart';
import 'package:sportify_app/features/community/presentation/widgets/media_attachment_picker.dart';

class CreatePostView extends StatefulWidget {
  final String postType; // 'project' or 'usual'
  final List<String>
  helpAreas; // Selected help areas for project posts

  const CreatePostView({
    super.key,
    required this.postType,
    this.helpAreas = const [],
  });

  @override
  State<CreatePostView> createState() =>
      _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _postController =
      TextEditingController();
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

  bool get _canPost =>
      _postController.text.trim().isNotEmpty && !_isPosting;

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
          style: TextStyles.medium14(),
        ),
        backgroundColor: MyColors.greenButton,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.r8,
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
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.top20,
      ),
      builder: (context) => Container(
        padding: AppPadding.v20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPrivacyOption(
              context,
              'Public',
              Icons.public,
            ),
            _buildPrivacyOption(
              context,
              'Friends',
              Icons.people,
            ),
            _buildPrivacyOption(
              context,
              'Only me',
              Icons.lock,
            ),
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
        color: isSelected
            ? MyColors.greenButton
            : MyColors.grey600,
        size: AppDimens.iconSize24,
      ),
      title: Text(
        option,
        style: isSelected
            ? TextStyles.semiBold16(color: MyColors.greenButton)
            : TextStyles.regular16(color: MyColors.black87),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: MyColors.greenButton,
              size: AppDimens.iconSize20,
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
      backgroundColor: MyColors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.black,
            size: AppDimens.iconSize24,
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
          style: TextStyles.bold18(color: MyColors.black87),
        ),
        centerTitle: true,
        actions: [
          // Post Button
          Padding(
            padding: AppPadding.right16,
            child: ElevatedButton(
              onPressed: _canPost ? _handlePost : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: MyColors.white,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.grey600,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r8,
                ),
                padding: AppPadding.h16v8,
                elevation: 0,
              ),
              child: _isPosting
                  ? SizedBox(
                      width: AppDimens.w16,
                      height: AppDimens.h16,
                      child: CircularProgressIndicator(
                        strokeWidth: AppDimens.borderWidth2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(
                              MyColors.white,
                            ),
                      ),
                    )
                  : Text(
                      'Post',
                      style: TextStyles.semiBold14(),
                    ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppPadding.h20v16,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // User Header
                  UserHeader(
                    userName: 'Mohamed Abdallah',
                    userAvatar: ImgAssets.mohamedAhmed,
                    selectedPrivacy: _selectedPrivacy,
                    onPrivacyTap: _showPrivacyOptions,
                  ),

                  // Project Tags (Help Areas) - Only for project posts
                  if (widget.postType == 'project' &&
                      _helpAreas.isNotEmpty) ...[
                    SizedBox(height: AppDimens.h20),
                    Wrap(
                      spacing: AppDimens.w8,
                      runSpacing: AppDimens.h8,
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

                  SizedBox(height: AppDimens.h24),

                  // Post Input Area
                  TextField(
                    controller: _postController,
                    focusNode: _focusNode,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyles.regular16(color: MyColors.black87),
                    decoration: InputDecoration(
                      hintText: 'What is in your mind ?',
                      hintStyle: TextStyles.regular16(color: MyColors.grey600),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: AppPadding.zero,
                    ),
                    onChanged: (value) {
                      setState(
                        () {},
                      ); // Rebuild to update Post button state
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
