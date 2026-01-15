import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/payment/presentation/widgets/sharing_cost_sheet.dart';
import 'package:sportify_app/features/payment/presentation/views/wallet_phone_number_view.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_success_sheet.dart';

class ReservationView extends StatefulWidget {
  const ReservationView({super.key});

  @override
  State<ReservationView> createState() =>
      _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  int _selectedPaymentMethod =
      0; // 0: Sportify Wallet, 1: Vodafone, 2: Card, 3: Cash
  final TextEditingController _voucherController =
      TextEditingController();

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reservation'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stadium Card
            _buildStadiumCard(),

            SizedBox(height: 20.h),

            // Reserved Time Card
            _buildReservedTimeCard(),

            SizedBox(height: 24.h),

            // Payment Methods Section
            Text(
              'Payment methods',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 16.h),

            // Payment Methods List
            _buildPaymentMethodsCard(),

            SizedBox(height: 24.h),

            // Voucher Section
            _buildVoucherSection(),

            SizedBox(height: 24.h),

            // Payment Summary
            _buildPaymentSummary(),

            SizedBox(
              height: 100.h,
            ), // Space for fixed button
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Capture root navigator context before any navigation
                final rootNavigator = Navigator.of(
                  context,
                  rootNavigator: true,
                );
                final rootContext = rootNavigator.context;

                // Check if Vodafone cash is selected (index 1)
                if (_selectedPaymentMethod == 1) {
                  // Navigate to Wallet Phone Number screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const WalletPhoneNumberView(),
                    ),
                  );
                } else {
                  // Show Payment Success sheet for other payment methods
                  showModalBottomSheet(
                    context: rootContext,
                    isScrollControlled: false,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) =>
                        const PaymentSuccessSheet(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Stadium Card
  Widget _buildStadiumCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Stadium Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              ImgAssets.lightYard,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80.w,
                  height: 80.w,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),

          SizedBox(width: 16.w),

          // Stadium Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stadium name',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.sp,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Arab Elmaadi',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '5 X 5',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      'Indoor',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reserved Time Card
  Widget _buildReservedTimeCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Reserved time',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to edit time
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Time Details
          Row(
            children: [
              Text(
                'Monday',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '10 July 2023',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '4 PM - 6 PM',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Payment Methods Card
  Widget _buildPaymentMethodsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Sportify Wallet
          _PaymentMethodTile(
            iconPath: ImgAssets.sportifyWallet,
            title: 'Sportify Wallet',
            price: '100 EGP',
            isSelected: _selectedPaymentMethod == 0,
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 0;
              });
            },
          ),

          Divider(height: 1, color: Colors.grey[200]),

          // Vodafone Cash
          _PaymentMethodTile(
            iconPath: ImgAssets.vodafoneCash,
            title: 'Vodafone cash, WE Pay ..',
            isSelected: _selectedPaymentMethod == 1,
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 1;
              });
            },
          ),

          Divider(height: 1, color: Colors.grey[200]),

          // Debit / Credit Card
          _PaymentMethodTile(
            iconPath: ImgAssets.creditCard,
            title: 'Debit / Credit Card',
            isSelected: _selectedPaymentMethod == 2,
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 2;
              });
            },
          ),

          Divider(height: 1, color: Colors.grey[200]),

          // Cash Payment
          _PaymentMethodTile(
            iconPath: ImgAssets.cashMoney,
            title: 'Cash Payment',
            subtitle:
                'Will need the approval of the stadium owner first',
            isSelected: _selectedPaymentMethod == 3,
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 3;
              });
            },
          ),

          SizedBox(height: 16.h),

          // Sharing the Booking Cost Card
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.r),
                  ),
                ),
                builder: (context) =>
                    const SharingCostSheet(),
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  // Text
                  Expanded(
                    child: Text(
                      'Sharing the booking cost',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Trailing Icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ImgAssets.sharingSubscription,
                        width: 28.w,
                        height: 28.w,
                        errorBuilder:
                            (context, error, stackTrace) {
                              return Icon(
                                Icons.handshake,
                                color: MyColors.greenButton,
                                size: 24.sp,
                              );
                            },
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey[600],
                        size: 20.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Voucher Section
  Widget _buildVoucherSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Voucher',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _voucherController,
          decoration: InputDecoration(
            hintText: 'Enter voucher code',
            prefixIcon: Icon(
              Icons.card_giftcard,
              color: Colors.grey[600],
              size: 24.sp,
            ),
            suffixIcon: TextButton(
              onPressed: () {
                // TODO: Handle voucher submission
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.greenButton,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: MyColors.greenButton,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Payment Summary
  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Cost
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Cost',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                '100 EGP',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Your Cost
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Cost',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                '100 EGP',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Divider(height: 1, color: Colors.grey[200]),

          SizedBox(height: 16.h),

          // Sharing Cost Row
          InkWell(
            onTap: () {
              // TODO: Open sharing cost bottom sheet
            },
            child: Row(
              children: [
                Image.asset(
                  ImgAssets.sharingSubscription,
                  width: 40.w,
                  height: 40.w,
                  errorBuilder:
                      (context, error, stackTrace) {
                        return Icon(
                          Icons.people,
                          size: 40.sp,
                          color: MyColors.greenButton,
                        );
                      },
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Sharing the booking cost',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Payment Method Tile Widget
class _PaymentMethodTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? price;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.iconPath,
    required this.title,
    this.price,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            // Icon
            Image.asset(
              iconPath,
              width: 40.w,
              height: 40.w,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  child: Icon(
                    Icons.payment,
                    size: 24.sp,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),

            SizedBox(width: 16.w),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (price != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      price!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? MyColors.greenButton
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: 12.w),

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
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
