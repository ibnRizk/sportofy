import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/market/presentation/widgets/cart_item_tile.dart';
import 'package:sportify_app/features/market/presentation/widgets/cart_summary_section.dart';

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
      (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );
  }

  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      final itemIndex = _cartItems.indexWhere((item) => item['id'] == itemId);
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

    // TODO: Navigate to checkout/payment screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Proceeding to checkout...',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: MyColors.greenButton,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 24.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.w),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return CartItemTile(
                        imageUrl: item['image'] as String,
                        name: item['name'] as String,
                        price: '${item['price'].toStringAsFixed(0)} EGP',
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
                          _updateQuantity(item['id'] as String, 0);
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
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 100.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24.h),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Add some products to your cart to continue shopping',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go Shopping',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
