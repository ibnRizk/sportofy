import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_success_sheet.dart';

class WalletPhoneNumberView extends StatefulWidget {
  const WalletPhoneNumberView({super.key});

  @override
  State<WalletPhoneNumberView> createState() => _WalletPhoneNumberViewState();
}

class _WalletPhoneNumberViewState extends State<WalletPhoneNumberView> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Wallet Phone Number',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Instruction Text
            Text(
              'Please enter the phone number registered with your mobile wallet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            SizedBox(height: 30.h),

            // Phone Input Field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your Phone number',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 12.w,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Egypt Flag
                      Image.asset(
                        ImgAssets.egyptFlag,
                        width: 24.w,
                        height: 24.w,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.flag,
                              size: 16.sp,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8.w),
                      // Country Code
                      Text(
                        '+20',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Vertical Divider
                      Container(
                        width: 1,
                        height: 20.h,
                        color: Colors.grey[300],
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: MyColors.greenButton,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Disclaimer Text
            Text(
              'Payment with mobile digital wallets is only available for Egypt',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
              onPressed: () {
                // TODO: Implement phone number validation and payment processing
                if (_phoneController.text.isNotEmpty) {
                  // Close the wallet phone number screen
                  Navigator.pop(context);

                  // Show Payment Success sheet
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                        ),
                        builder: (context) => const PaymentSuccessSheet(),
                      );
                    }
                  });
                }
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
