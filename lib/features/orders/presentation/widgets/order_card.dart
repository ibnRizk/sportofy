import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String receivedDate;
  final String status;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.receivedDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/order-details');
      },
      child: Container(
        margin: AppPadding.bottom16,
        padding: AppPadding.p16,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.r12,
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withValues(alpha: AppDimens.opacity05),
              blurRadius: AppDimens.elevation8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Order ID + Status Badge
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID : $orderId',
                  style: TextStyles.bold14(color: MyColors.black87),
                ),
                _buildStatusBadge(),
              ],
            ),

            SizedBox(height: AppDimens.h12),

            // Info Section
            Text(
              'Order date: $orderDate',
              style: TextStyles.regular13(color: MyColors.grey600),
            ),
            SizedBox(height: AppDimens.h4),
            Text(
              'Received date: $receivedDate',
              style: TextStyles.regular13(color: MyColors.grey600),
            ),

            // Divider
            Divider(
              height: AppDimens.h24,
              thickness: AppDimens.dividerThickness1,
              color: MyColors.grey200,
            ),

            // Footer Action Button
            Align(
              alignment: Alignment.centerRight,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'ordered':
        bgColor = MyColors.lightBlue100; // Light Blue
        textColor = MyColors.blue700; // Blue
        break;
      case 'canceled':
        bgColor = MyColors.red100; // Light Red
        textColor = MyColors.red700; // Red
        break;
      case 'shipped':
        bgColor = MyColors.orange.withValues(alpha: AppDimens.opacity1); // Light Orange
        textColor = MyColors.orange; // Orange
        break;
      case 'delivered':
        bgColor = MyColors.green.withValues(alpha: AppDimens.opacity1); // Light Green
        textColor = MyColors.green; // Green
        break;
      default:
        bgColor = MyColors.grey200;
        textColor = MyColors.grey700;
    }

    return Container(
      padding: AppPadding.h12v6,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.r4,
      ),
      child: Text(
        status,
        style: TextStyles.medium13(color: textColor),
      ),
    );
  }

  Widget _buildActionButton() {
    // Determine button properties based on status
    String buttonText;
    Color borderColor;
    Color textColor;
    bool isDisabled = false;
    IconData? icon;

    if (status.toLowerCase() == 'ordered') {
      buttonText = 'Cancel';
      borderColor = MyColors.red700; // Red
      textColor = MyColors.red700;
    } else if (status.toLowerCase() == 'shipped') {
      buttonText = 'Cancel';
      borderColor = MyColors.grey300;
      textColor = MyColors.grey400;
      isDisabled = true;
    } else if (status.toLowerCase() == 'canceled' ||
        status.toLowerCase() == 'delivered') {
      buttonText = 'Reorder';
      borderColor = MyColors.green; // Green
      textColor = MyColors.green;
      icon = Icons.refresh;
    } else {
      buttonText = 'Action';
      borderColor = MyColors.grey300;
      textColor = MyColors.grey700;
    }

    return OutlinedButton(
      onPressed: isDisabled
          ? null
          : () {
              // TODO: Implement action logic
            },
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: AppDimens.borderWidth2),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.r8,
        ),
        padding: AppPadding.h24v10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppDimens.iconSize18, color: textColor),
            SizedBox(width: AppDimens.w6),
          ],
          Text(
            buttonText,
            style: TextStyles.medium14(),
          ),
        ],
      ),
    );
  }
}
