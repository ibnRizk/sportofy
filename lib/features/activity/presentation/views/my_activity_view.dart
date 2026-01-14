import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
      backgroundColor: Colors.transparent,
      builder: (context) => const RateStadiumSheet(),
    );

    // Step 2: If rating was submitted (sheet returned data), show success
    if (result != null && mounted) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => const RatingSuccessSheet(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Activity',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: MyColors.greenButton,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: MyColors.greenButton,
          unselectedLabelColor: Colors.grey[600],
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
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
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilterIndex == 0,
                    onTap: () => setState(() => _selectedFilterIndex = 0),
                  ),
                  SizedBox(width: 12.w),
                  _FilterChip(
                    label: 'Reserved',
                    isSelected: _selectedFilterIndex == 1,
                    onTap: () => setState(() => _selectedFilterIndex = 1),
                  ),
                  SizedBox(width: 12.w),
                  _FilterChip(
                    label: 'Pending',
                    isSelected: _selectedFilterIndex == 2,
                    onTap: () => setState(() => _selectedFilterIndex = 2),
                  ),
                  SizedBox(width: 12.w),
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
      padding: EdgeInsets.all(20.w),
      children: [
        ActivityCard(
          userName: 'You',
          statusLabel: 'Open',
          statusBgColor: const Color(0xFFE3F2FD),
          statusTextColor: const Color(0xFF2196F3),
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
          statusBgColor: const Color(0xFFFFEBEE),
          statusTextColor: const Color(0xFFE53935),
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
          statusBgColor: const Color(0xFFE8F5E9),
          statusTextColor: const Color(0xFF4CAF50),
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
      padding: EdgeInsets.all(20.w),
      children: [
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Reserved',
          statusBgColor: const Color(0xFFE3F2FD),
          statusTextColor: const Color(0xFF2196F3),
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
          statusBgColor: const Color(0xFFFFF3E0),
          statusTextColor: const Color(0xFFFB8C00),
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
          statusBgColor: const Color(0xFFE8F5E9),
          statusTextColor: const Color(0xFF4CAF50),
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
      padding: EdgeInsets.all(20.w),
      children: [
        ActivityCard(
          userName: 'Mohamed Ahmed',
          statusLabel: 'Reserved',
          statusBgColor: const Color(0xFFE3F2FD),
          statusTextColor: const Color(0xFF2196F3),
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
          statusBgColor: const Color(0xFFFFF3E0),
          statusTextColor: const Color(0xFFFB8C00),
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
          statusBgColor: const Color(0xFFE8F5E9),
          statusTextColor: const Color(0xFF4CAF50),
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
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.greenButton : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? MyColors.greenButton : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
