import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class PointsView extends StatefulWidget {
  const PointsView({super.key});

  @override
  State<PointsView> createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Received', 'Used', 'Refund'];

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'Refund',
      'date': 'June 30, 2023',
      'amount': '300 Point',
      'icon': Icons.undo,
      'iconBg': const Color(0xFFE3F5FF), // Light Blue
      'iconColor': const Color(0xFF2196F3),
    },
    {
      'type': 'Received',
      'date': 'June 30, 2023',
      'amount': '500 Points',
      'icon': Icons.call_received,
      'iconBg': const Color(0xFFE8F5E9), // Light Green
      'iconColor': const Color(0xFF4CAF50),
    },
    {
      'type': 'Used',
      'date': 'June 30, 2023',
      'amount': '200 Points',
      'icon': Icons.call_made,
      'iconBg': const Color(0xFFFFF3E0), // Light Orange/Grey
      'iconColor': const Color(0xFFFF9800),
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
          'Points',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card (Points Balance)
          _buildHeaderCard(),

          SizedBox(height: 20.h),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 20.h),

          // Section Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Recent transaction',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Transaction List
          Expanded(
            child: _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEBFDFD), // Light Cyan/Blue
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Points + Coin Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '336',
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8.w),
              // Coin Emoji (Using text-based emoji as placeholder)
              Text(
                '🪙',
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Description Text
          Text(
            'Play and get points to get discounts\non your purchases',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),

          SizedBox(height: 8.h),

          // Conversion Text
          Text(
            '1 points correspond to 1 pounds',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40.h,
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
                vertical: 8.h,
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

  Widget _buildTransactionList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _transactions.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey[200],
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
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Icon Circle
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.w,
            ),
          ),

          SizedBox(width: 12.w),

          // Type and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
