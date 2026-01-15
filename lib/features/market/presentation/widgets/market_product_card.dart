import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class MarketProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final int quantity; // 0 means not in cart
  final String productId; // For Hero tag
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
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
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: Hero(
                    tag: 'product_${productId}_0',
                    child: Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: 150.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 150.h,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image,
                            size: 40.sp,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Quantity Selector Overlay
                Positioned(
                  bottom: 8.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: isInCart
                        ? _buildQuantitySelector()
                        : _buildAddButton(),
                  ),
                ),
              ],
            ),

            // Product Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
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

  Widget _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
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
              quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 18.sp,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 12.w),
          // Quantity
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 12.w),
          // Add Button
          GestureDetector(
            onTap: onAdd,
            child: Icon(
              Icons.add,
              size: 18.sp,
              color: Colors.black87,
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
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: MyColors.greenButton,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: MyColors.greenButton.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          size: 20.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
