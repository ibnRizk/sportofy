import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/features/market/presentation/widgets/address_card.dart';
import 'package:sportify_app/features/market/presentation/widgets/order_success_sheet.dart';
import 'package:sportify_app/features/market/presentation/widgets/payment_option_tile.dart';

class CheckoutSummaryView extends StatefulWidget {
  final Map<String, dynamic>? addressData;

  const CheckoutSummaryView({super.key, this.addressData});

  @override
  State<CheckoutSummaryView> createState() =>
      _CheckoutSummaryViewState();
}

class _CheckoutSummaryViewState
    extends State<CheckoutSummaryView> {
  String _selectedPaymentMethod = 'wallet';
  int _pointsToUse = 200;

  // Mock values
  final double _subtotal = 9600.0;
  final double _deliveryFees = 50.0;

  // Payment methods data
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'value': 'wallet',
      'icon': ImgAssets.sportifyWallet,
      'title': 'Sportify Wallet',
      'balance': '100 EGP',
    },
    {
      'value': 'mobile_wallet',
      'icon': ImgAssets.vodafoneCash,
      'title': 'Vodafone cash, WE Pay ..',
      'balance': null,
    },
    {
      'value': 'card',
      'icon': ImgAssets.creditCard,
      'title': 'Debit / Credit Card',
      'balance': null,
    },
    {
      'value': 'cash',
      'icon': ImgAssets.cashMoney,
      'title': 'Cash Payment',
      'balance': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final address =
        widget.addressData?['address'] ?? 'Cairo (Maadi)';
    final street =
        widget.addressData?['street'] ??
        '8 street 9, floor 5, department 15';
    final mobile =
        widget.addressData?['mobile'] ?? '01101110101';

    return Scaffold(
      backgroundColor: context.colors.backGround,
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
            fontWeight: FontWeight.w600,
            color: MyColors.darkGrayColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment methods',
                          style: TextStyles.bold16(
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Payment Method Options with Dividers
                        ListView.separated(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: _paymentMethods.length,
                          separatorBuilder:
                              (context, index) => Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey[200]!,
                              ),
                          itemBuilder: (context, index) {
                            final method =
                                _paymentMethods[index];
                            return PaymentOptionTile(
                              value:
                                  method['value'] as String,
                              iconPath:
                                  method['icon'] as String,
                              title:
                                  method['title'] as String,
                              balanceText:
                                  method['balance']
                                      as String?,
                              isSelected:
                                  _selectedPaymentMethod ==
                                  method['value'] as String,
                              onTap: () {
                                setState(() {
                                  _selectedPaymentMethod =
                                      method['value']
                                          as String;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Payment Summary Section
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Payment Summary Header
                        Text(
                          'Payment summary',
                          style: TextStyles.semiBold16(
                            color: MyColors.darkGrayColor,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Subtotal
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyles.semiBold16(
                                color:
                                    MyColors.darkGrayColor,
                              ),
                            ),
                            Text(
                              '${_subtotal.toStringAsFixed(0)} EGP',
                              style: TextStyles.semiBold16(
                                color: MyColors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        // Delivery Fees
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              'Delivery Fees',
                              style: TextStyles.semiBold16(
                                color:
                                    MyColors.darkGrayColor,
                              ),
                            ),
                            Text(
                              '${_deliveryFees.toStringAsFixed(0)} EGP',
                              style: TextStyles.semiBold16(
                                color: MyColors.black87,
                              ),
                            ),
                          ],
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
                  color: Colors.black.withValues(
                    alpha: 0.05,
                  ),
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
                    builder: (context) =>
                        const OrderSuccessSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: MyColors.grey300,
                  disabledForegroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
