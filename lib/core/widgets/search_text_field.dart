import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

import '../../injection_container.dart';
import '../utils/app_dimens.dart';
import '../utils/app_padding.dart';
import '../utils/app_radius.dart';
import '../utils/values/text_styles.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onTap;
  final void Function(String)? onSubmit;
  final String? labelText;
  final String? hintText;
  final bool autoComplete;

  const MySearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onSubmit,
    this.labelText,
    this.hintText,
    this.autoComplete = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: AppPadding.h16v12,
      alignment: Alignment.centerRight,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: onTap,
        onChanged: autoComplete == true ? onTap : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.grey.withValues(alpha: AppDimens.opacity1),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimens.w16,
            vertical: AppDimens.h14,
          ),
          hintStyle: TextStyles.regular14(color: context.colors.body),
          prefixIcon: const Icon(
            Icons.search,
            color: MyColors.main,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.r12,
            borderSide: BorderSide(
              color: context.colors.dividerColor,
              width: AppDimens.borderWidth1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.r12,
            borderSide: BorderSide(
              color: context.colors.dividerColor,
              width: AppDimens.borderWidth1,
            ),
          ),
        ),
        style: TextStyles.regular14(color: context.colors.body),
      ),
    );
  }
}
