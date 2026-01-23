import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/features/market/presentation/widgets/cart_item_tile.dart';
import 'package:sportify_app/features/market/presentation/widgets/cart_summary_section.dart';
import 'package:sportify_app/features/market/presentation/widgets/delivery_address_sheet.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Mock cart items data
  List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Adidas barricade',
      'price': 3200.0,
      'image': ImgAssets.shoes,
      'color': 'Green',
      'size': 41,
      'quantity': 1,
    },
    {
      'id': '2',
      'name': 'Adidas barricade',
      'price': 3200.0,
      'image': ImgAssets.whiteShoes,
      'color': 'Black',
      'size': 41,
      'quantity': 2,
    },
    {
      'id': '3',
      'name': 'Adidas barricade',
      'price': 3200.0,
      'image': ImgAssets.smallShoes,
      'color': 'Black',
      'size': 41,
      'quantity': 2,
    },
  ];

  double get _subtotal {
    return _cartItems.fold(
      0.0,
      (sum, item) =>
          sum +
          (item['price'] as double) *
              (item['quantity'] as int),
    );
  }

  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      final itemIndex = _cartItems.indexWhere(
        (item) => item['id'] == itemId,
      );
      if (itemIndex != -1) {
        if (newQuantity <= 0) {
          _cartItems.removeAt(itemIndex);
        } else {
          _cartItems[itemIndex]['quantity'] = newQuantity;
        }
      }
    });
  }

  void _handleCheckout() {
    if (_cartItems.isEmpty) return;

    // Show Delivery Address Sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.top30,
      ),
      builder: (context) => const DeliveryAddressSheet(),
    );
  }

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
            color: MyColors.darkGrayColor,
            size: AppDimens.iconSize24,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'My Cart',
          style: TextStyles.semiBold18(
            color: MyColors.darkGrayColor,
          ),
        ),
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: AppPadding.p20,
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return CartItemTile(
                        imageUrl: item['image'] as String,
                        name: item['name'] as String,
                        price:
                            '${item['price'].toStringAsFixed(0)} EGP',
                        color: item['color'] as String,
                        size: item['size'] as int,
                        quantity: item['quantity'] as int,
                        onIncrease: () {
                          _updateQuantity(
                            item['id'] as String,
                            (item['quantity'] as int) + 1,
                          );
                        },
                        onDecrease: () {
                          _updateQuantity(
                            item['id'] as String,
                            (item['quantity'] as int) - 1,
                          );
                        },
                        onDelete: () {
                          _updateQuantity(
                            item['id'] as String,
                            0,
                          );
                        },
                      );
                    },
                  ),
                ),

                // Summary and Checkout Section
                CartSummarySection(
                  subtotal: _subtotal,
                  onCheckout: _handleCheckout,
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: AppPadding.p40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: AppDimens.iconSize100,
              color: MyColors.grey400,
            ),
            SizedBox(height: AppDimens.h24),
            Text(
              'Your cart is empty',
              style: TextStyles.bold20(
                color: MyColors.black87,
              ),
            ),
            SizedBox(height: AppDimens.h12),
            Text(
              'Add some products to your cart to continue shopping',
              style: TextStyles.regular14(
                color: MyColors.darkGrayColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimens.h32),
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: ElevatedButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
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
                  'Go Shopping',
                  style: TextStyles.bold16(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
