import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/chat/presentation/widgets/chat_list_tile.dart';
import 'package:sportify_app/features/chat/presentation/widgets/online_user_bubble.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  // Mock data for online users
  final List<Map<String, String>> _onlineUsers = const [
    {'avatar': ImgAssets.mohamedAhmed, 'name': 'Mohamed'},
    {'avatar': ImgAssets.salahMostafa, 'name': 'Mohamed'},
    {'avatar': ImgAssets.mohamedAhmed, 'name': 'Mohamed'},
    {'avatar': ImgAssets.salahMostafa, 'name': 'Mohamed'},
    {'avatar': ImgAssets.mohamedAhmed, 'name': 'Mohamed'},
  ];

  // Mock data for chat conversations
  final List<Map<String, dynamic>> _chats = const [
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Ayman',
      'message': 'Lorem Ipsum is simply a prin..',
      'timestamp': '10:09 am',
      'unreadCount': 2,
      'isOnline': true,
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Mohamed Ayman',
      'message': 'Lorem Ipsum is simply a prin..',
      'timestamp': '10:09 am',
      'unreadCount': 2,
      'isOnline': true,
    },
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Ayman',
      'message': 'Lorem Ipsum is simply a prin..',
      'timestamp': '10:09 am',
      'unreadCount': 2,
      'isOnline': true,
    },
    {
      'avatar': ImgAssets.salahMostafa,
      'name': 'Mohamed Ayman',
      'message': 'Lorem Ipsum is simply a prin..',
      'timestamp': '10:09 am',
      'unreadCount': 2,
      'isOnline': true,
    },
    {
      'avatar': ImgAssets.mohamedAhmed,
      'name': 'Mohamed Ayman',
      'message': 'Lorem Ipsum is simply a prin..',
      'timestamp': '10:09 am',
      'unreadCount': 2,
      'isOnline': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
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
        title: Text(
          'Chat',
          style: TextStyles.bold18(color: MyColors.black87),
        ),
        centerTitle: false,
        actions: [
          // User Avatar (Trailing)
          Padding(
            padding: AppPadding.right16,
            child: CircleAvatar(
              radius: AppDimens.avatarSize18,
              backgroundImage: AssetImage(ImgAssets.userAvatar),
              onBackgroundImageError: (exception, stackTrace) {
                // Handle error silently
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: AppPadding.h20v16,
            child: Container(
              height: AppDimens.containerHeight45,
              decoration: BoxDecoration(
                color: MyColors.grey50,
                borderRadius: AppRadius.r12,
                border: Border.all(
                  color: MyColors.grey300,
                  width: AppDimens.borderWidth1,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyles.regular14(color: MyColors.grey500),
                  prefixIcon: Icon(
                    Icons.search,
                    size: AppDimens.iconSize20,
                    color: MyColors.grey500,
                  ),
                  border: InputBorder.none,
                  contentPadding: AppPadding.h16v12,
                  isDense: true,
                ),
              ),
            ),
          ),

          // Online Users (Horizontal List)
          SizedBox(
            height: AppDimens.containerHeight90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: AppPadding.h20,
              itemCount: _onlineUsers.length,
              itemBuilder: (context, index) {
                final user = _onlineUsers[index];
                return OnlineUserBubble(
                  userAvatar: user['avatar']!,
                  userName: user['name']!,
                  onTap: () {
                    context.push(
                      Routes.personalChatRoute,
                      extra: {
                        'userName': user['name']!,
                        'userAvatar': user['avatar']!,
                        'isOnline': true,
                      },
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Recent Chats (Vertical List)
          Expanded(
            child: ListView.separated(
              itemCount: _chats.length,
              separatorBuilder: (context, index) => Divider(
                height: AppDimens.dividerThickness1,
                thickness: AppDimens.dividerThickness1,
                color: MyColors.grey200,
                indent: AppDimens.w72, // Align with content (avatar + spacing)
              ),
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ChatListTile(
                  userAvatar: chat['avatar'] as String,
                  userName: chat['name'] as String,
                  lastMessage: chat['message'] as String,
                  timestamp: chat['timestamp'] as String,
                  unreadCount: chat['unreadCount'] as int,
                  isOnline: chat['isOnline'] as bool,
                  onTap: () {
                    context.push(
                      Routes.personalChatRoute,
                      extra: {
                        'userName': chat['name'] as String,
                        'userAvatar': chat['avatar'] as String,
                        'isOnline': chat['isOnline'] as bool,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
