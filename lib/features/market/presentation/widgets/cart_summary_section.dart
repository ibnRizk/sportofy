import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class CartSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFees;
  final VoidCallback onCheckout;

  const CartSummarySection({
    super.key,
    required this.subtotal,
    this.deliveryFees = 50.0,
    required this.onCheckout,
  });

  double get total => subtotal + deliveryFees;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.p20,
      decoration: BoxDecoration(
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity05,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment Summary Header
          Icon(
            Icons.keyboard_arrow_down,
            color: MyColors.greenButton,
            size: AppDimens.iconSize24,
          ),
          SizedBox(width: AppDimens.w8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Payment summary',
              style: TextStyles.semiBold16(
                color: MyColors.darkGrayColor,
              ),
            ),
          ),
          SizedBox(height: AppDimens.h16),

          // Subtotal
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyles.semiBold16(
                  color: MyColors.darkGrayColor,
                ),
              ),
              Text(
                '${subtotal.toStringAsFixed(0)} EGP',
                style: TextStyles.semiBold16(
                  color: MyColors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.h12),

          // Delivery Fees
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fees',
                style: TextStyles.semiBold16(
                  color: MyColors.darkGrayColor,
                ),
              ),
              Text(
                '${deliveryFees.toStringAsFixed(0)} EGP',
                style: TextStyles.semiBold16(
                  color: MyColors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.h20),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.greenButton,
                foregroundColor: MyColors.white,
                disabledBackgroundColor: MyColors.grey300,
                disabledForegroundColor: MyColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r12,
                ),
                elevation: AppDimens.elevation0,
              ),
              child: Text(
                'Checkout',
                style: TextStyles.semiBold20(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
