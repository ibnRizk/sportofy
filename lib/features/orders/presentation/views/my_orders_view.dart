import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/orders/presentation/widgets/order_card.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Ordered', 'Shipped', 'Delivered'];

  // Mock Data - Strictly matches the screenshot
  final List<Map<String, String>> _orders = [
    {
      'orderId': '9287KJ',
      'orderDate': 'June 29, 2023',
      'receivedDate': 'June 30, 2023',
      'status': 'Ordered',
    },
    {
      'orderId': '9287KJ',
      'orderDate': 'June 29, 2023',
      'receivedDate': 'June 30, 2023',
      'status': 'Canceled',
    },
    {
      'orderId': '9287KJ',
      'orderDate': 'June 29, 2023',
      'receivedDate': 'June 30, 2023',
      'status': 'Shipped',
    },
    {
      'orderId': '9287KJ',
      'orderDate': 'June 29, 2023',
      'receivedDate': 'June 30, 2023',
      'status': 'Delivered',
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
          'My Orders',
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

          // Order List
          Expanded(
            child: _buildOrderList(),
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

  Widget _buildOrderList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return OrderCard(
          orderId: order['orderId']!,
          orderDate: order['orderDate']!,
          receivedDate: order['receivedDate']!,
          status: order['status']!,
        );
      },
    );
  }
}
