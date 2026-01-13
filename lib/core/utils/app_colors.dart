import 'package:flutter/material.dart';

class MyColors {
  static const Color white = Colors.white;
  static const Color backGround = Color(0xFFF6F7F6);
  static const Color upBackGround = Color(0xFFFFFFFF);
  static const Color main = Color(0xff00A9B8);
  static const Color secondaryColor = Color(0xFFBBDEFB);
  static const Color textColor = Color(0xFF1A237E);
  static const Color body = Color(0xFF5C6BC0);
  static const Color highlight = Color(0xFF1976D2);
  static const Color buttonColor = Color(0xFF0D47A1);
  static const Color onBoardingColor = Color(0xFF1E88E5);
  static const Color iconColor = Color(0xff313739);
  static const Color title = Color(0xFF3D5F48);
  static const Color unselected = Color(0xFFE6E3E3);
  static const Color dividerColor = Color(0xff979797);
  static const Color profileDividerColor = Color(0xffDADADA);
  static const Color grayLight = Color(0xffF2F2F2);
  static const Color successColor = Color(0xFF0FEF3D);
  static const Color errorColor = Color(0xFFEF0F0F);
  static const Color buttonColor2 = Color(0xFFEEEEEE);
  static const Color backGroundContainerColor = Color(0xffD5F6FB);

  // dark mode
  static const Color black = Colors.black;
  static const Color mainDark = Color(0xFF1976D2);
  static const Color titleDark = Color(0xFFE9F2FD);
  static const Color highlightDark = Color(0xFF42A5F5);
  static const Color bodyDark = Color(0xFF90CAF9);
  static const Color errorDarkColor = Color(0xFFEF5350);
  static const Color backGroundDark = Color(0xFF2D2D3E);
  static const Color upBackGroundDark = Color(0xFF3A3A4B);
  static const Color unselectedDark = Color(0xff262626);
  static const Color dividerDarkColor = Color(0xFF455A64);
  static const Color successDarkColor = Color(0xFF4CAF50);

  // shared
  static Color borderColor = const Color(0xffCBCBCB);
  static Color review = const Color(0xffFFA534);
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color baseColor;
  final Color backGround;
  final Color upBackGround;
  final Color main;
  final Color secondaryColor;
  final Color textColor;
  final Color highlight;
  final Color body;
  final Color iconColor;
  final Color unselectedColor;  
  final Color dividerColor;
  final Color unselected;
  final Color successColor;
  final Color errorColor;
  final Color borderColor;
  final Color review;
  final Color buttonColor;
  final Color buttonColor2;
  final Color white;
  final Color black;
  final Color profileDividerColor;
  final Color onBoardingColor;

  const AppColors({
    required this.baseColor,
    required this.backGround,
    required this.upBackGround,
    required this.main,
    required this.secondaryColor,
    required this.textColor,
    required this.highlight,
    required this.body,
    required this.iconColor,
    required this.dividerColor,
    required this.unselected,
    required this.successColor,
    required this.unselectedColor,
    required this.errorColor,
    required this.borderColor,
    required this.review,
    required this.buttonColor,
    required this.buttonColor2,
    required this.profileDividerColor,
    required this.onBoardingColor,
    required this.white,
    required this.black,
  });

  @override
  AppColors copyWith({
    Color? baseColor,
    Color? backGround,
    Color? upBackGround,
    Color? main,
    Color? secondaryColor,
    Color? textColor,
    Color? highlight,
    Color? body,
    Color? iconColor,
    Color? dividerColor,
    Color? unselected,
    Color? successColor,
    Color? unselectedColor,
    Color? errorColor,
    Color? borderColor,
    Color? review,
    Color? buttonColor,
    Color? buttonColor2,
    Color? profileDividerColor,
    Color? onBoardingColor,
    Color? white,
    Color? black,
  }) {
    return AppColors(
      baseColor: baseColor ?? this.baseColor,
      backGround: backGround ?? this.backGround,
      upBackGround: upBackGround ?? this.upBackGround,
      main: main ?? this.main,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      textColor: textColor ?? this.textColor,
      highlight: highlight ?? this.highlight,
      body: body ?? this.body,
      iconColor: iconColor ?? this.iconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      unselected: unselected ?? this.unselected,
      successColor: successColor ?? this.successColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      errorColor: errorColor ?? this.errorColor,
      borderColor: borderColor ?? this.borderColor,
      review: review ?? this.review,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonColor2: buttonColor2 ?? this.buttonColor2,
      profileDividerColor: profileDividerColor ?? this.profileDividerColor,
      onBoardingColor: onBoardingColor ?? this.onBoardingColor,
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      backGround: Color.lerp(backGround, other.backGround, t)!,
      upBackGround: Color.lerp(upBackGround, other.upBackGround, t)!,
      main: Color.lerp(main, other.main, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,

      body: Color.lerp(body, other.body, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      unselected: Color.lerp(unselected, other.unselected, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      review: Color.lerp(review, other.review, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      buttonColor2: Color.lerp(buttonColor2, other.buttonColor2, t)!,
      profileDividerColor: Color.lerp(
        profileDividerColor,
        other.profileDividerColor,
        t,
      )!,
      onBoardingColor: Color.lerp(onBoardingColor, other.onBoardingColor, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
    );
  }
}
