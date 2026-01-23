import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/matches/presentation/widgets/join_request_sheet.dart';
import 'package:sportify_app/features/payment/presentation/views/wallet_phone_number_view.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_success_sheet.dart';
import 'package:sportify_app/features/payment/presentation/widgets/sharing_cost_sheet.dart';

class PaymentMethodsSheet extends StatefulWidget {
  final String? organizerName;
  final String? organizerAvatar;

  const PaymentMethodsSheet({
    super.key,
    this.organizerName,
    this.organizerAvatar,
  });

  @override
  State<PaymentMethodsSheet> createState() => _PaymentMethodsSheetState();
}

class _PaymentMethodsSheetState extends State<PaymentMethodsSheet> {
  String _selectedMethod = 'sportify_wallet';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: AppDimens.h20,
          left: AppDimens.w20,
          right: AppDimens.w20,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppDimens.h20,
        ),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.top30,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColors.black,
                      size: AppDimens.iconSize24,
                    ),
                    padding: AppPadding.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: AppDimens.w12),
                  Text(
                    'Payment methods',
                    style: TextStyles.bold18(color: MyColors.black),
                  ),
                ],
              ),

          SizedBox(height: AppDimens.h20),

          // Payment Options List
          _buildPaymentOption(
            id: 'sportify_wallet',
            iconPath: ImgAssets.sportifyWallet,
            title: 'Spotify Wallet',
            trailing: Text(
              '100 EGP',
              style: TextStyles.semiBold14(color: MyColors.greenButton),
            ),
          ),

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

          _buildPaymentOption(
            id: 'vodafone_cash',
            iconPath: ImgAssets.vodafoneCash,
            title: 'Vodafone cash, WE Pay ...',
          ),

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

          _buildPaymentOption(
            id: 'card',
            iconPath: ImgAssets.creditCard,
            title: 'Debit / Credit Card',
          ),

          Divider(height: AppDimens.dividerThickness1, color: MyColors.grey200),

          _buildPaymentOption(
            id: 'cash',
            iconPath: ImgAssets.cashMoney,
            title: 'Cash Payment',
            subtitle: 'Will need the approval of the owner first',
          ),

          SizedBox(height: AppDimens.h16),

          // The Special Action Card (Sharing Cost)
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: MyColors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.top25,
                ),
                builder: (context) => const SharingCostSheet(),
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
                      'Sharing the subscription cost',
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
                        errorBuilder: (context, error, stackTrace) {
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

          SizedBox(height: AppDimens.h24),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: () {
                // Store the selected method and root navigator before popping
                final selectedMethod = _selectedMethod;
                final rootNavigator = Navigator.of(context, rootNavigator: true);

                // Close the payment methods sheet first
                Navigator.pop(context);

                // Use Future.delayed to ensure smooth transition
                Future.delayed(const Duration(milliseconds: 300), () {
                  // Check if Vodafone cash is selected
                  if (selectedMethod == 'vodafone_cash') {
                    // Navigate to Wallet Phone Number screen
                    Navigator.push(
                      rootNavigator.context,
                      MaterialPageRoute(
                        builder: (context) => const WalletPhoneNumberView(),
                      ),
                    );
                  } else {
                    // Show Join Request Sheet if organizer info is provided (for match join flow)
                    // Otherwise show Payment Success Sheet (for other flows)
                    if (widget.organizerName != null &&
                        widget.organizerAvatar != null) {
                      showModalBottomSheet(
                        context: rootNavigator.context,
                        isScrollControlled: true,
                        backgroundColor: MyColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.top30,
                        ),
                        builder: (context) => JoinRequestSheet(
                          organizerName: widget.organizerName!,
                          organizerAvatar: widget.organizerAvatar!,
                        ),
                      );
                    } else {
                      // Show Payment Success sheet for other payment methods
                      showModalBottomSheet(
                        context: rootNavigator.context,
                        isScrollControlled: true,
                        backgroundColor: MyColors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.top30,
                        ),
                        builder: (context) => const PaymentSuccessSheet(),
                      );
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r10,
                ),
                elevation: AppDimens.elevation0,
              ),
              child: Text(
                'Confirm',
                style: TextStyles.bold16(color: MyColors.white),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required String iconPath,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    final bool isSelected = _selectedMethod == id;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = id;
        });
      },
      child: Padding(
        padding: AppPadding.v12,
        child: Row(
          children: [
            // Icon/Logo
            Container(
              width: AppDimens.containerHeight45,
              height: AppDimens.containerHeight45,
              padding: AppPadding.p8,
              decoration: BoxDecoration(
                color: MyColors.grey50,
                borderRadius: AppRadius.r8,
                border: Border.all(
                  color: MyColors.grey200,
                  width: AppDimens.borderWidth1,
                ),
              ),
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.payment,
                    color: MyColors.greenButton,
                    size: AppDimens.iconSize24,
                  );
                },
              ),
            ),

            SizedBox(width: AppDimens.w12),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyles.medium15(color: MyColors.black87),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppDimens.h2),
                    Text(
                      subtitle,
                      style: TextStyles.regular12(color: MyColors.darkGrayColor),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: AppDimens.w8),

            // Trailing (Balance or Radio)
            if (trailing != null)
              trailing
            else
              SizedBox(width: AppDimens.w4),

            SizedBox(width: AppDimens.w8),

            // Radio Button
            Container(
              width: AppDimens.w20,
              height: AppDimens.w20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? MyColors.greenButton : MyColors.grey400,
                  width: isSelected ? AppDimens.w6 : AppDimens.borderWidth2,
                ),
                color: isSelected ? MyColors.greenButton : MyColors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: AppDimens.w8,
                        height: AppDimens.w8,
                        decoration: const BoxDecoration(
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
