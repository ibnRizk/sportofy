import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

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
          color: context.colors.white,
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
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.top12,
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: AppDimens.containerHeight150,
                    fit: BoxFit.cover,
                    cacheWidth:
                        (AppDimens.containerHeight150 *
                                MediaQuery.of(
                                  context,
                                ).devicePixelRatio)
                            .toInt(),
                    cacheHeight:
                        (AppDimens.containerHeight150 *
                                MediaQuery.of(
                                  context,
                                ).devicePixelRatio)
                            .toInt(),
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: AppDimens.containerHeight150,
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
                // Quantity Selector Overlay
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

            // Product Info
            Padding(
              padding: AppPadding.p12,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.semiBold14(
                      color: context.colors.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimens.h4),
                  Text(
                    price,
                    style: TextStyles.bold14(
                      color: context.colors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      padding: AppPadding.h8v4,
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: AppRadius.r20,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity1),
            blurRadius: AppDimens.elevation4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Delete/Remove Button
          GestureDetector(
            onTap: quantity == 1 ? onDelete : onRemove,
            child: Icon(
              quantity == 1
                  ? Icons.delete_outline
                  : Icons.remove,
              size: AppDimens.iconSize18,
              color: context.colors.textColor,
            ),
          ),
          SizedBox(width: AppDimens.w12),
          // Quantity
          Text(
            quantity.toString(),
            style: TextStyles.semiBold14(
              color: context.colors.textColor,
            ),
          ),
          SizedBox(width: AppDimens.w12),
          // Add Button
          GestureDetector(
            onTap: onAdd,
            child: Icon(
              Icons.add,
              size: AppDimens.iconSize18,
              color: context.colors.textColor,
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
        padding: AppPadding.p8,
        decoration: BoxDecoration(
          color: MyColors.greenButton,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: MyColors.greenButton.withValues(
                alpha: AppDimens.opacity3,
              ),
              blurRadius: AppDimens.elevation8,
              offset: const Offset(0, 2),
            ),
          ],
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
