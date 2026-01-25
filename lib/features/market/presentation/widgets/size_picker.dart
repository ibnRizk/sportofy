import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class SizePicker extends StatelessWidget {
  final List<int> sizes;
  final int? selectedSize;
  final Function(int) onSizeSelected;

  const SizePicker({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: AppDimens.w8),
        itemBuilder: (context, index) {
          final size = sizes[index];
          final isSelected = selectedSize == size;
          return GestureDetector(
            onTap: () => onSizeSelected(size),
            child: Container(
              width: 39.h,

              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  size.toString(),
                  style: TextStyles.semiBold16(
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
    );
  }
}
