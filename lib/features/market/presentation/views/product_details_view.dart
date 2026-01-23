import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';
import 'package:sportify_app/features/market/presentation/widgets/color_picker.dart';
import 'package:sportify_app/features/market/presentation/widgets/size_picker.dart';

class ProductDetailsView extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState
    extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  String _selectedColor = 'Green';
  int? _selectedSize;
  int _quantity = 1;

  final List<String> _colors = ['Green', 'White'];
  final List<int> _sizes = [38, 39, 40, 41, 42, 43, 44];

  // Product images
  final List<String> _productImages = [
    ImgAssets.whiteShoes,
    ImgAssets.whiteShoes1,
    ImgAssets.whiteShoes2,
    ImgAssets.whiteShoes3,
  ];

  @override
  void initState() {
    super.initState();
    _selectedSize = 40; // Default to size 40
    _quantity = 2; // Default quantity as shown in image
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Image Section
                  _buildImageSection(),

                  // Product Info
                  Padding(
                    padding: AppPadding.p20,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Product Name and Quantity Selector Row
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product['name']
                                        as String? ??
                                    'Product Name',
                                style: TextStyles.bold18(
                                  color: context
                                      .colors
                                      .textColor,
                                ),
                              ),
                            ),
                            SizedBox(width: AppDimens.w12),
                            // Quantity Selector (like photo)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.w12,
                                vertical: AppDimens.h8,
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                      8.r,
                                    ),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_quantity > 1) {
                                        setState(() {
                                          _quantity--;
                                        });
                                      } else {
                                        setState(() {
                                          _quantity = 0;
                                        });
                                      }
                                    },
                                    child: _quantity == 1
                                        ? SvgPicture.asset(
                                            ImgAssets
                                                .icTrash,
                                            width: AppDimens
                                                .iconSize18,
                                            height: AppDimens
                                                .iconSize18,
                                            colorFilter:
                                                const ColorFilter.mode(
                                                  MyColors
                                                      .greenButton,
                                                  BlendMode
                                                      .srcIn,
                                                ),
                                          )
                                        : Icon(
                                            Icons.remove,
                                            size: AppDimens
                                                .iconSize18,
                                            color: MyColors
                                                .greenButton,
                                          ),
                                  ),
                                  SizedBox(
                                    width: AppDimens.w12,
                                  ),
                                  Text(
                                    _quantity.toString(),
                                    style:
                                        TextStyles.medium16(
                                          color: MyColors
                                              .darkGrayColor,
                                        ),
                                  ),
                                  SizedBox(
                                    width: AppDimens.w12,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_quantity ==
                                            0) {
                                          _quantity = 1;
                                        } else {
                                          _quantity++;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: AppDimens
                                          .iconSize18,
                                      color: MyColors
                                          .greenButton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppDimens.h8),

                        // Price
                        Text(
                          widget.product['price']
                                  as String? ??
                              '0 EGP',
                          style: TextStyles.bold20(
                            color: context.colors.textColor,
                          ),
                        ),

                        SizedBox(height: AppDimens.h24),

                        // Divider
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey[200]!,
                        ),

                        SizedBox(height: AppDimens.h24),

                        // Color Picker Section with Container
                        Text(
                          'Choose the color',
                          style: TextStyles.bold16(
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(
                            AppDimens.w16,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: ColorPicker(
                            colors: _colors,
                            selectedColor: _selectedColor,
                            onColorSelected: (color) {
                              setState(() {
                                _selectedColor = color;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: AppDimens.h16),

                        // Size Picker Section with Container
                        Text(
                          'Choose the Size',
                          style: TextStyles.bold16(
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(height: AppDimens.h12),
                        Container(
                          padding: EdgeInsets.all(
                            AppDimens.w16,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: SizePicker(
                            sizes: _sizes,
                            selectedSize: _selectedSize,
                            onSizeSelected: (size) {
                              setState(() {
                                _selectedSize = size;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: AppDimens.h32),

                        // Description Section
                        Text(
                          'Description',
                          style: TextStyles.bold16(
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(height: AppDimens.h12),
                        Text(
                          'High-quality football shoes designed for optimal performance on the field. Features advanced cushioning and durable materials.',
                          style: TextStyles.regular14(
                            color: MyColors.grey600,
                          ).copyWith(height: 1.5),
                        ),

                        SizedBox(
                          height: AppDimens.h100,
                        ), // Space for bottom button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Add to Cart Button
          Container(
            padding: AppPadding.p20,
            decoration: BoxDecoration(
              color: context.colors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColors.black.withValues(
                    alpha: AppDimens.opacity05,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add to cart logic
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added to cart successfully!',
                        style: TextStyles.medium14(),
                      ),
                      backgroundColor: MyColors.greenButton,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.r8,
                      ),
                    ),
                  );
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
                  'Add to Cart',
                  style: TextStyles.semiBold20(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      color: MyColors.white,
      child: Stack(
        children: [
          // Image Slider with White Background
          Container(
            height: AppDimens.containerHeight350,
            color: MyColors.white,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: _productImages.length,
              itemBuilder: (context, index) {
                return Container(
                  color: MyColors.white,
                  child: Image.asset(
                    _productImages[index],
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            color: MyColors.grey200,
                            child: Icon(
                              Icons.image,
                              size: AppDimens.iconSize50,
                              color: MyColors.grey400,
                            ),
                          );
                        },
                  ),
                );
              },
            ),
          ),

          // Back Button
          Positioned(
            top: AppDimens.h40,
            left: AppDimens.w20,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.white.withValues(
                  alpha: AppDimens.opacity9,
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: context.colors.textColor,
                  size: AppDimens.iconSize24,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),

          // Share Button
          Positioned(
            top: AppDimens.h40,
            right: AppDimens.w20,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.white.withValues(
                  alpha: AppDimens.opacity9,
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: context.colors.textColor,
                  size: AppDimens.iconSize24,
                ),
                onPressed: () {
                  // TODO: Implement share
                },
              ),
            ),
          ),

          // Page Indicator (Circular Dots at bottom)
          Positioned(
            bottom: AppDimens.h20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _productImages.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppDimens.w4,
                  ),
                  width: _currentImageIndex == index
                      ? AppDimens.w10
                      : AppDimens.w8,
                  height: _currentImageIndex == index
                      ? AppDimens.h10
                      : AppDimens.h8,
                  decoration: BoxDecoration(
                    color: _currentImageIndex == index
                        ? MyColors.white
                        : MyColors.white.withValues(
                            alpha: AppDimens.opacity5,
                          ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
