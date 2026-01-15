import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/market/presentation/widgets/market_product_card.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Shoes';
  int _cartItemCount = 3; // Mock cart count

  final List<String> _categories = ['Shoes', 'Balls', 'Bags', 'Clothes'];

  // Mock products data
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Adidas barricade',
      'price': '3200 EGP',
      'image': ImgAssets.smallShoes,
      'category': 'Shoes',
      'quantity': 1,
    },
    {
      'id': '2',
      'name': 'Adidas barricade',
      'price': '3200 EGP',
      'image': ImgAssets.whiteShoes,
      'category': 'Shoes',
      'quantity': 2,
    },
    {
      'id': '3',
      'name': 'Diadora Football Shoes',
      'price': '838 EGP',
      'image': ImgAssets.shoes,
      'category': 'Shoes',
      'quantity': 0,
    },
    {
      'id': '4',
      'name': 'Adidas barricade',
      'price': '3200 EGP',
      'image': ImgAssets.smallShoes,
      'category': 'Shoes',
      'quantity': 2,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return _products
        .where((product) => product['category'] == _selectedCategory)
        .toList();
  }

  void _updateProductQuantity(String productId, int newQuantity) {
    setState(() {
      final productIndex =
          _products.indexWhere((p) => p['id'] == productId);
      if (productIndex != -1) {
        _products[productIndex]['quantity'] = newQuantity;
        // Update cart count
        _cartItemCount = _products
            .fold(0, (sum, p) => sum + (p['quantity'] as int));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Market',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          // Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 24.sp,
                  color: Colors.black87,
                ),
                 onPressed: () {
                   context.push(Routes.cartRoute);
                 },
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.h,
                    ),
                    child: Center(
                      child: Text(
                        _cartItemCount > 9 ? '9+' : _cartItemCount.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),

          // Categories
          SizedBox(
            height: 50.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? MyColors.greenButton
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? MyColors.greenButton
                            : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16.h),

          // Category Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              _selectedCategory,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return MarketProductCard(
                  imageUrl: product['image'] as String,
                  name: product['name'] as String,
                  price: product['price'] as String,
                  quantity: product['quantity'] as int,
                  productId: product['id'] as String,
                  onTap: () {
                    context.push(
                      Routes.productDetailsRoute,
                      extra: product,
                    );
                  },
                  onAdd: () {
                    _updateProductQuantity(
                      product['id'] as String,
                      (product['quantity'] as int) + 1,
                    );
                  },
                  onRemove: () {
                    _updateProductQuantity(
                      product['id'] as String,
                      (product['quantity'] as int) - 1,
                    );
                  },
                  onDelete: () {
                    _updateProductQuantity(
                      product['id'] as String,
                      0,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
