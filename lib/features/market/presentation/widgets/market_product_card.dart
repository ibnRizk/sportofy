import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class MarketProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final int quantity; // 0 means not in cart
  final String productId;
  final VoidCallback onTap;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onDelete;

  const MarketProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 0,
    required this.productId,
    required this.onTap,
    this.onAdd,
    this.onRemove,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isInCart = quantity > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image (60% of card)
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: MyColors.grey200,
                              child: Icon(
                                Icons.image,
                                size: AppDimens.iconSize40,
                                color: MyColors.grey400,
                              ),
                            );
                          },
                    ),
                  ),
                  // Action Row (Add/Counter)
                  Positioned(
                    bottom: AppDimens.h8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: isInCart
                          ? _buildQuantitySelector(context)
                          : _buildAddButton(),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info (40% of card)
            Expanded(
              flex: 4,
              child: Padding(
                padding: AppPadding.p12,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyles.regular14(
                        color: MyColors.darkGrayColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimens.h4),
                    Text(
                      price,
                      style: TextStyles.semiBold16(
                        color: MyColors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.r),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.w45,
        vertical: AppDimens.h4,
      ),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Remove Button (Green)
          GestureDetector(
            onTap: quantity == 1 ? onDelete : onRemove,
            child: Icon(
              quantity == 1
                  ? Icons.delete_outline
                  : Icons.remove,
              size: AppDimens.iconSize18,
              color: MyColors.greenButton,
            ),
          ),
          SizedBox(width: AppDimens.w8),
          // Quantity
          Text(
            quantity.toString(),
            style: TextStyles.medium14(
              color: MyColors.darkGrayColor,
            ),
          ),
          SizedBox(width: AppDimens.w8),
          // Add Button (Green)
          GestureDetector(
            onTap: onAdd,
            child: Icon(
              Icons.add,
              size: AppDimens.iconSize18,
              color: MyColors.greenButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: AppDimens.iconSize40,
        height: AppDimens.iconSize40,
        decoration: BoxDecoration(
          color: MyColors.greenButton,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.add,
          size: AppDimens.iconSize20,
          color: MyColors.white,
        ),
      ),
    );
  }
}
