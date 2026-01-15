import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
          top: 20.h,
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
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
                      color: Colors.black,
                      size: 24.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Payment methods',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

          SizedBox(height: 20.h),

          // Payment Options List
          _buildPaymentOption(
            id: 'sportify_wallet',
            iconPath: ImgAssets.sportifyWallet,
            title: 'Spotify Wallet',
            trailing: Text(
              '100 EGP',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: MyColors.greenButton,
              ),
            ),
          ),

          Divider(height: 1, color: Colors.grey[200]),

          _buildPaymentOption(
            id: 'vodafone_cash',
            iconPath: ImgAssets.vodafoneCash,
            title: 'Vodafone cash, WE Pay ...',
          ),

          Divider(height: 1, color: Colors.grey[200]),

          _buildPaymentOption(
            id: 'card',
            iconPath: ImgAssets.creditCard,
            title: 'Debit / Credit Card',
          ),

          Divider(height: 1, color: Colors.grey[200]),

          _buildPaymentOption(
            id: 'cash',
            iconPath: ImgAssets.cashMoney,
            title: 'Cash Payment',
            subtitle: 'Will need the approval of the owner first',
          ),

          SizedBox(height: 16.h),

          // The Special Action Card (Sharing Cost)
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
                builder: (context) => const SharingCostSheet(),
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
                      'Sharing the subscription cost',
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
                        errorBuilder: (context, error, stackTrace) {
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

          SizedBox(height: 24.h),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
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
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
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
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                        ),
                        builder: (context) => const PaymentSuccessSheet(),
                      );
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
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
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Icon/Logo
            Container(
              width: 45.w,
              height: 45.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.payment,
                    color: MyColors.greenButton,
                    size: 24.sp,
                  );
                },
              ),
            ),

            SizedBox(width: 12.w),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
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
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Trailing (Balance or Radio)
            if (trailing != null)
              trailing
            else
              SizedBox(width: 4.w),

            SizedBox(width: 8.w),

            // Radio Button
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? MyColors.greenButton : Colors.grey[400]!,
                  width: isSelected ? 6.w : 2.w,
                ),
                color: isSelected ? MyColors.greenButton : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
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
