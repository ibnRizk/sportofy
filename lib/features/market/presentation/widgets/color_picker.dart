import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

class ColorPicker extends StatelessWidget {
  final List<String> colors;
  final String selectedColor;
  final Function(String) onColorSelected;

  const ColorPicker({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: colors.map((color) {
        final isSelected = selectedColor == color;
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                Container(
                  width: 39.w,
                  height: 39.w,
                  decoration: BoxDecoration(
                    color: _getColorFromString(color),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color.fromARGB(
                              255,
                              93,
                              213,
                              97,
                            )
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  color,
                  style: TextStyles.medium12(
                    color: context.colors.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green':
        return MyColors.green;
      case 'white':
        return MyColors.white;
      case 'black':
        return MyColors.black;
      case 'red':
        return MyColors.red;
      case 'blue':
        return MyColors.blue;
      default:
        return MyColors.grey;
    }
  }
}
