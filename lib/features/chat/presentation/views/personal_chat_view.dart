import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/chat/presentation/widgets/attachment_panel.dart';
import 'package:sportify_app/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:sportify_app/features/chat/presentation/widgets/message_bubble.dart';

class PersonalChatView extends StatefulWidget {
  final String? userName;
  final String? userAvatar;
  final bool isOnline;

  const PersonalChatView({
    super.key,
    this.userName,
    this.userAvatar,
    this.isOnline = false,
  });

  @override
  State<PersonalChatView> createState() => _PersonalChatViewState();
}

class _PersonalChatViewState extends State<PersonalChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showAttachments = false;
  bool _hasMessages = false; // Toggle this to test empty vs active states

  // Mock messages for active conversation
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Lorem Ipsum is',
      'type': MessageType.received,
      'timestamp': '5:07 AM',
    },
    {
      'message': 'Lorem Ipsum is simple a printable',
      'type': MessageType.sent,
      'timestamp': '5:08 AM',
    },
    {
      'message':
          'Lorem Ipsum is simply a printable and proforma text typesetting industry.',
      'type': MessageType.received,
      'timestamp': '5:09 AM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {}); // Rebuild to toggle mic/send icon
    });
    // Set initial state - change to true to show messages
    _hasMessages = false;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleAttachments() {
    setState(() {
      _showAttachments = !_showAttachments;
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _hasMessages = true; // Switch to active conversation state
      _messages.add({
        'message': _messageController.text.trim(),
        'type': MessageType.sent,
        'timestamp': _getCurrentTime(),
      });
      _messageController.clear();
      _showAttachments = false;
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Chat Body
          Expanded(
            child: _hasMessages ? _buildActiveChat() : _buildEmptyChat(),
          ),

          // Attachment Panel (if visible)
          if (_showAttachments) _buildAttachmentPanel(),

          // Input Bar
          ChatInputBar(
            controller: _messageController,
            onPlusTap: _toggleAttachments,
            onSendTap: _sendMessage,
            onMicTap: () {
              // TODO: Implement voice recording
              debugPrint('Microphone tapped');
            },
            onEmojiTap: () {
              // TODO: Show emoji picker
              debugPrint('Emoji tapped');
            },
            showAttachments: _showAttachments,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: MyColors.black87,
          size: AppDimens.iconSize24,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Row(
        children: [
          // Avatar with Online Indicator
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: AppDimens.avatarSize20,
                backgroundImage: AssetImage(
                  widget.userAvatar ?? ImgAssets.mohamedAhmed,
                ),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle error silently
                },
              ),
              // Online Indicator
              if (widget.isOnline)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: AppDimens.iconSize14,
                    height: AppDimens.iconSize14,
                    decoration: BoxDecoration(
                      color: MyColors.greenButton,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MyColors.white,
                        width: AppDimens.borderWidth2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: AppDimens.w12),
          // Name and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName ?? 'Mohamed Ahmed',
                style: TextStyles.bold16(color: MyColors.black87),
              ),
              Text(
                widget.isOnline ? 'Active now' : 'Offline',
                style: TextStyles.regular12(
                  color: widget.isOnline
                      ? MyColors.greenButton
                      : MyColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Container(
        margin: AppPadding.h40,
        padding: AppPadding.h24v32,
        decoration: BoxDecoration(
          color: MyColors.cyan.withValues(alpha: AppDimens.opacity1),
          borderRadius: AppRadius.r12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No messages here yet...',
              style: TextStyles.bold16(color: MyColors.darkGrayColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimens.h8),
            Text(
              'Send a first message',
              style: TextStyles.regular14(color: MyColors.darkGrayColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveChat() {
    return ListView.builder(
      controller: _scrollController,
      padding: AppPadding.v16,
      itemCount: _messages.length + 1, // +1 for date separator
      itemBuilder: (context, index) {
        // Date Separator (first item)
        if (index == 0) {
          return Padding(
            padding: AppPadding.v16,
            child: Center(
              child: Text(
                'MAY 01, 2014, 5:07 AM',
                style: TextStyles.regular12(color: MyColors.darkGrayColor),
              ),
            ),
          );
        }

        // Messages
        final messageIndex = index - 1;
        final message = _messages[messageIndex];

        return MessageBubble(
          message: message['message'] as String,
          type: message['type'] as MessageType,
          userAvatar: message['type'] == MessageType.received
              ? (widget.userAvatar ?? ImgAssets.mohamedAhmed)
              : ImgAssets.userAvatar,
          timestamp: message['timestamp'] as String,
        );
      },
    );
  }

  Widget _buildAttachmentPanel() {
    return AttachmentPanel(
      onAttachmentTap: () {
        // TODO: Implement attachment
        debugPrint('Attachment tapped');
        setState(() {
          _showAttachments = false;
        });
      },
      onCameraTap: () {
        // TODO: Implement camera
        debugPrint('Camera tapped');
        setState(() {
          _showAttachments = false;
        });
      },
      onGalleryTap: () {
        // TODO: Implement gallery
        debugPrint('Gallery tapped');
        setState(() {
          _showAttachments = false;
        });
      },
      onGifTap: () {
        // TODO: Implement GIF picker
        debugPrint('GIF tapped');
        setState(() {
          _showAttachments = false;
        });
      },
    );
  }
}
