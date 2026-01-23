import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/orders/presentation/widgets/order_card.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All',
    'Ordered',
    'Shipped',
    'Delivered',
  ];

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
          'My Orders',
          style: TextStyles.semiBold18(
            color: MyColors.darkGrayColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(height: AppDimens.h20),
          _buildFilterChips(),

          SizedBox(height: AppDimens.h20),

          // Order List
          Expanded(child: _buildOrderList()),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: AppDimens.buttonHeight40,
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
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.white,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey300,
                ),
                borderRadius: BorderRadius.circular(36.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: AppPadding.h20,
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
