import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/activity/presentation/widgets/activity_card.dart';
import 'package:sportify_app/features/activity/presentation/widgets/rate_stadium_sheet.dart';
import 'package:sportify_app/features/activity/presentation/widgets/rating_success_sheet.dart';

class MyActivityView extends StatefulWidget {
  const MyActivityView({super.key});

  @override
  State<MyActivityView> createState() => _MyActivityViewState();
}

class _MyActivityViewState extends State<MyActivityView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      await Future.delayed(const Duration(milliseconds: 200));
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
          icon: Icon(
            Icons.arrow_back,
            size: AppDimens.iconSize24,
            color: MyColors.black,
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
          tabs: const [
            Tab(text: 'Organized'),
            Tab(text: 'Joined'),
            Tab(text: 'Booked'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips Section
          Container(
            color: MyColors.white,
            padding: AppPadding.v16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: AppPadding.h20,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilterIndex == 0,
                    onTap: () => setState(() => _selectedFilterIndex = 0),
                  ),
                  SizedBox(width: AppDimens.w12),
                  _FilterChip(
                    label: 'Reserved',
                    isSelected: _selectedFilterIndex == 1,
                    onTap: () => setState(() => _selectedFilterIndex = 1),
                  ),
                  SizedBox(width: AppDimens.w12),
                  _FilterChip(
                    label: 'Pending',
                    isSelected: _selectedFilterIndex == 2,
                    onTap: () => setState(() => _selectedFilterIndex = 2),
                  ),
                  SizedBox(width: AppDimens.w12),
                  _FilterChip(
                    label: 'Finished',
                    isSelected: _selectedFilterIndex == 3,
                    onTap: () => setState(() => _selectedFilterIndex = 3),
                  ),
                ],
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
          statusBgColor: MyColors.lightBlue100,
          statusTextColor: MyColors.blue,
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
          statusBgColor: MyColors.red100,
          statusTextColor: MyColors.red700,
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
          statusBgColor: MyColors.green.withValues(alpha: AppDimens.opacity1),
          statusTextColor: MyColors.green,
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
          statusBgColor: MyColors.lightBlue100,
          statusTextColor: MyColors.blue,
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
          statusBgColor: MyColors.orange.withValues(alpha: AppDimens.opacity1),
          statusTextColor: MyColors.orange,
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
          statusBgColor: MyColors.green.withValues(alpha: AppDimens.opacity1),
          statusTextColor: MyColors.green,
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
          statusBgColor: MyColors.lightBlue100,
          statusTextColor: MyColors.blue,
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
          statusBgColor: MyColors.orange.withValues(alpha: AppDimens.opacity1),
          statusTextColor: MyColors.orange,
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
          statusBgColor: MyColors.green.withValues(alpha: AppDimens.opacity1),
          statusTextColor: MyColors.green,
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

/// Filter Chip Widget
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
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.r20,
      child: Container(
        padding: AppPadding.h20v8,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.greenButton : MyColors.white,
          borderRadius: AppRadius.r20,
          border: Border.all(
            color: isSelected ? MyColors.greenButton : MyColors.grey300,
            width: AppDimens.borderWidth1,
          ),
        ),
        child: Text(
          label,
          style: TextStyles.medium14(
            color: isSelected ? MyColors.white : MyColors.grey700,
          ),
        ),
      ),
    );
  }
}
