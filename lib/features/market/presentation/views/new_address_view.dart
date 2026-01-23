import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/market/presentation/widgets/custom_text_field.dart';
import 'package:sportify_app/features/market/presentation/widgets/phone_input_field.dart';

class NewAddressView extends StatefulWidget {
  const NewAddressView({super.key});

  @override
  State<NewAddressView> createState() =>
      _NewAddressViewState();
}

class _NewAddressViewState extends State<NewAddressView> {
  final TextEditingController _regionController =
      TextEditingController();
  final TextEditingController _streetController =
      TextEditingController();
  final TextEditingController _buildingController =
      TextEditingController();
  final TextEditingController _floorController =
      TextEditingController();
  final TextEditingController _apartmentController =
      TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController();

  @override
  void dispose() {
    _regionController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleCheckout() {
    // Navigate to Checkout Summary View
    if (!context.mounted) return;
    context.push(
      Routes.checkoutSummaryRoute,
      extra: {
        'address': 'Cairo (Maadi)',
        'street': '8 street 9, floor 5, department 15',
        'mobile': _phoneController.text.isNotEmpty
            ? _phoneController.text
            : '01101110101',
      },
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
          'Delivery Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Map Header Section
          Stack(
            children: [
              // Map Image
              Container(
                width: double.infinity,
                height: 250.h,
                color: Colors.grey[200],
                child: Image.asset(
                  ImgAssets.mapPlaceholder,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.map,
                            size: 60.sp,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                ),
              ),

              // Detect Location Button
              Positioned(
                bottom: 20.h,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement location detection
                      debugPrint('Detect Location tapped');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.greenButton,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 14.h,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Detect Location',
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

          // Form Fields Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Region Field
                  CustomTextField(
                    hintText: 'Region',
                    controller: _regionController,
                  ),
                  SizedBox(height: 16.h),

                  // Street Name Field
                  CustomTextField(
                    hintText: 'Street name',
                    controller: _streetController,
                  ),
                  SizedBox(height: 16.h),

                  // Building Number Field
                  CustomTextField(
                    hintText: 'Building number',
                    controller: _buildingController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),

                  // Floor Number Field
                  CustomTextField(
                    hintText: 'Floor number',
                    controller: _floorController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),

                  // Apartment Number Field
                  CustomTextField(
                    hintText: 'Apartment number',
                    controller: _apartmentController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),

                  // Phone Number Field
                  PhoneInputField(
                    controller: _phoneController,
                  ),
                ],
              ),
            ),
          ),

          // Checkout Button
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.05,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _handleCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: MyColors.grey300,
                  disabledForegroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
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
