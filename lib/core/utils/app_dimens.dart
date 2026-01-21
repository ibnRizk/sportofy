import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized dimension constants for spacing, sizes, and SizedBox values.
/// All dimensions use ScreenUtil for responsive sizing.
abstract class AppDimens {
  // Height spacing values (for SizedBox height)
  static double get h2 => 2.h;
  static double get h3 => 3.h;
  static double get h4 => 4.h;
  static double get h6 => 6.h;
  static double get h8 => 8.h;
  static double get h10 => 10.h;
  static double get h12 => 12.h;
  static double get h14 => 14.h;
  static double get h15 => 15.h;
  static double get h16 => 16.h;
  static double get h18 => 18.h;
  static double get h20 => 20.h;
  static double get h24 => 24.h;
  static double get h28 => 28.h;
  static double get h30 => 30.h;
  static double get h32 => 32.h;
  static double get h36 => 36.h;
  static double get h40 => 40.h;
  static double get h50 => 50.h;
  static double get h280 => 280.h;
  static double get h48 => 48.h;
  static double get h56 => 56.h;
  static double get h64 => 64.h;
  static double get h100 => 100.h;

  // Width spacing values (for SizedBox width)
  static double get w1 => 1.w;
  static double get w2 => 2.w;
  static double get w3 => 3.w;
  static double get w4 => 4.w;
  static double get w6 => 6.w;
  static double get w8 => 8.w;
  static double get w10 => 10.w;
  static double get w12 => 12.w;
  static double get w15 => 15.w;
  static double get w16 => 16.w;
  static double get w20 => 20.w;
  static double get w24 => 24.w;
  static double get w28 => 28.w;
  static double get w30 => 30.w;
  static double get w32 => 32.w;
  static double get w36 => 36.w;
  static double get w40 => 40.w;
  static double get w45 => 45.w;
  static double get w50 => 50.w;
  static double get w60 => 60.w;
  static double get w70 => 70.w;
  static double get w80 => 80.w;
  static double get h70 => 70.h;
  static double get w72 => 72.w;
  static double get w90 => 90.w;
  static double get w100 => 100.w;
  static double get w180 => 180.w;
  static double get w200 => 200.w;
  static double get w280 => 280.w;
  static double get w320 => 320.w;

  // SizedBox widgets (convenience getters)
  static SizedBox get spaceH4 => SizedBox(height: h4);
  static SizedBox get spaceH6 => SizedBox(height: h6);
  static SizedBox get spaceH8 => SizedBox(height: h8);
  static SizedBox get spaceH10 => SizedBox(height: h10);
  static SizedBox get spaceH12 => SizedBox(height: h12);
  static SizedBox get spaceH16 => SizedBox(height: h16);
  static SizedBox get spaceH20 => SizedBox(height: h20);
  static SizedBox get spaceH24 => SizedBox(height: h24);
  static SizedBox get spaceH32 => SizedBox(height: h32);
  static SizedBox get spaceH40 => SizedBox(height: h40);
  static SizedBox get spaceH48 => SizedBox(height: h48);
  static SizedBox get spaceH56 => SizedBox(height: h56);
  static SizedBox get spaceH64 => SizedBox(height: h64);
  static SizedBox get spaceH100 => SizedBox(height: h100);

  static SizedBox get spaceW4 => SizedBox(width: w4);
  static SizedBox get spaceW6 => SizedBox(width: w6);
  static SizedBox get spaceW8 => SizedBox(width: w8);
  static SizedBox get spaceW10 => SizedBox(width: w10);
  static SizedBox get spaceW12 => SizedBox(width: w12);
  static SizedBox get spaceW16 => SizedBox(width: w16);
  static SizedBox get spaceW20 => SizedBox(width: w20);
  static SizedBox get spaceW24 => SizedBox(width: w24);
  static SizedBox get spaceW32 => SizedBox(width: w32);
  static SizedBox get spaceW40 => SizedBox(width: w40);

  // Common widget sizes
  static double get iconSize10 => 10.sp;
  static double get iconSize12 => 12.sp;
  static double get iconSize14 => 14.sp;
  static double get iconSize16 => 16.sp;
  static double get iconSize18 => 18.sp;
  static double get iconSize20 => 20.sp;
  static double get iconSize22 => 22.sp;
  static double get iconSize24 => 24.sp;
  static double get iconSize32 => 32.sp;
  static double get iconSize40 => 40.sp;
  static double get iconSize48 => 48.sp;
  static double get iconSize50 => 50.sp;
  static double get iconSize60 => 60.sp;
  static double get iconSize80 => 80.sp;
  static double get iconSize100 => 100.sp;

