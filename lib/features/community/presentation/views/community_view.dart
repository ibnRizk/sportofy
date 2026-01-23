import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/community/presentation/widgets/post_card.dart';
import 'package:sportify_app/features/community/presentation/widgets/player_story_item.dart';
import 'package:sportify_app/features/community/presentation/widgets/post_type_selection_sheet.dart';

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
      backgroundColor: MyColors.white,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar
          SliverAppBar(
            backgroundColor: MyColors.white,
            elevation: AppDimens.elevation0,
            pinned: true,
            floating: false,
            expandedHeight: AppDimens.containerHeight120,
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
        heroTag: null,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: MyColors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.top30,
            ),
            builder: (context) =>
                const PostTypeSelectionSheet(),
          );
        },
        backgroundColor: MyColors.greenButton,
        icon: Icon(
          Icons.add,
          color: MyColors.white,
          size: AppDimens.iconSize20,
        ),
        label: Text(
          'Create Post',
          style: TextStyles.semiBold14(
            color: MyColors.white,
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
        top:
            MediaQuery.of(context).padding.top +
            AppDimens.h20,
        left: AppDimens.w20,
        right: AppDimens.w20,
      ),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: AppDimens.avatarSize20,
            backgroundImage: AssetImage(
              ImgAssets.mohamedAhmed,
            ),
          ),
          SizedBox(width: AppDimens.w12),
          // Search Field
          Expanded(
            child: Container(
              height: AppDimens.containerHeight40,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyles.regular14(
                  color: MyColors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyles.regular14(
                    color: MyColors.grey600,
                  ),
                  prefixIcon: Padding(
                    padding: AppPadding.p12,
                    child: Icon(
                      Icons.search,
                      size: AppDimens.iconSize20,
                      color: MyColors.grey600,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppDimens.w16,
                    vertical: AppDimens.h10,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimens.w12),
          // Notification Icon (SVG)
          IconButton(
            icon: SvgPicture.asset(
              ImgAssets.icNotification,
              width: AppDimens.iconSize24,
              height: AppDimens.iconSize24,
              colorFilter: const ColorFilter.mode(
                MyColors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              context.push(Routes.notificationsRoute);
            },
          ),
          // Chat Icon (SVG)
          IconButton(
            icon: SvgPicture.asset(
              ImgAssets.icChat,
              width: AppDimens.iconSize24,
              height: AppDimens.iconSize24,
              colorFilter: const ColorFilter.mode(
                MyColors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              context.push(Routes.chatsRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.w20,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppDimens.w12),
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
              padding: AppPadding.h20v10,
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.white,
                borderRadius: AppRadius.r20,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey300,
                  width: AppDimens.borderWidth1,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.w16,
                  ),
                  child: Text(
                    filter,
                    style: isSelected
                        ? TextStyles.medium14(
                            color: MyColors.white,
                          )
                        : TextStyles.medium14(
                            color: MyColors.black87,
                          ),
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
            horizontal: AppDimens.w20,
            vertical: AppDimens.h16,
          ),
          child: Text(
            'Players near you',
            style: TextStyles.semiBold16(
              color: MyColors.darkGrayColor,
            ),
          ),
        ),
        SizedBox(
          height: AppDimens.containerHeight100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.w20,
            ),
            itemCount: _nearbyPlayers.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: AppDimens.w16),
            itemBuilder: (context, index) {
              final player = _nearbyPlayers[index];
              return PlayerStoryItem(
                name: player['name']!,
                avatar: player['avatar']!,
              );
            },
          ),
        ),
        SizedBox(height: AppDimens.h16),
      ],
    );
  }
}
