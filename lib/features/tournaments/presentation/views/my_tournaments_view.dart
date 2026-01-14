import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/tournaments/presentation/widgets/tournament_card.dart';

class MyTournamentsView extends StatefulWidget {
  const MyTournamentsView({super.key});

  @override
  State<MyTournamentsView> createState() => _MyTournamentsViewState();
}

class _MyTournamentsViewState extends State<MyTournamentsView> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Joined', 'Pending', 'Finished'];

  // Mock Data - Strictly matches the screenshot
  final List<Map<String, dynamic>> _tournaments = [
    {
      'status': 'Joined',
      'teamName': 'Team Name',
      'trailingInfo': 'Starting: 15 Aug 2023',
      'joinedDate': 'June 30, 2023',
      'isDisjoinEnabled': true,
    },
    {
      'status': 'Joined',
      'teamName': 'Team Name',
      'trailingInfo': 'Final is playing',
      'joinedDate': 'June 30, 2023',
      'isDisjoinEnabled': false, // Disabled
    },
    {
      'status': 'Finished',
      'teamName': 'Team Name',
      'trailingInfo': 'First place',
      'joinedDate': 'June 30, 2023',
      'isDisjoinEnabled': false, // Disabled
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
            color: Colors.black,
            size: 24.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tournament',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 20.h),

          // Tournament List
          Expanded(
            child: _buildTournamentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: isSelected ? MyColors.greenButton : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  _filters[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTournamentList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _tournaments.length,
      itemBuilder: (context, index) {
        final tournament = _tournaments[index];
        return TournamentCard(
          status: tournament['status'],
          teamName: tournament['teamName'],
          trailingInfo: tournament['trailingInfo'],
          joinedDate: tournament['joinedDate'],
          isDisjoinEnabled: tournament['isDisjoinEnabled'],
        );
      },
    );
  }
}
