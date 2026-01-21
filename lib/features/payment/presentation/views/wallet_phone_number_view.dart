import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/payment/presentation/widgets/payment_success_sheet.dart';

class WalletPhoneNumberView extends StatefulWidget {
  const WalletPhoneNumberView({super.key});

  @override
  State<WalletPhoneNumberView> createState() =>
      _WalletPhoneNumberViewState();
}

class _WalletPhoneNumberViewState
    extends State<WalletPhoneNumberView> {
  final TextEditingController _phoneController =
      TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.black,
            size: AppDimens.iconSize24,
          ),
        ),
        title: Text(
          'Wallet Phone Number',
          style: TextStyles.bold18(color: MyColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppPadding.h20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimens.h20),

            // Instruction Text
            Text(
              'Please enter the phone number registered with your mobile wallet',
              style: TextStyles.medium16(
                color: MyColors.grey700,
              ).copyWith(height: 1.5),
            ),

            SizedBox(height: AppDimens.h30),

            // Phone Input Field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your Phone number',
                hintStyle: TextStyles.regular14(
                  color: MyColors.grey400,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: AppDimens.w16,
                    right: AppDimens.w12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Egypt Flag
                      Image.asset(
                        ImgAssets.egyptFlag,
                        width: AppDimens.iconSize24,
                        height: AppDimens.iconSize24,
                        errorBuilder:
                            (context, error, stackTrace) {
                              return Container(
                                width: AppDimens.iconSize24,
                                height:
                                    AppDimens.iconSize24,
                                decoration: BoxDecoration(
                                  color: MyColors.grey300,
                                  borderRadius:
                                      AppRadius.r4,
                                ),
                                child: Icon(
                                  Icons.flag,
                                  size:
                                      AppDimens.iconSize16,
                                  color: MyColors.grey600,
                                ),
                              );
                            },
                      ),
                      SizedBox(width: AppDimens.w8),
                      // Country Code
                      Text(
                        '+20',
                        style: TextStyles.bold16(
                          color: MyColors.black,
                        ),
                      ),
                      SizedBox(width: AppDimens.w12),
                      // Vertical Divider
                      Container(
                        width: AppDimens.w1,
                        height: AppDimens.h20,
                        color: MyColors.grey300,
                      ),
                      SizedBox(width: AppDimens.w12),
                    ],
                  ),
                ),
                contentPadding: AppPadding.h16v16,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.r10,
                  borderSide: BorderSide(
                    color: MyColors.grey300,
                    width: AppDimens.borderWidth1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.r10,
                  borderSide: BorderSide(
                    color: MyColors.grey300,
                    width: AppDimens.borderWidth1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.r10,
                  borderSide: BorderSide(
                    color: MyColors.greenButton,
                    width: AppDimens.borderWidth2,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Disclaimer Text
            Text(
              'Payment with mobile digital wallets is only available for Egypt',
              style: TextStyles.regular12(
                color: MyColors.grey600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppDimens.h20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: ElevatedButton(
                onPressed: () {
                  // 1. Basic Validation
                  if (_phoneController.text.isEmpty) {
                    // Optionally show error message
                    return;
                  }

                  // 2. Capture root navigator context BEFORE popping
                  final rootNavigator = Navigator.of(
                    context,
                    rootNavigator: true,
                  );
                  final rootContext = rootNavigator.context;

                  // 3. Close the Wallet Screen
                  Navigator.pop(context);

                  // 4. Show Success Sheet after a short delay
                  Future.delayed(
                    const Duration(milliseconds: 300),
                    () {
                      if (rootContext.mounted) {
                        showModalBottomSheet(
                          context: rootContext,
                          isScrollControlled: false,
                          backgroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.top30,
                          ),
                          builder: (context) =>
                              const PaymentSuccessSheet(),
                        );
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r10,
                  ),
                  elevation: AppDimens.elevation0,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyles.bold16(
                    color: MyColors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h20),
          ],
        ),
      ),
    );
  }
}
