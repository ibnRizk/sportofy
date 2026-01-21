import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized padding constants following the app's design system.
/// All padding values use ScreenUtil for responsive sizing.
abstract class AppPadding {
  // Generic padding values (all sides)
  static EdgeInsets get p4 => EdgeInsets.all(4.w);
  static EdgeInsets get p6 => EdgeInsets.all(6.w);
  static EdgeInsets get p8 => EdgeInsets.all(8.w);
  static EdgeInsets get p10 => EdgeInsets.all(10.w);
  static EdgeInsets get p12 => EdgeInsets.all(12.w);
  static EdgeInsets get p15 => EdgeInsets.all(15.w);
  static EdgeInsets get p16 => EdgeInsets.all(16.w);
  static EdgeInsets get p2 => EdgeInsets.all(2.w);
  static EdgeInsets get p20 => EdgeInsets.all(20.w);
  static EdgeInsets get p24 => EdgeInsets.all(24.w);
  static EdgeInsets get p30 => EdgeInsets.all(30.w);
  static EdgeInsets get p32 => EdgeInsets.all(32.w);
  static EdgeInsets get p40 => EdgeInsets.all(40.w);

  // Horizontal padding
  static EdgeInsets get h4 =>
      EdgeInsets.symmetric(horizontal: 4.w);
  static EdgeInsets get h8 =>
      EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets get h12 =>
      EdgeInsets.symmetric(horizontal: 12.w);
  static EdgeInsets get h16 =>
      EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get h20 =>
      EdgeInsets.symmetric(horizontal: 20.w);
  static EdgeInsets get h24 =>
      EdgeInsets.symmetric(horizontal: 24.w);
  static EdgeInsets get h30 =>
      EdgeInsets.symmetric(horizontal: 30.w);
  static EdgeInsets get h32 =>
      EdgeInsets.symmetric(horizontal: 32.w);
  static EdgeInsets get h40 =>
      EdgeInsets.symmetric(horizontal: 40.w);

  // Vertical padding
  static EdgeInsets get v4 =>
      EdgeInsets.symmetric(vertical: 4.h);
  static EdgeInsets get v8 =>
      EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets get v10 =>
      EdgeInsets.symmetric(vertical: 10.h);
  static EdgeInsets get v12 =>
      EdgeInsets.symmetric(vertical: 12.h);
  static EdgeInsets get v14 =>
      EdgeInsets.symmetric(vertical: 14.h);
  static EdgeInsets get v15 =>
      EdgeInsets.symmetric(vertical: 15.h);
  static EdgeInsets get v16 =>
      EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets get v20 =>
      EdgeInsets.symmetric(vertical: 20.h);
  static EdgeInsets get v24 =>
      EdgeInsets.symmetric(vertical: 24.h);
  static EdgeInsets get v30 =>
      EdgeInsets.symmetric(vertical: 30.h);
  static EdgeInsets get v32 =>
      EdgeInsets.symmetric(vertical: 32.h);
  static EdgeInsets get v40 =>
      EdgeInsets.symmetric(vertical: 40.h);

  // Combined horizontal and vertical
  static EdgeInsets get h8v4 =>
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h);
  static EdgeInsets get h12v6 =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h);
  static EdgeInsets get h12v8 =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
  static EdgeInsets get h12v12 => EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 12.h,
  );
  static EdgeInsets get h16v8 =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
  static EdgeInsets get h12v16 => EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 16.h,
  );
  static EdgeInsets get h16v10 => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 10.h,
  );
  static EdgeInsets get h16v12 => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );
  static EdgeInsets get h16v14 => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 14.h,
  );
  static EdgeInsets get h16v16 => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h,
  );

  static EdgeInsets get h20v16 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 16.h,
  );
  static EdgeInsets get h20v4 =>
      EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h);
  static EdgeInsets get h20v20 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 20.h,
  );
  static EdgeInsets get h24v10 => EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 10.h,
  );
  static EdgeInsets get h24v12 => EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 12.h,
  );
  static EdgeInsets get h24v20 => EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 20.h,
  );
  static EdgeInsets get h16v18 => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 18.h,
  );
  static EdgeInsets get h20v8 =>
      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h);
  static EdgeInsets get h20v12 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 12.h,
  );
  static EdgeInsets get h20v15 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 15.h,
  );

  static EdgeInsets get h20v10 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 10.h,
  );
  static EdgeInsets get h20v30 => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 30.h,
  );
  static EdgeInsets get h24v32 => EdgeInsets.symmetric(
    horizontal: 24.w,
    vertical: 32.h,
  );
  static EdgeInsets get h30v30 => EdgeInsets.symmetric(
    horizontal: 30.w,
    vertical: 30.h,
  );
  static EdgeInsets get h30v40 => EdgeInsets.symmetric(
    horizontal: 30.w,
    vertical: 40.h,
  );

  // Directional padding (only)
  static EdgeInsets get top4 => EdgeInsets.only(top: 4.h);
  static EdgeInsets get top8 => EdgeInsets.only(top: 8.h);
  static EdgeInsets get top10 => EdgeInsets.only(top: 10.h);
  static EdgeInsets get top12 => EdgeInsets.only(top: 12.h);
  static EdgeInsets get top16 => EdgeInsets.only(top: 16.h);
  static EdgeInsets get top20 => EdgeInsets.only(top: 20.h);
  static EdgeInsets get top24 => EdgeInsets.only(top: 24.h);

  // Combined directional padding
  static EdgeInsets get left52top8 =>
      EdgeInsets.only(left: 52.w, top: 8.h);
  static EdgeInsets get left32top12 =>
      EdgeInsets.only(left: 32.w, top: 12.h);

  static EdgeInsets get bottom4 =>
      EdgeInsets.only(bottom: 4.h);
  static EdgeInsets get bottom8 =>
      EdgeInsets.only(bottom: 8.h);
  static EdgeInsets get bottom12 =>
      EdgeInsets.only(bottom: 12.h);
  static EdgeInsets get bottom16 =>
      EdgeInsets.only(bottom: 16.h);
  static EdgeInsets get bottom20 =>
      EdgeInsets.only(bottom: 20.h);
  static EdgeInsets get bottom24 =>
      EdgeInsets.only(bottom: 24.h);

  static EdgeInsets get left4 => EdgeInsets.only(left: 4.w);
  static EdgeInsets get left8 => EdgeInsets.only(left: 8.w);
  static EdgeInsets get left12 =>
      EdgeInsets.only(left: 12.w);
  static EdgeInsets get left16 =>
      EdgeInsets.only(left: 16.w);
  static EdgeInsets get left20 =>
      EdgeInsets.only(left: 20.w);
  static EdgeInsets get left32 =>
      EdgeInsets.only(left: 32.w);
  static EdgeInsets get left52 =>
      EdgeInsets.only(left: 52.w);

  static EdgeInsets get right4 =>
      EdgeInsets.only(right: 4.w);
  static EdgeInsets get right8 =>
      EdgeInsets.only(right: 8.w);
  static EdgeInsets get right12 =>
      EdgeInsets.only(right: 12.w);
  static EdgeInsets get right16 =>
      EdgeInsets.only(right: 16.w);
  static EdgeInsets get right20 =>
      EdgeInsets.only(right: 20.w);

  // Common content padding for TextFields
  static EdgeInsets get contentPadding12 =>
      EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      );
  static EdgeInsets get contentPadding16 =>
      EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      );
  static EdgeInsets get contentPadding20 =>
      EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      );

  // Zero padding
  static EdgeInsets get zero => EdgeInsets.zero;
}
