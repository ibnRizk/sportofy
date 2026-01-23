import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/widgets/shared_filter_header.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/features/home/presentation/widgets/nearby_match_card.dart';

class MatchesView extends StatelessWidget {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        title: Text(
          'Matches',
          style: TextStyles.bold18(color: MyColors.black),
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
                  padding: AppPadding.h20v16,
                  itemCount: state.nearbyMatches.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppDimens.h16),
                  itemBuilder: (context, index) {
                    return NearbyMatchCard(
                      match: state.nearbyMatches[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          // Navigate to Stadium screen (index 3 in bottom navigation)
          if (context.mounted) {
            try {
              context
                  .read<HomeCubit>()
                  .changeBottomNavIndex(3);
            } catch (e) {
              debugPrint(
                'Navigation error to stadium screen: $e',
              );
            }
          }
        },
        backgroundColor: MyColors.greenButton,
        icon: Icon(
          Icons.add,
          color: MyColors.white,
          size: AppDimens.iconSize20,
        ),
        label: Text(
          'Create Match',
          style: TextStyles.semiBold14(
            color: MyColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
