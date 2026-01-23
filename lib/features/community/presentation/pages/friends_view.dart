import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

// ═══════════════════════════════════════════════
// FRIEND MODEL
// ═══════════════════════════════════════════════
class FriendModel {
  final String name;
  final String? mutualFriends;
  final String avatarUrl;

  const FriendModel({
    required this.name,
    this.mutualFriends,
    required this.avatarUrl,
  });
}

// ═══════════════════════════════════════════════
// FRIENDS VIEW
// ═══════════════════════════════════════════════
class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  // Mock Data (Hardcoded to match screenshot)
  static final List<FriendModel> _mockFriends = [
    FriendModel(
      name: 'Mohamed Abdallah',
      mutualFriends: '116 mutual friends',
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Alaa Youssef',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Abdallah Ahmed',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Hany Adel',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Mahmoud Mohamed',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Mohamed Abdallah',
      mutualFriends: '116 mutual friends',
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Mohamed Abdallah',
      mutualFriends: '116 mutual friends',
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Hany Adel',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Hany Adel',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
    FriendModel(
      name: 'Mahmoud Mohamed',
      mutualFriends: null,
      avatarUrl: ImgAssets.userAvatar,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      appBar: AppBar(
        backgroundColor: context.colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.textColor,
            size: 24.w,
          ),
        ),
        title: Text(
          'Friends',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.textColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // ═══════════════════════════════════════════════
          // SEARCH BAR
          // ═══════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search friends',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.textColor
                      .withValues(alpha: 0.4),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 22.w,
                  color: context.colors.textColor
                      .withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: context.colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: context.colors.textColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: context.colors.textColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: context.colors.textColor,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // FRIENDS LIST
          // ═══════════════════════════════════════════════
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _mockFriends.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                indent: 72.w,
                color: context.colors.textColor.withValues(
                  alpha: 0.08,
                ),
              ),
              itemBuilder: (context, index) {
                return FriendListTile(
                  friend: _mockFriends[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// FRIEND LIST TILE WIDGET
// ═══════════════════════════════════════════════
class FriendListTile extends StatelessWidget {
  final FriendModel friend;

  const FriendListTile({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to friend profile or show options
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(friend.avatarUrl),
            ),

            SizedBox(width: 12.w),

            // Name and Mutual Friends
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    style: TextStyles.regular14(
                      color: context.colors.textColor,
                    ),
                  ),
                  if (friend.mutualFriends != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      friend.mutualFriends!,
                      style: TextStyles.regular10(
                        color: context.colors.textColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // No Trailing Widget (Clean Layout)
          ],
        ),
      ),
    );
  }
}
