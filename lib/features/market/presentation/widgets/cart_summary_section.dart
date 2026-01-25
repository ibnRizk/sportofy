import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class CartSummarySection extends StatefulWidget {
  final double subtotal;
  final double deliveryFees;
  final VoidCallback onCheckout;

  const CartSummarySection({
    super.key,
    required this.subtotal,
    this.deliveryFees = 50.0,
    required this.onCheckout,
  });

  @override
  State<CartSummarySection> createState() => _CartSummarySectionState();
}

class _CartSummarySectionState extends State<CartSummarySection> {
  bool _isExpanded = true;

  double get total => widget.subtotal + widget.deliveryFees;

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
          // Payment Summary Header with Clickable Arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: MyColors.greenButton,
                  size: AppDimens.iconSize24,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.h8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment summary',
                style: TextStyles.semiBold16(
                  color: MyColors.darkGrayColor,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)} EGP',
                style: TextStyles.semiBold16(
                  color: MyColors.darkGrayColor,
                ),
              ),
            ],
          ),
          
          // Expandable Content
          if (_isExpanded) ...[
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
                  '${widget.subtotal.toStringAsFixed(0)} EGP',
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
                  '${widget.deliveryFees.toStringAsFixed(0)} EGP',
                  style: TextStyles.semiBold16(
                    color: MyColors.black87,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: AppDimens.h20),
          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: AppDimens.buttonHeight50,
            child: ElevatedButton(
              onPressed: widget.onCheckout,
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
