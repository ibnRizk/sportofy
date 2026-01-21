import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose the Size',
          style: TextStyles.bold16(
            color: context.colors.textColor,
          ),
        ),
        SizedBox(height: AppDimens.h12),
        SizedBox(
          height: AppDimens.buttonHeight50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            separatorBuilder: (context, index) => SizedBox(width: AppDimens.w12),
            itemBuilder: (context, index) {
              final size = sizes[index];
              final isSelected = selectedSize == size;
              return GestureDetector(
                onTap: () => onSizeSelected(size),
                child: Container(
                  width: AppDimens.containerHeight50,
                  height: AppDimens.containerHeight50,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColors.greenButton
                        : context.colors.white,
                    borderRadius: AppRadius.r8,
                    border: Border.all(
                      color: isSelected
                          ? MyColors.greenButton
                          : MyColors.grey300,
                      width: AppDimens.borderWidth1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size.toString(),
                      style: TextStyles.semiBold16(
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
      ],
    );
  }
}
