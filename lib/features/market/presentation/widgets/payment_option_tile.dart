import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class PaymentOptionTile extends StatelessWidget {
  final String value;
  final String iconPath;
  final String title;
  final String?
  balanceText; // For Sportify Wallet: "100 EGP"
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionTile({
    super.key,
    required this.value,
    required this.iconPath,
    required this.title,
    this.balanceText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 22.h),
        child: Row(
          children: [
            // Payment Icon
            Image.asset(
              iconPath,
              width: 20.w,
              height: 20.w,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: MyColors.grey200,
                    borderRadius: BorderRadius.circular(
                      4.r,
                    ),
                  ),
                  child: Icon(
                    Icons.payment,
                    size: 14.sp,
                    color: MyColors.grey600,
                  ),
                );
              },
            ),
            SizedBox(width: 12.w),

            // Payment Name Text
            Expanded(
              child: Text(
                title,
                style: TextStyles.medium14(
                  color: MyColors.darkGrayColor,
                ),
              ),
            ),

            // Balance Text (only for Sportify Wallet)
            if (balanceText != null) ...[
              Text(
                balanceText!,
                style: TextStyles.medium14(
                  color: MyColors.greenButton,
                ),
              ),
              SizedBox(width: 12.w),
            ],

            // Radio Button
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? MyColors.greenButton
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
