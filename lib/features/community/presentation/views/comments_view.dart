import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
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
  final TextEditingController _commentController = TextEditingController();
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
          'Comments',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
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
              padding: EdgeInsets.symmetric(vertical: 8.h),
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
                  hasPreviousReplies: comment['hasPreviousReplies'] ?? false,
                  previousRepliesCount: comment['previousRepliesCount'] ?? 0,
                  replies: (comment['replies'] as List<Map<String, dynamic>>?)
                      ?.map((reply) => CommentReply(
                            id: reply['id'],
                            authorName: reply['authorName'],
                            authorAvatar: reply['authorAvatar'],
                            content: reply['content'],
                            timestamp: reply['timestamp'],
                            likesCount: reply['likesCount'],
                          ))
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
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
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
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      ImgAssets.communityPariOnly,
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.thumb_up,
                          size: 12.sp,
                          color: Colors.blue[700],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${widget.likedBy} and ${widget.likesCount} others',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: Colors.grey[600],
                ),
              ],
            ),
            // Right: Like button
            IconButton(
              icon: Icon(
                Icons.thumb_up_outlined,
                size: 24.sp,
                color: Colors.grey[700],
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
        left: 20.w,
        right: 20.w,
        top: 12.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a comment ...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    isDense: true,
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendComment(),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Send Button
            IconButton(
              icon: Icon(
                Icons.send,
                size: 24.sp,
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
