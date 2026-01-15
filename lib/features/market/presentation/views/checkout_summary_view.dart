import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/market/presentation/widgets/address_card.dart';
import 'package:sportify_app/features/market/presentation/widgets/order_success_sheet.dart';

class CheckoutSummaryView extends StatefulWidget {
  final Map<String, dynamic>? addressData;

  const CheckoutSummaryView({
    super.key,
    this.addressData,
  });

  @override
  State<CheckoutSummaryView> createState() => _CheckoutSummaryViewState();
}

class _CheckoutSummaryViewState extends State<CheckoutSummaryView> {
  String _selectedPaymentMethod = 'sportify_wallet';

  @override
  Widget build(BuildContext context) {
    final address = widget.addressData?['address'] ?? 'Cairo (Maadi)';
    final street = widget.addressData?['street'] ?? '8 street 9, floor 5, department 15';
    final mobile = widget.addressData?['mobile'] ?? '01101110101';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 24.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Delivery Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address Card
                  AddressCard(
                    address: address,
                    street: street,
                    mobile: mobile,
                    onEdit: () {
                      // TODO: Navigate back to edit address
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                  // Payment Methods Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment methods',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Payment Method Options
                        _buildPaymentOption(
                          value: 'sportify_wallet',
                          icon: ImgAssets.sportifyWallet,
                          title: 'Sportify Wallet',
                          subtitle: '100 EGP',
                          isSelected: _selectedPaymentMethod == 'sportify_wallet',
                        ),
                        SizedBox(height: 12.h),

                        _buildPaymentOption(
                          value: 'vodafone_cash',
                          icon: ImgAssets.vodafoneCash,
                          title: 'Vodafone cash, WE Pay ..',
                          isSelected: _selectedPaymentMethod == 'vodafone_cash',
                        ),
                        SizedBox(height: 12.h),

                        _buildPaymentOption(
                          value: 'credit_card',
                          icon: ImgAssets.creditCard,
                          title: 'Debit / Credit Card',
                          isSelected: _selectedPaymentMethod == 'credit_card',
                        ),
                        SizedBox(height: 12.h),

                        _buildPaymentOption(
                          value: 'cash',
                          icon: ImgAssets.cashMoney,
                          title: 'Cash Payment',
                          isSelected: _selectedPaymentMethod == 'cash',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Place Order Button
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // Show Order Success Sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    enableDrag: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) => const OrderSuccessSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String icon,
    required String title,
    String? subtitle,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Row(
        children: [
          // Icon
          Image.asset(
            icon,
            width: 40.w,
            height: 40.w,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.payment,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
          SizedBox(width: 12.w),

          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.greenButton,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Radio Button
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? MyColors.greenButton
                    : Colors.grey[400]!,
                width: 2,
              ),
              color: isSelected
                  ? MyColors.greenButton
                  : Colors.transparent,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    size: 16.sp,
                    color: Colors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
