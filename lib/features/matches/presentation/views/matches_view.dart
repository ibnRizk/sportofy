import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/widgets/shared_filter_header.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/features/matches/presentation/widgets/match_booking_card.dart';

class MatchesView extends StatelessWidget {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Matches',
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
          // Fixed Filters Section
          const SharedFilterHeader(),

          // Matches List
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  itemCount: state.nearbyMatches.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    return MatchBookingCard(
                      match: state.nearbyMatches[index],
                      onJoinTap: () {
                        // TODO: Handle join match action
                        // Navigate to match details or join flow
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Stadium screen (index 3 in bottom navigation)
          if (context.mounted) {
            try {
              context.read<HomeCubit>().changeBottomNavIndex(3);
            } catch (e) {
              debugPrint('Navigation error to stadium screen: $e');
            }
          }
        },
        backgroundColor: MyColors.greenButton,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'Create Match',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
