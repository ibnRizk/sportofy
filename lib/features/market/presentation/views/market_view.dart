import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/market/presentation/widgets/market_product_card.dart';
import 'package:sportify_app/injection_container.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  final TextEditingController _searchController =
      TextEditingController();
  String _selectedCategory = 'Shoes';
  // Mock cart count

  final List<String> _categories = [
    'Shoes',
    'Balls',
    'Bags',
    'Clothes',
  ];

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
        .where(
          (product) =>
              product['category'] == _selectedCategory,
        )
        .toList();
  }

  void _updateProductQuantity(
    String productId,
    int newQuantity,
  ) {
    setState(() {
      final productIndex = _products.indexWhere(
        (p) => p['id'] == productId,
      );
      if (productIndex != -1) {
        _products[productIndex]['quantity'] = newQuantity;
        // Update cart count
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
      backgroundColor: context.colors.backGround,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,

        title: Text(
          'Market',
          style: TextStyles.semiBold18(
            color: MyColors.darkGrayColor,
          ),
        ),

        actions: [
          // Cart Icon in Light Blue/Grey Circle
          Padding(
            padding: EdgeInsets.only(right: AppDimens.w16),
            child: GestureDetector(
              onTap: () {
                context.push(Routes.cartRoute);
              },
              child: Container(
                width: AppDimens.iconSize40,
                height: AppDimens.iconSize40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    59,
                    134,
                    177,
                    237,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/cart.svg',
                      width: AppDimens.iconSize20,
                      height: AppDimens.iconSize20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: AppDimens.h16),
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.w20,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: MyColors.darkGrayColor,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyles.regular14(
                  color: MyColors.darkGrayColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyles.regular14(
                    color: MyColors.darkGrayColor,
                  ),
                  prefixIcon: Padding(
                    padding: AppPadding.p12,
                    child: Icon(
                      Icons.search,
                      size: AppDimens.iconSize20,
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppDimens.w16,
                    vertical: AppDimens.h12,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimens.h16),

          // Categories
          SizedBox(
            height: 42.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.w20,
              ),
              itemCount: _categories.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: AppDimens.w12),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected =
                    _selectedCategory == category;
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
                          : MyColors.white,
                      borderRadius: AppRadius.r20,
                      border: isSelected
                          ? null
                          : Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyles.medium14(
                          color: isSelected
                              ? MyColors.white
                              : MyColors.darkGrayColor,
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
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.w20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _selectedCategory,
                style: TextStyles.semiBold16(
                  color: MyColors.darkGrayColor,
                ),
              ),
            ),
          ),

          SizedBox(height: AppDimens.h16),

          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.w20,
              ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
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
