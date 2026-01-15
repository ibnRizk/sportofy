import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 24.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          // User Avatar (Trailing)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
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
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: Colors.grey[500],
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),

          // Online Users (Horizontal List)
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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

          SizedBox(height: 16.h),

          // Recent Chats (Vertical List)
          Expanded(
            child: ListView.separated(
              itemCount: _chats.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
                indent: 72.w, // Align with content (avatar + spacing)
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
