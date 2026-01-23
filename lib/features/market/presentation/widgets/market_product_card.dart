import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // White Container with Image and Quantity Selector Only
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200.h,
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
                  bottom: 0,
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
        ),

        SizedBox(height: AppDimens.h12),

        // Product Info Below (Outside white container, on scaffold background)
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.w4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: MyColors.darkGrayColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimens.w16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.w16,
        vertical: AppDimens.h8,
      ),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Remove/Delete Button (Green)
          GestureDetector(
            onTap: quantity == 1 ? onDelete : onRemove,
            child: quantity == 1
                ? SvgPicture.asset(
                    ImgAssets.icTrash,
                    width: AppDimens.iconSize20,
                    height: AppDimens.iconSize20,
                    colorFilter: const ColorFilter.mode(
                      MyColors.greenButton,
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(
                    Icons.remove,
                    size: AppDimens.iconSize20,
                    color: MyColors.greenButton,
                  ),
          ),
          SizedBox(width: AppDimens.w12),
          // Quantity
          Text(
            quantity.toString(),
            style: TextStyles.medium16(
              color: MyColors.darkGrayColor,
            ),
          ),
          SizedBox(width: AppDimens.w12),
          // Add Button (Green)
          GestureDetector(
            onTap: onAdd,
            child: Icon(
              Icons.add,
              size: AppDimens.iconSize20,
              color: MyColors.greenButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.w8,
        ),
        child: GestureDetector(
          onTap: onAdd,
          child: Container(
            padding: EdgeInsets.all(AppDimens.w8),
            decoration: BoxDecoration(
              color: MyColors.greenButton,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: MyColors.greenButton.withValues(
                    alpha: 0.3,
                  ),
                  blurRadius: 4,
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
        ),
      ),
    );
  }
}
