import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/activity/presentation/widgets/activity_card.dart';
import 'package:sportify_app/features/activity/presentation/widgets/rate_stadium_sheet.dart';
import 'package:sportify_app/features/activity/presentation/widgets/rating_success_sheet.dart';

class MyActivityView extends StatefulWidget {
  const MyActivityView({super.key});

  @override
  State<MyActivityView> createState() =>
      _MyActivityViewState();
}

class _MyActivityViewState extends State<MyActivityView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedFilterIndex = 0;

  // Dynamic filter lists based on tab
  List<String> get _currentFilters {
    if (_tabController.index == 0) {
      // Organized tab
      return [
        'All',
        'Open',
        'Locked',
        'Pending',
        'Finished',
      ];
    } else {
      // Joined or Booked tab
      return ['All', 'Reserved', 'Pending', 'Finished'];
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedFilterIndex =
              0; // Reset to "All" when tab changes
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Handle the 2-step rating flow
  Future<void> _handleRateStadium() async {
    // Step 1: Show rating sheet and wait for it to close
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.transparent,
      builder: (context) => const RateStadiumSheet(),
    );

    // Step 2: If rating was submitted (sheet returned data), show success
    if (result != null && mounted) {
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      if (mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: MyColors.transparent,
          builder: (context) => const RatingSuccessSheet(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey100,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(
            ImgAssets.icBack,
            width: AppDimens.iconSize24,
            height: AppDimens.iconSize24,
            colorFilter: ColorFilter.mode(
              MyColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: Text(
          'My Activity',
          style: TextStyles.bold18(color: MyColors.black),
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: MyColors.greenButton,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: MyColors.greenButton,
          unselectedLabelColor: MyColors.grey600,
          labelStyle: TextStyles.semiBold16(),
          unselectedLabelStyle: TextStyles.medium16(),
          dividerColor:
              MyColors.transparent, // Remove divider
          tabs: const [
            Tab(text: 'Organized'),
            Tab(text: 'Joined'),
            Tab(text: 'Booked'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips Section (Dynamic based on tab)
          Container(
            color: MyColors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                children: List.generate(
                  _currentFilters.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      right:
                          index < _currentFilters.length - 1
                          ? 12.w
                          : 0,
                    ),
                    child: _FilterChip(
                      label: _currentFilters[index],
                      isSelected:
                          _selectedFilterIndex == index,
                      onTap: () => setState(
                        () => _selectedFilterIndex = index,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrganizedTab(),
                _buildJoinedTab(),
                _buildBookedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Organized Tab Content
  Widget _buildOrganizedTab() {
    return ListView(
      padding: AppPadding.p20,
      children: [
        ActivityCard(
          userName: 'You',
          statusLabel: 'Open',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Lock',
          onActionTap: () {},
        ),
        ActivityCard(
          userName: 'You',
          statusLabel: 'Locked',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Unlock',
          onActionTap: () {},
        ),
        ActivityCard(
          userName: 'You',
          statusLabel: 'Finished',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Rate stadium',
          onActionTap: _handleRateStadium,
        ),
      ],
    );
  }

  /// Joined Tab Content
  Widget _buildJoinedTab() {
    return ListView(
      padding: AppPadding.p20,
      children: [
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Reserved',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Disjoin',
          onActionTap: () {},
        ),
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Pending',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Disjoin',
          onActionTap: () {},
        ),
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Finished',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
        ),
      ],
    );
  }

  /// Booked Tab Content
  Widget _buildBookedTab() {
    return ListView(
      padding: AppPadding.p20,
      children: [
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Reserved',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Resell',
          onActionTap: () {},
          showResellIcon: true,
        ),
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Pending',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Resell',
          onActionTap: () {},
          showResellIcon: true,
        ),
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Finished',
          stadiumName: 'Stadium name',
          date: 'Today, 03/07',
          time: '06 : 00 PM',
          duration: '60 minute',
          footerDate: 'June 30, 2023',
          actionButtonText: 'Rate stadium',
          onActionTap: _handleRateStadium,
        ),
      ],
    );
  }
}

/// Filter Chip Widget (Capsule Style)
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? MyColors.greenButton
              : MyColors
                    .transparent, // Transparent for unselected
          borderRadius: BorderRadius.circular(
            30.r,
          ), // Fully rounded (StadiumBorder)
          border: isSelected
              ? null // No border when selected
              : Border.all(
                  color: MyColors.grey300,
                  width: 1, // Thin grey border
                ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? MyColors.white
                : MyColors
                      .darkGrayColor, // Dark grey for unselected
          ),
        ),
      ),
    );
  }
}
