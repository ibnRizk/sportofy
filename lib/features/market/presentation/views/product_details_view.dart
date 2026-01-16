import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/market/presentation/widgets/color_picker.dart';
import 'package:sportify_app/features/market/presentation/widgets/size_picker.dart';

class ProductDetailsView extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  String _selectedColor = 'Green';
  int? _selectedSize;
  int _quantity = 1;

  final List<String> _colors = ['Green', 'White'];
  final List<int> _sizes = [38, 39, 40, 41, 42, 43, 44];

  // Mock product images
  final List<String> _productImages = [
    ImgAssets.smallShoes,
    ImgAssets.whiteShoes,
    ImgAssets.shoes,
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  _buildImageSection(),

                  // Product Info
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name and Quantity Selector Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product['name'] as String? ??
                                    'Product Name',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Quantity Selector
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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
                                    child: Icon(
                                      _quantity == 1
                                          ? Icons.delete_outline
                                          : Icons.remove,
                                      size: 18.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    _quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_quantity == 0) {
                                          _quantity = 1;
                                        } else {
                                          _quantity++;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 18.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Price
                        Text(
                          widget.product['price'] as String? ?? '0 EGP',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Color Picker
                        ColorPicker(
                          colors: _colors,
                          selectedColor: _selectedColor,
                          onColorSelected: (color) {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                        ),

                        SizedBox(height: 32.h),

                        // Size Picker
                        SizePicker(
                          sizes: _sizes,
                          selectedSize: _selectedSize,
                          onSizeSelected: (size) {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                        ),

                        SizedBox(height: 32.h),

                        // Description Section
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'High-quality football shoes designed for optimal performance on the field. Features advanced cushioning and durable materials.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 100.h), // Space for bottom button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Add to Cart Button
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add to cart logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added to cart successfully!',
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
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Image Slider
        SizedBox(
          height: 350.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: _productImages.length,
            itemBuilder: (context, index) {
              final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
              return Image.asset(
                _productImages[index],
                width: double.infinity,
                fit: BoxFit.cover,
                cacheWidth: (350.h * devicePixelRatio).toInt(),
                cacheHeight: (350.h * devicePixelRatio).toInt(),
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image,
                      size: 50.sp,
                      color: Colors.grey[400],
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Back Button
        Positioned(
          top: 40.h,
          left: 20.w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
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
          ),
        ),

        // Share Button
        Positioned(
          top: 40.h,
          right: 20.w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: Colors.black87,
                size: 24.sp,
              ),
              onPressed: () {
                // TODO: Implement share
              },
            ),
          ),
        ),

        // Page Indicator (Circular Dots)
        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _productImages.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: _currentImageIndex == index ? 10.w : 8.w,
                height: _currentImageIndex == index ? 10.w : 8.w,
                decoration: BoxDecoration(
                  color: _currentImageIndex == index
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