  // Common container heights
  static double get containerHeight40 => 40.h;
  static double get containerHeight45 => 45.h;
  static double get containerHeight50 => 50.h;
  static double get containerHeight56 => 56.h;
  static double get containerHeight60 => 60.h;
  static double get containerHeight70 => 70.h;
  static double get containerHeight80 => 80.h;
  static double get containerHeight82 => 82.h;
  static double get containerHeight90 => 90.h;
  static double get containerHeight100 => 100.h;
  static double get containerHeight120 => 120.h;
  static double get containerHeight140 => 140.h;
  static double get containerHeight150 => 150.h;
  static double get containerHeight180 => 180.h;
  static double get containerHeight200 => 200.h;
  static double get containerHeight250 => 250.h;
  static double get containerHeight300 => 300.h;
  static double get containerHeight350 => 350.h;

  // Common container widths
  static double get containerWidth50 => 50.w;
  static double get containerWidth60 => 60.w;
  static double get containerWidth80 => 80.w;
  static double get containerWidth100 => 100.w;
  static double get containerWidth120 => 120.w;
  static double get containerWidth140 => 140.w;
  static double get containerWidth150 => 150.w;
  static double get containerWidth200 => 200.w;

  // Button heights
  static double get buttonHeight40 => 40.h;
  static double get buttonHeight44 => 44.h;
  static double get buttonHeight48 => 48.h;
  static double get buttonHeight50 => 50.h;
  static double get buttonHeight56 => 56.h;
  static double get buttonHeight60 => 60.h;

  // AppBar and header heights
  static double get appBarHeight => 56.h;
  static double get headerHeight => 80.h;
  static double get bottomNavBarHeight => 60.h;

  // Card dimensions
  static double get cardHeight140 => 140.h;
  static double get cardHeight150 => 150.h;
  static double get cardHeight200 => 200.h;

  // Avatar sizes
  static double get avatarSize13 => 13.r;
  static double get avatarSize15 => 15.r;
  static double get avatarSize16 => 16.r;
  static double get avatarSize18 => 18.r;
  static double get avatarSize20 => 20.r;
  static double get avatarSize22 => 22.r;
  static double get avatarSize24 => 24.r;
  static double get avatarSize25 => 25.r;
  static double get avatarSize28 => 28.r;
  static double get avatarSize30 => 30.r;
  static double get avatarSize32 => 32.r;
  static double get avatarSize35 => 35.r;
  static double get avatarSize40 => 40.r;
  static double get avatarSize48 => 48.r;
  static double get avatarSize50 => 50.r;
  static double get avatarSize56 => 56.r;
  static double get avatarSize64 => 64.r;
  static double get avatarSize80 => 80.r;
  static double get avatarSize100 => 100.r;

  // Badge sizes
  static double get badgeSize12 => 12.w;
  static double get badgeSize16 => 16.w;
  static double get badgeSize20 => 20.w;
  static double get badgeSize24 => 24.w;

  // Divider thickness
  static double get dividerThickness1 => 1.h;
  static double get dividerThickness2 => 2.h;

  // Border widths
  static double get borderWidth0_5 => 0.5.w;
  static double get borderWidth1 => 1.w;
  static double get borderWidth1_5 => 1.5.w;
  static double get borderWidth2 => 2.w;
  static double get borderWidth3 => 3.w;

  // Elevation/shadow
  static double get elevation0 => 0;
  static double get elevation1 => 1;
  static double get elevation2 => 2;
  static double get elevation3 => 3;
  static double get elevation4 => 4;
  static double get elevation5 => 5;
  static double get elevation8 => 8;
  static double get elevation10 => 10;

  // Opacity values (for withValues)
  static double get opacity03 => 0.03;
  static double get opacity05 => 0.05;
  static double get opacity1 => 0.1;
  static double get opacity12 => 0.12;
  static double get opacity2 => 0.2;
  static double get opacity3 => 0.3;
  static double get opacity4 => 0.4;
  static double get opacity5 => 0.5;
  static double get opacity6 => 0.6;
  static double get opacity7 => 0.7;
  static double get opacity8 => 0.8;
  static double get opacity9 => 0.9;
}

/// Helper widget for vertical spacing
class VerticalSpace extends StatelessWidget {
  final double height;
  const VerticalSpace(this.height, {super.key});

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: height);
}

/// Helper widget for horizontal spacing
class HorizontalSpace extends StatelessWidget {
  final double width;
  const HorizontalSpace(this.width, {super.key});

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: width);
}
