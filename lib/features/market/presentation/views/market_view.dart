import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';
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
      backgroundColor: context.colors.white,
      appBar: AppBar(
        backgroundColor: context.colors.white,
        elevation: 0,
        title: Text(
          'Market',
          style: TextStyles.bold18(color: context.colors.textColor),
        ),
        centerTitle: true,
        actions: [
          // Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: AppDimens.iconSize24,
                  color: context.colors.textColor,
                ),
                 onPressed: () {
                   context.push(Routes.cartRoute);
                 },
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: AppDimens.w8,
                  top: AppDimens.h8,
                  child: Container(
                    padding: AppPadding.p4,
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: AppDimens.w16,
                      minHeight: AppDimens.h16,
                    ),
                    child: Center(
                      child: Text(
                        _cartItemCount > 9 ? '9+' : _cartItemCount.toString(),
                        style: TextStyles.bold10(color: MyColors.white),
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
            padding: AppPadding.h20v16,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyles.regular14(color: MyColors.grey600),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20.sp,
                  color: MyColors.grey600,
                ),
                filled: true,
                fillColor: MyColors.grey100,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.r12,
                  borderSide: BorderSide.none,
                ),
                contentPadding: AppPadding.h16v12,
              ),
            ),
          ),

          // Categories
          SizedBox(
            height: AppDimens.containerHeight50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppPadding.h20,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => SizedBox(width: AppDimens.w12),
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
                    padding: AppPadding.h20v12,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? MyColors.greenButton
                          : context.colors.white,
                      borderRadius: AppRadius.r20,
                      border: Border.all(
                        color: isSelected
                            ? MyColors.greenButton
                            : MyColors.grey300,
                        width: AppDimens.borderWidth1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyles.medium14(
                          color: isSelected
                              ? MyColors.white
                              : context.colors.textColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Category Title
          Padding(
            padding: AppPadding.h20,
            child: Text(
              _selectedCategory,
              style: TextStyles.bold18(color: context.colors.textColor),
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: AppPadding.h20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppDimens.w12,
                mainAxisSpacing: AppDimens.h16,
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
