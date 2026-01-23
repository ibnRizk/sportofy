import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../injection_container.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_padding.dart';
import '../utils/app_radius.dart';
import '../utils/values/text_styles.dart';
import '../utils/validator.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValidatorType? validatorType;
  final Function()? onTap;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final Function(String? val)? onSaved;
  final Function(String? val)? onChanged;
  final Function(String val)? onSubmit;
  // final Function(CountryCode)? onChangeCode;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefixWidget;
  final IconData? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isPhone;
  final bool? isEdit;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool arLang;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final double? radius;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validatorType,
    this.validator,
    required this.hintText,
    this.onSaved,
    this.onChanged,
    this.onSubmit,
    this.textAlign = TextAlign.start,

    // this.onChangeCode,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.isPhone = false,
    this.isEdit = false,
    this.maxLines,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.arLang = false,
    this.textInputAction,
    this.backgroundColor,
    this.inputFormatters,
    this.borderColor,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    Color color = labelText != null
        ? context.colors.highlight
        : focusNode!.hasFocus
            ? context.colors.highlight
            : context.colors.body;
    Color labelColor =
        focusNode!.hasFocus ? context.colors.main : context.colors.body;
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      textDirection: arLang ? TextDirection.rtl : null,
      minLines: minLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.done,
      validator: validatorType != null
          ? (String? value) => Validator.call(
              value: value, type: validatorType!, context: context)
          : validator,
      readOnly: readOnly,
      textAlign: textAlign,
      obscureText: obscureText,
      cursorColor: context.colors.main,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        
        suffix: suffix,
        prefix: isPhone == true
            ? prefixWidget
            : prefix != null
                ? Padding(
                    padding: AppPadding.h4,
                    child: Icon(
                      prefix,
                      size: AppDimens.iconSize16,
                      color: MyColors.darkGrayColor,
                    ),
                  )
                : null,
        fillColor: backgroundColor ?? context.colors.upBackGround,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : AppRadius.r10,
          borderSide: BorderSide(
            color: borderColor ?? context.colors.borderColor,
            width: AppDimens.borderWidth1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : AppRadius.r10,
          borderSide: BorderSide(
            color: borderColor ?? context.colors.main,
            width: AppDimens.borderWidth1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius != null
              ? BorderRadius.circular(radius!)
              : AppRadius.r10,
          borderSide: BorderSide(
            color: context.colors.errorColor,
            width: AppDimens.borderWidth1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius != null
              ? BorderRadius.all(Radius.circular(radius!))
              : AppRadius.r10,
          borderSide: BorderSide(
            color: context.colors.errorColor,
            width: AppDimens.borderWidth1,
          ),
        ),
        floatingLabelBehavior: labelText != null
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        hintText: hintText,
        labelText: labelText,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimens.w16,
          vertical: AppDimens.h18,
        ),
        labelStyle: TextStyles.regular14(color: labelColor),
        errorStyle: TextStyles.regular10(color: MyColors.red),
        hintStyle: TextStyles.regular14(color: MyColors.darkGrayColor),
      ),
      style: TextStyles.regular14(color: color),
      focusNode: focusNode,
      onSaved: onSaved,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
