import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
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
      'amount': '+ 50.00 EGP',
      'icon': Icons.undo,
      'iconBg': MyColors.lightBlue100, // Light Blue
      'iconColor': MyColors.blue,
    },
    {
      'type': 'Recharge',
      'date': 'June 30, 2023',
      'amount': '+ 35.00 EGP',
      'icon': Icons.download,
      'iconBg': MyColors.lightBlue100, // Light Blue
      'iconColor': MyColors.blue,
    },
    {
      'type': 'Payment',
      'date': 'June 30, 2023',
      'amount': '+ 40.00 EGP',
      'icon': Icons.north_east,
      'iconBg': MyColors.lightBlue100, // Light Blue
      'iconColor': MyColors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
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
          'Wallet',
          style: TextStyles.bold18(color: MyColors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Card (Hero Section)
          _buildBalanceCard(),

          SizedBox(height: AppDimens.h20),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: AppDimens.h20),

          // Section Title
          Padding(
            padding: AppPadding.h20,
            child: Text(
              'Recent transaction',
              style: TextStyles.bold16(
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

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      margin: AppPadding.h20,
      padding: AppPadding.p20,
      decoration: BoxDecoration(
        color: MyColors.cyanMint, // Light Cyan/Mint
        borderRadius: AppRadius.r12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Column: Balance Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance Available',
                style: TextStyles.medium14(
                  color: MyColors.grey600,
                ),
              ),
              SizedBox(height: AppDimens.h8),
              Text(
                '50 EGP',
                style: TextStyles.bold32(
                  color: MyColors.black87,
                ),
              ),
            ],
          ),

          // Right Item: Recharge Button
          OutlinedButton(
            onPressed: () {
              // TODO: Implement recharge logic
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: MyColors.black87,
              side: BorderSide(
                color: MyColors.grey400,
                width: AppDimens.borderWidth2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.r8,
              ),
              padding: AppPadding.h16v12,
            ),
            child: Text(
              'Recharge Wallet',
              style: TextStyles.medium14(),
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
                  style: TextStyles.bold15(
                    color: MyColors.black87,
                  ),
                ),
                SizedBox(height: AppDimens.h4),
                Text(
                  date,
                  style: TextStyles.regular13(
                    color: MyColors.grey500,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: TextStyles.bold15(
              color: MyColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
