import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class PointsView extends StatefulWidget {
  const PointsView({super.key});

  @override
  State<PointsView> createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All',
    'Received',
    'Used',
    'Refund',
  ];

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'Refund',
      'date': 'June 30, 2023',
      'amount': '300 Point',
      'icon': Icons.undo,
      'iconBg': MyColors.lightBlue100, // Light Blue
      'iconColor': MyColors.blue,
    },
    {
      'type': 'Received',
      'date': 'June 30, 2023',
      'amount': '500 Points',
      'icon': Icons.call_received,
      'iconBg': MyColors.green.withValues(
        alpha: AppDimens.opacity1,
      ), // Light Green
      'iconColor': MyColors.green,
    },
    {
      'type': 'Used',
      'date': 'June 30, 2023',
      'amount': '200 Points',
      'icon': Icons.call_made,
      'iconBg': MyColors.orange.withValues(
        alpha: AppDimens.opacity1,
      ), // Light Orange/Grey
      'iconColor': MyColors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backGround,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.black,
            size: AppDimens.iconSize24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Points',
          style: TextStyles.semiBold18(
            color: MyColors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card (Points Balance)
          _buildHeaderCard(),

          SizedBox(height: AppDimens.h20),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: AppDimens.h20),

          // Section Title
          Padding(
            padding: AppPadding.h20,
            child: Text(
              'Recent transaction',
              style: TextStyles.semiBold16(
                color: MyColors.black87,
              ),
            ),
          ),

          SizedBox(height: AppDimens.h12),

          // Transaction List
          Expanded(child: _buildTransactionList()),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      margin: AppPadding.h20,
      padding: AppPadding.p20,
      decoration: BoxDecoration(
        color: MyColors.cyanMint, // Light Cyan/Blue
        borderRadius: AppRadius.r12,
      ),
      child: Column(
        children: [
          // Points + Coin Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '336',
                style: TextStyles.bold32(
                  color: MyColors.darkGrayColor,
                ),
              ),
              SizedBox(width: AppDimens.w8),
              // Coin Emoji (Using text-based emoji as placeholder)
              Text(
                '🪙',
                style: TextStyle(
                  fontSize: AppDimens.iconSize40,
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h12),

          // Description Text
          Text(
            'Play and get points to get discounts\non your purchases',
            textAlign: TextAlign.center,
            style: TextStyles.regular16(
              color: MyColors.darkGrayColor,
            ).copyWith(height: 1.4),
          ),

          SizedBox(height: AppDimens.h8),

          // Conversion Text
          Text(
            '1 points correspond to 1 pounds',
            textAlign: TextAlign.center,
            style: TextStyles.regular10(
              color: MyColors.darkGrayColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: AppDimens.h40,
      child: ListView.separated(
        padding: AppPadding.h20,
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppDimens.w10),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: Container(
              padding: AppPadding.h20v8,
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.white,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey300,
                ),
                borderRadius: AppRadius.r20,
              ),
              child: Center(
                child: Text(
                  _filters[index],
                  style: TextStyles.medium14(
                    color: isSelected
                        ? MyColors.white
                        : MyColors.grey600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.separated(
      padding: AppPadding.h20,
      itemCount: _transactions.length,
      separatorBuilder: (context, index) => Divider(
        height: AppDimens.dividerThickness1,
        thickness: AppDimens.dividerThickness1,
        color: MyColors.grey200,
      ),
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return _TransactionTile(
          type: transaction['type'],
          date: transaction['date'],
          amount: transaction['amount'],
          icon: transaction['icon'],
          iconBg: transaction['iconBg'],
          iconColor: transaction['iconColor'],
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String type;
  final String date;
  final String amount;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _TransactionTile({
    required this.type,
    required this.date,
    required this.amount,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v12,
      child: Row(
        children: [
          // Icon Circle
          Container(
            width: AppDimens.containerHeight40,
            height: AppDimens.containerHeight40,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: AppDimens.iconSize20,
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Type and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyles.medium14(
                    color: MyColors.darkGrayColor,
                  ),
                ),
                SizedBox(height: AppDimens.h4),
                Text(
                  date,
                  style: TextStyles.regular12(
                    color: MyColors.darkGrayColor,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: TextStyles.medium14(
              color: MyColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
