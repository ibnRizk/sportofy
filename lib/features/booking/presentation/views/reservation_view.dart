import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
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
      backgroundColor: context.colors.backGround,
      appBar: AppBar(
        title: const Text('Reservation'),
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        iconTheme: const IconThemeData(
          color: MyColors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.p20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stadium Card
            _buildStadiumCard(),

            SizedBox(height: AppDimens.h20),

            // Reserved Time Card
            _buildReservedTimeCard(),

            SizedBox(height: AppDimens.h24),

            // Payment Methods Section
            Text(
              'Payment methods',
              style: TextStyles.bold18(color: MyColors.black87),
            ),

            SizedBox(height: AppDimens.h16),

            // Payment Methods List
            _buildPaymentMethodsCard(),

            SizedBox(height: AppDimens.h24),

            // Voucher Section
            _buildVoucherSection(),

            SizedBox(height: AppDimens.h24),

            // Payment Summary
            _buildPaymentSummary(),

            SizedBox(
              height: AppDimens.h100,
            ), // Space for fixed button
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: AppPadding.p20,
          child: SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
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
                    backgroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.top30,
                    ),
                    builder: (context) =>
                        const PaymentSuccessSheet(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: MyColors.white,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r12,
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyles.bold16(color: MyColors.white),
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
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey200,
          width: AppDimens.borderWidth1,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.grey.withValues(alpha: AppDimens.opacity1),
            spreadRadius: AppDimens.borderWidth1,
            blurRadius: AppDimens.elevation4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Stadium Image
          ClipRRect(
            borderRadius: AppRadius.r8,
            child: Image.asset(
              ImgAssets.lightYard,
              width: AppDimens.containerWidth80,
              height: AppDimens.containerWidth80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: AppDimens.containerWidth80,
                  height: AppDimens.containerWidth80,
                  color: MyColors.grey200,
                  child: Icon(
                    Icons.image,
                    color: MyColors.grey400,
                  ),
                );
              },
            ),
          ),

          SizedBox(width: AppDimens.w16),

          // Stadium Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stadium name',
                  style: TextStyles.bold16(color: MyColors.black87),
                ),
                SizedBox(height: AppDimens.h8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: AppDimens.iconSize16,
                      color: MyColors.grey600,
                    ),
                    SizedBox(width: AppDimens.w4),
                    Text(
                      'Arab Elmaadi',
                      style: TextStyles.regular14(color: MyColors.darkGrayColor),
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.h8),
                Row(
                  children: [
                    Text(
                      '5 X 5',
                      style: TextStyles.medium14(color: MyColors.black87),
                    ),
                    Padding(
                      padding: AppPadding.h8,
                      child: VerticalDivider(
                        width: AppDimens.borderWidth1,
                        thickness: AppDimens.dividerThickness1,
                        color: MyColors.grey300,
                      ),
                    ),
                    Text(
                      'Indoor',
                      style: TextStyles.medium14(color: MyColors.black87),
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
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.grey50,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey200,
          width: AppDimens.borderWidth1,
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
                style: TextStyles.bold16(color: MyColors.black87),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to edit time
                },
                child: Text(
                  'Edit',
                  style: TextStyles.semiBold14(color: MyColors.greenButton),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h12),

          // Time Details
          Row(
            children: [
              Text(
                'Monday',
                style: TextStyles.medium14(color: MyColors.black87),
              ),
              Padding(
                padding: AppPadding.h8,
                child: VerticalDivider(
                  width: AppDimens.borderWidth1,
                  thickness: AppDimens.dividerThickness1,
                  color: MyColors.grey300,
                ),
              ),
              Text(
                '10 July 2023',
                style: TextStyles.medium14(color: MyColors.black87),
              ),
              Padding(
                padding: AppPadding.h8,
                child: VerticalDivider(
                  width: AppDimens.borderWidth1,
                  thickness: AppDimens.dividerThickness1,
                  color: MyColors.grey300,
                ),
              ),
              Text(
                '4 PM - 6 PM',
                style: TextStyles.medium14(color: MyColors.black87),
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
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey200,
          width: AppDimens.borderWidth1,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.grey.withValues(alpha: AppDimens.opacity1),
            spreadRadius: AppDimens.borderWidth1,
            blurRadius: AppDimens.elevation4,
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

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

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

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

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

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

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

          SizedBox(height: AppDimens.h16),

          // Sharing the Booking Cost Card
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: MyColors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.top25,
                ),
                builder: (context) =>
                    const SharingCostSheet(),
              );
            },
            borderRadius: AppRadius.r12,
            child: Container(
              padding: AppPadding.h16v14,
              decoration: BoxDecoration(
                color: MyColors.white,
                border: Border.all(
                  color: MyColors.grey300,
                  width: AppDimens.borderWidth1,
                ),
                borderRadius: AppRadius.r12,
              ),
              child: Row(
                children: [
                  // Text
                  Expanded(
                    child: Text(
                      'Sharing the booking cost',
                      style: TextStyles.medium15(color: MyColors.black87),
                    ),
                  ),

                  // Trailing Icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ImgAssets.sharingSubscription,
                        width: AppDimens.w28,
                        height: AppDimens.w28,
                        errorBuilder:
                            (context, error, stackTrace) {
                              return Icon(
                                Icons.handshake,
                                color: MyColors.greenButton,
                                size: AppDimens.iconSize24,
                              );
                            },
                      ),
                      SizedBox(width: AppDimens.w8),
                      Icon(
                        Icons.chevron_right,
                        color: MyColors.grey600,
                        size: AppDimens.iconSize20,
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
          style: TextStyles.bold16(color: MyColors.black87),
        ),
        SizedBox(height: AppDimens.h12),
        TextFormField(
          controller: _voucherController,
          decoration: InputDecoration(
            hintText: 'Enter voucher code',
            prefixIcon: Icon(
              Icons.card_giftcard,
              color: MyColors.grey600,
              size: AppDimens.iconSize24,
            ),
            suffixIcon: TextButton(
              onPressed: () {
                // TODO: Handle voucher submission
              },
              child: Text(
                'Submit',
                style: TextStyles.bold14(color: MyColors.greenButton),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.r12,
              borderSide: BorderSide(
                color: MyColors.grey300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.r12,
              borderSide: BorderSide(
                color: MyColors.grey300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.r12,
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
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey200,
          width: AppDimens.borderWidth1,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.grey.withValues(alpha: AppDimens.opacity1),
            spreadRadius: AppDimens.borderWidth1,
            blurRadius: AppDimens.elevation4,
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
                style: TextStyles.medium16(color: MyColors.black87),
              ),
              Text(
                '100 EGP',
                style: TextStyles.bold16(color: MyColors.black87),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h12),

          // Your Cost
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Cost',
                style: TextStyles.medium16(color: MyColors.black87),
              ),
              Text(
                '100 EGP',
                style: TextStyles.bold16(color: MyColors.black87),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h16),

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

          SizedBox(height: AppDimens.h16),

          // Sharing Cost Row
          InkWell(
            onTap: () {
              // TODO: Open sharing cost bottom sheet
            },
            child: Row(
              children: [
                Image.asset(
                  ImgAssets.sharingSubscription,
                  width: AppDimens.containerHeight40,
                  height: AppDimens.containerHeight40,
                  errorBuilder:
                      (context, error, stackTrace) {
                        return Icon(
                          Icons.people,
                          size: AppDimens.iconSize40,
                          color: MyColors.greenButton,
                        );
                      },
                ),
                SizedBox(width: AppDimens.w12),
                Expanded(
                  child: Text(
                    'Sharing the booking cost',
                    style: TextStyles.medium16(color: MyColors.black87),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimens.iconSize16,
                  color: MyColors.grey600,
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
        padding: AppPadding.h16v16,
        child: Row(
          children: [
            // Icon
            Image.asset(
              iconPath,
              width: AppDimens.containerHeight40,
              height: AppDimens.containerHeight40,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: AppDimens.containerHeight40,
                  height: AppDimens.containerHeight40,
                  decoration: BoxDecoration(
                    color: MyColors.grey200,
                    borderRadius: AppRadius.r8,
                  ),
                  child: Icon(
                    Icons.payment,
                    size: AppDimens.iconSize24,
                    color: MyColors.grey400,
                  ),
                );
              },
            ),

            SizedBox(width: AppDimens.w16),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.medium16(color: MyColors.black87),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppDimens.h4),
                    Text(
                      subtitle!,
                      style: TextStyles.regular12(color: MyColors.darkGrayColor),
                    ),
                  ],
                  if (price != null) ...[
                    SizedBox(height: AppDimens.h4),
                    Text(
                      price!,
                      style: TextStyles.semiBold14(
                        color: isSelected
                            ? MyColors.greenButton
                            : MyColors.grey600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: AppDimens.w12),

            // Radio Button
            Container(
              width: AppDimens.w24,
              height: AppDimens.w24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey400,
                  width: AppDimens.borderWidth2,
                ),
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: AppDimens.w10,
                        height: AppDimens.w10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
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
