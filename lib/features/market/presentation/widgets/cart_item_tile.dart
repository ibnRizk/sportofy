import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class CartItemTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String color;
  final int size;
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onDelete;

  const CartItemTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.color,
    required this.size,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.bottom16,
      padding: AppPadding.p12,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey200,
          width: AppDimens.borderWidth1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: AppRadius.r8,
            child: Image.asset(
              imageUrl,
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
                    size: AppDimens.iconSize32,
                    color: MyColors.grey400,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: AppDimens.w12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  name,
                  style: TextStyles.bold16(color: MyColors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppDimens.h4),

                // Color and Size
                Row(
                  children: [
                    // Color Swatch
                    Container(
                      width: AppDimens.w16,
                      height: AppDimens.w16,
                      decoration: BoxDecoration(
                        color: _getColorFromString(color),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.grey300,
                          width: AppDimens.borderWidth1,
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimens.w6),
                    Text(
                      '$size',
                      style: TextStyles.medium12(color: MyColors.grey600),
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.h8),

                // Price
                Text(
                  price,
                  style: TextStyles.bold14(color: MyColors.greenButton),
                ),
              ],
            ),
          ),

          SizedBox(width: AppDimens.w12),

          // Quantity Selector
          Container(
            padding: AppPadding.h8v4,
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: AppRadius.r20,
              border: Border.all(
                color: MyColors.grey300,
                width: AppDimens.borderWidth1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Delete/Decrease Button
                GestureDetector(
                  onTap: quantity == 1 ? onDelete : onDecrease,
                  child: Icon(
                    quantity == 1 ? Icons.delete_outline : Icons.remove,
                    size: AppDimens.iconSize18,
                    color: MyColors.greenButton,
                  ),
                ),
                SizedBox(height: AppDimens.h8),
                // Quantity
                Text(
                  quantity.toString(),
                  style: TextStyles.semiBold14(color: MyColors.black87),
                ),
                SizedBox(height: AppDimens.h8),
                // Add Button
                GestureDetector(
                  onTap: onIncrease,
                  child: Icon(
                    Icons.add,
                    size: AppDimens.iconSize18,
                    color: MyColors.greenButton,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green':
        return MyColors.green;
      case 'white':
        return MyColors.white;
      case 'black':
        return MyColors.black;
      case 'red':
        return MyColors.red;
      case 'blue':
        return MyColors.blue;
      default:
        return MyColors.grey;
    }
  }
}
