import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/community/presentation/widgets/comment_tile.dart';

class CommentsView extends StatefulWidget {
  final int postId;
  final String likedBy;
  final int likesCount;
  final int commentsCount;

  const CommentsView({
    super.key,
    required this.postId,
    required this.likedBy,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final TextEditingController _commentController =
      TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  // Mock comments data
  final List<Map<String, dynamic>> _comments = [
    {
      'id': '1',
      'authorName': 'Mahmoud Adel',
      'authorAvatar': ImgAssets.mohamedAhmed,
      'content':
          'Lorem Ipsum is simply a printable and proforma text typesetting industry.',
      'timestamp': '11h',
      'likesCount': 1,
      'hasPreviousReplies': true,
      'previousRepliesCount': 1,
      'replies': [
        {
          'id': '1-1',
          'authorName': 'Mahmoud Adel',
          'authorAvatar': ImgAssets.mohamedAhmed,
          'content':
              'Mahmoud Adel Lorem Ipsum is simply a pri....',
          'timestamp': '10h',
          'likesCount': 0,
        },
        {
          'id': '1-2',
          'authorName': 'Mahmoud Adel',
          'authorAvatar': ImgAssets.mohamedAhmed,
          'content':
              'Mahmoud Adel Lorem Ipsum is simply a pri....',
          'timestamp': '9h',
          'likesCount': 0,
        },
        {
          'id': '1-3',
          'authorName': 'Mahmoud Adel',
          'authorAvatar': ImgAssets.mohamedAhmed,
          'content':
              'Mahmoud Adel Lorem Ipsum is simply a pri....',
          'timestamp': '8h',
          'likesCount': 0,
        },
      ],
    },
    {
      'id': '2',
      'authorName': 'Mahmoud Adel',
      'authorAvatar': ImgAssets.salahMostafa,
      'content':
          'Lorem Ipsum is simply a printable and proforma text typesetting industry.',
      'timestamp': '11h',
      'likesCount': 1,
      'hasPreviousReplies': false,
      'previousRepliesCount': 0,
      'replies': [
        {
          'id': '2-1',
          'authorName': 'Mahmoud Adel',
          'authorAvatar': ImgAssets.mohamedAhmed,
          'content':
              'Mahmoud Adel Lorem Ipsum is simply a pri....',
          'timestamp': '10h',
          'likesCount': 0,
        },
      ],
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _sendComment() {
    if (_commentController.text.trim().isEmpty) return;

    // TODO: Implement send comment logic
    _commentController.clear();
    _commentFocusNode.unfocus();
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
          'Comments',
          style: TextStyles.bold18(color: MyColors.black87),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Interaction Summary Row
          _buildInteractionSummary(),

          // Comments List
          Expanded(
            child: ListView.builder(
              padding: AppPadding.v8,
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return CommentTile(
                  commentId: comment['id'],
                  authorName: comment['authorName'],
                  authorAvatar: comment['authorAvatar'],
                  content: comment['content'],
                  timestamp: comment['timestamp'],
                  likesCount: comment['likesCount'],
                  hasPreviousReplies:
                      comment['hasPreviousReplies'] ??
                      false,
                  previousRepliesCount:
                      comment['previousRepliesCount'] ?? 0,
                  replies:
                      (comment['replies']
                              as List<
                                Map<String, dynamic>
                              >?)
                          ?.map(
                            (reply) => CommentReply(
                              id: reply['id'],
                              authorName:
                                  reply['authorName'],
                              authorAvatar:
                                  reply['authorAvatar'],
                              content: reply['content'],
                              timestamp: reply['timestamp'],
                              likesCount:
                                  reply['likesCount'],
                            ),
                          )
                          .toList(),
                );
              },
            ),
          ),

          // Bottom Input Bar
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInteractionSummary() {
    return InkWell(
      onTap: () {
        // TODO: Show people who reacted
      },
      child: Container(
        padding: AppPadding.h20v12,
        decoration: BoxDecoration(
          color: MyColors.white,
          border: Border(
            bottom: BorderSide(
              color: MyColors.grey200,
              width: AppDimens.borderWidth1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Like icon + text
            Row(
              children: [
                Container(
                  width: AppDimens.avatarSize20,
                  height: AppDimens.avatarSize20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.blue100,
                    border: Border.all(
                      color: MyColors.white,
                      width: AppDimens.borderWidth1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      ImgAssets.communityPariOnly,
                      width: AppDimens.avatarSize20,
                      height: AppDimens.avatarSize20,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                            return Icon(
                              Icons.thumb_up,
                              size: AppDimens.iconSize12,
                              color: MyColors.blue700,
                            );
                          },
                    ),
                  ),
                ),
                SizedBox(width: AppDimens.w8),
                Text(
                  '${widget.likedBy} and ${widget.likesCount} others',
                  style: TextStyles.medium13(
                    color: MyColors.black87,
                  ),
                ),
                SizedBox(width: AppDimens.w4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimens.iconSize12,
                  color: MyColors.grey600,
                ),
              ],
            ),
            // Right: Like button
            IconButton(
              icon: Icon(
                Icons.thumb_up_outlined,
                size: AppDimens.iconSize24,
                color: MyColors.grey700,
              ),
              onPressed: () {
                // TODO: Handle like post action
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimens.w20,
        right: AppDimens.w20,
        top: AppDimens.h12,
        bottom:
            MediaQuery.of(context).viewInsets.bottom +
            AppDimens.h12,
      ),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border(
          top: BorderSide(
            color: MyColors.grey200,
            width: AppDimens.borderWidth1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Input Field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: AppRadius.r25,
                  border: Border.all(
                    color: MyColors.grey300,
                    width: AppDimens.borderWidth1,
                  ),
                ),
                child: TextField(
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  style: TextStyles.regular14(
                    color: MyColors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a comment ...',
                    hintStyle: TextStyles.regular14(
                      color: MyColors.darkGrayColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: AppPadding.h16v12,
                    isDense: true,
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendComment(),
                ),
              ),
            ),
            SizedBox(width: AppDimens.w12),
            // Send Button
            IconButton(
              icon: Icon(
                Icons.send,
                size: AppDimens.iconSize24,
                color: MyColors.greenButton,
              ),
              onPressed: _sendComment,
            ),
          ],
        ),
      ),
    );
  }
}
