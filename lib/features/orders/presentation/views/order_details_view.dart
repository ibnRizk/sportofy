import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backGround,
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
          'Order Details',
          style: TextStyles.semiBold18(
            color: context.colors.textColor,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.p20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Arriving Date',
              style: TextStyles.semiBold16(
                color: MyColors.black87,
              ),
            ),
            SizedBox(height: AppDimens.h12),

            // Section 1: Arriving Date (Tracker Card)
            _buildArrivingDateCard(),

            SizedBox(height: AppDimens.h24),

            // Section 2: Delivery Location
            Text(
              'Delivery Location',
              style: TextStyles.semiBold16(
                color: context.colors.textColor,
              ),
            ),
            SizedBox(height: AppDimens.h12),
            _buildDeliveryLocationCard(),

            SizedBox(height: AppDimens.h24),

            // Section 3: Order Summary
            Text(
              'Order Summary',
              style: TextStyles.bold16(
                color: MyColors.black87,
              ),
            ),
            SizedBox(height: AppDimens.h12),
            _buildOrderSummaryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildArrivingDateCard() {
    return Container(
      padding: AppPadding.p20,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity05,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Arriving by 10 July',
                style: TextStyles.medium12(
                  color: MyColors.darkGrayColor,
                ),
              ),
              Text(
                'Order ID : 9287KJ',
                style: TextStyles.medium10(
                  color: MyColors.darkGrayColor,
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h24),

          // The Custom Tracker
          _buildProgressTracker(),

          SizedBox(height: AppDimens.h24),

          // Buttons Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: null, // Disabled
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MyColors.grey400,
                    side: BorderSide(
                      color: MyColors.grey300,
                      width: AppDimens.borderWidth1_5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r8,
                    ),
                    padding: AppPadding.v12,
                  ),
                  child: Text(
                    'Cancel Order',
                    style: TextStyles.medium14(
                      color: MyColors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppDimens.w12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Implement help & support
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MyColors.greenButton,
                    side: BorderSide(
                      color: MyColors.greenButton,
                      width: AppDimens.borderWidth1_5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r8,
                    ),
                    padding: AppPadding.v12,
                  ),
                  child: Text(
                    'Help & Support',
                    style: TextStyles.medium14(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracker() {
    final Color activeColor = MyColors.cyan;
    final Color inactiveColor = MyColors.grey400;

    return Column(
      children: [
        // Labels Row
        Row(
          children: [
            Expanded(
              child: Text(
                'Ordered',
                textAlign: TextAlign.center,
                style: TextStyles.medium13(
                  color: activeColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Shipped',
                textAlign: TextAlign.center,
                style: TextStyles.medium13(
                  color: activeColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Delivered',
                textAlign: TextAlign.center,
                style: TextStyles.medium13(
                  color: inactiveColor,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: AppDimens.h8),

        // Dots and Lines Row
        Row(
          children: [
            // First Dot (Active)
            Container(
              width: AppDimens.w12,
              height: AppDimens.w12,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),

            // First Line (Active)
            Expanded(
              child: Container(
                height: AppDimens.h2,
                color: activeColor,
              ),
            ),

            // Second Dot (Active)
            Container(
              width: AppDimens.w12,
              height: AppDimens.w12,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),

            // Second Line (Inactive)
            Expanded(
              child: Container(
                height: AppDimens.h2,
                color: inactiveColor,
              ),
            ),

            // Third Dot (Inactive)
            Container(
              width: AppDimens.w12,
              height: AppDimens.w12,
              decoration: BoxDecoration(
                color: inactiveColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryLocationCard() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity05,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Map Image Placeholder
          Container(
            height: AppDimens.containerHeight150,
            decoration: BoxDecoration(
              color: MyColors.grey200,
              borderRadius: AppRadius.top12,
            ),
            child: Stack(
              children: [
                // Map pattern (you can replace with actual map asset)
                Center(
                  child: Icon(
                    Icons.map,
                    size: AppDimens.iconSize60,
                    color: MyColors.grey400,
                  ),
                ),
                // Green Location Pin
                Center(
                  child: Icon(
                    Icons.location_on,
                    size: AppDimens.iconSize40,
                    color: MyColors.greenButton,
                  ),
                ),
              ],
            ),
          ),

          // Address Info
          Padding(
            padding: AppPadding.p16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: AppDimens.iconSize20,
                  color: MyColors.black87,
                ),
                SizedBox(width: AppDimens.w8),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cairo (Maadi)',
                        style: TextStyles.bold15(
                          color: MyColors.black87,
                        ),
                      ),
                      SizedBox(height: AppDimens.h4),
                      Text(
                        '8 street 9, floor 5, department 15',
                        style: TextStyles.regular13(
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                      SizedBox(height: AppDimens.h4),
                      Text(
                        'Mobile: 01101110101',
                        style: TextStyles.regular13(
                          color: MyColors.darkGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(
              alpha: AppDimens.opacity05,
            ),
            blurRadius: AppDimens.elevation8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: AppDimens.w80,
            height: AppDimens.w80,
            decoration: BoxDecoration(
              color: MyColors.grey100,
              borderRadius: AppRadius.r8,
            ),
            child: ClipRRect(
              borderRadius: AppRadius.r8,
              child: Image.asset(
                'assets/images/shoes.png',
                width: AppDimens.w80,
                height: AppDimens.w80,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 X Adidas barricade',
                  style: TextStyles.medium14(
                    color: MyColors.black87,
                  ),
                ),
                SizedBox(height: AppDimens.h6),
                Text(
                  '3200 EGP',
                  style: TextStyles.bold16(
                    color: MyColors.black87,
                  ),
                ),
                SizedBox(height: AppDimens.h6),
                Row(
                  children: [
                    Container(
                      width: AppDimens.w16,
                      height: AppDimens.w16,
                      decoration: BoxDecoration(
                        color: MyColors.green.withValues(
                          alpha: AppDimens.opacity8,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: AppDimens.w6),
                    Text(
                      '41',
                      style: TextStyles.medium13(
                        color: MyColors.black87,
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
}
