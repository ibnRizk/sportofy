import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injection_container.dart';

class MenuTextFormField extends StatelessWidget {
  final String? Function(String? val)? validate;
  final Function()? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;

  const MenuTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.validate,
    this.onTap,
    this.labelText,
    this.prefixIcon,
  });
  @override
  Widget build(BuildContext context) {
    Color labelColor = context.colors.body;
    TextTheme theme = Theme.of(context).textTheme;
    double myFontSize = 14.sp;
    double raduis = 10.r;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validate,
      readOnly: true,
      onTap: onTap,
      cursorColor: context.colors.main,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          color: context.colors.body,
        ),
        fillColor: context.colors.upBackGround,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: context.colors.dividerColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: context.colors.dividerColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: context.colors.errorColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
          borderSide: BorderSide(
            color: context.colors.errorColor,
            width: 1.0,
          ),
        ),
        floatingLabelBehavior: labelText != null
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        hintText: hintText,
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        labelStyle: theme.bodyMedium!.copyWith(
          color: labelColor,
          fontSize: myFontSize,
        ),
        errorStyle: theme.bodySmall!.copyWith(
          color: Colors.red,
          fontSize: myFontSize - 4,
        ),
        hintStyle: theme.bodyMedium!.copyWith(
          color: Colors.grey,
          fontSize: myFontSize,
        ),
      ),
      style: theme.bodyMedium!.copyWith(
        color: context.colors.main,
        fontSize: myFontSize,
      ),
    );
  }
}
