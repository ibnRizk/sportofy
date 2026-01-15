import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/community/presentation/widgets/post_card.dart';
import 'package:sportify_app/features/community/presentation/widgets/player_story_item.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() =>
      _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  final TextEditingController _searchController =
      TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Usual',
    'Project',
    'Players',
  ];

  // Mock data for players near you
  final List<Map<String, String>> _nearbyPlayers = [
    {'name': 'Mohamed', 'avatar': ImgAssets.mohamedAhmed},
    {'name': 'Ahmed', 'avatar': ImgAssets.salahMostafa},
    {'name': 'Mahmoud', 'avatar': ImgAssets.userAvatar},
    {'name': 'Ali', 'avatar': ImgAssets.mohamedAhmed},
    {'name': 'Hassan', 'avatar': ImgAssets.salahMostafa},
    {'name': 'Moharr', 'avatar': ImgAssets.userAvatar},
  ];

  // Mock data for posts
  final List<Map<String, dynamic>> _posts = [
    {
      'authorName': 'Mahmoud Adel',
      'authorAvatar': ImgAssets.mohamedAhmed,
      'timestamp': 'yesterday at 3:50 PM',
      'isPublic': true,
      'content':
          'Lorem Ipsum is simply a printable and proforma text typesetting industry. Lorem Ipsum was the master of the industry Standard dummy text since the fifteenth century AD.',
      'likesCount': 453,
      'likedBy': 'pari roy',
      'commentsCount': 251,
    },
    {
      'authorName': 'Mahmoud Adel',
      'authorAvatar': ImgAssets.salahMostafa,
      'timestamp': 'yesterday at 3:50 PM',
      'isPublic': true,
      'content':
          'Lorem Ipsum is simply a printable and proforma text typesetting industry. Lorem Ipsum was the master of the industry Standard dummy text since the fifteenth century AD.',
      'likesCount': 453,
      'likedBy': 'pari roy',
      'commentsCount': 251,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            floating: false,
            expandedHeight: 120.h,
            flexibleSpace: _buildCustomAppBar(),
          ),

          // Filter Tabs
          SliverToBoxAdapter(child: _buildFilterTabs()),

          // Players Near You Section
          SliverToBoxAdapter(child: _buildPlayersNearYou()),

          // Posts Feed
          SliverList(
            delegate: SliverChildBuilderDelegate((
              context,
              index,
            ) {
              final post = _posts[index];
              return PostCard(
                authorName: post['authorName'],
                authorAvatar: post['authorAvatar'],
                timestamp: post['timestamp'],
                isPublic: post['isPublic'],
                content: post['content'],
                likesCount: post['likesCount'],
                likedBy: post['likedBy'],
                commentsCount: post['commentsCount'],
              );
            }, childCount: _posts.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to create post screen
        },
        backgroundColor: MyColors.greenButton,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'Create Post',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        left: 20.w,
        right: 20.w,
        bottom: 16.h,
      ),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(
              ImgAssets.mohamedAhmed,
            ),
          ),
          SizedBox(width: 12.w),
          // Search Field
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Notification Icon (SVG)
          IconButton(
            icon: SvgPicture.asset(
              ImgAssets.icNotification,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          // Chat Icon (SVG)
          IconButton(
            icon: SvgPicture.asset(
              ImgAssets.icChat,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              // TODO: Navigate to messages
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayersNearYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          child: Text(
            'Players near you',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _nearbyPlayers.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final player = _nearbyPlayers[index];
              return PlayerStoryItem(
                name: player['name']!,
                avatar: player['avatar']!,
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
