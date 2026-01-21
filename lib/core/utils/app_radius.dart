import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized border radius constants following the app's design system.
/// All radius values use ScreenUtil for responsive sizing.
abstract class AppRadius {
  // Small radius (2-4)
  static BorderRadius get r2 => BorderRadius.circular(2.r);
  static BorderRadius get r3 => BorderRadius.circular(3.r);
  static BorderRadius get r4 => BorderRadius.circular(4.r);

  // Medium radius (6-12)
  static BorderRadius get r6 => BorderRadius.circular(6.r);
  static BorderRadius get r8 => BorderRadius.circular(8.r);
  static BorderRadius get r10 =>
      BorderRadius.circular(10.r);
  static BorderRadius get r12 =>
      BorderRadius.circular(12.r);

  // Large radius (16-20)
  static BorderRadius get r16 =>
      BorderRadius.circular(16.r);
  static BorderRadius get r20 =>
      BorderRadius.circular(20.r);

  // Extra large radius (24-30)
  static BorderRadius get r24 =>
      BorderRadius.circular(24.r);
  static BorderRadius get r25 =>
      BorderRadius.circular(25.r);
  static BorderRadius get r30 =>
      BorderRadius.circular(30.r);

  // Vertical radius (for top/bottom only)
  static BorderRadius get top25 =>
      BorderRadius.vertical(top: Radius.circular(25.r));

  // Circle (for circular widgets)
  static BorderRadius get circle =>
      BorderRadius.circular(999.r);

  // Vertical radius (for top/bottom only)
  static BorderRadius get top12 =>
      BorderRadius.vertical(top: Radius.circular(12.r));
  static BorderRadius get top16 =>
      BorderRadius.vertical(top: Radius.circular(16.r));
  static BorderRadius get top20 =>
      BorderRadius.vertical(top: Radius.circular(20.r));
  static BorderRadius get top30 =>
      BorderRadius.vertical(top: Radius.circular(30.r));
  static BorderRadius get r50 =>
      BorderRadius.circular(50.r);

  static BorderRadius get bottom12 =>
      BorderRadius.vertical(bottom: Radius.circular(12.r));
  static BorderRadius get bottom16 =>
      BorderRadius.vertical(bottom: Radius.circular(16.r));
  static BorderRadius get bottom20 =>
      BorderRadius.vertical(bottom: Radius.circular(20.r));

  // Horizontal radius (for left/right only)
  static BorderRadius get left12 =>
      BorderRadius.horizontal(left: Radius.circular(12.r));
  static BorderRadius get right12 =>
      BorderRadius.horizontal(right: Radius.circular(12.r));

  // Common combinations
  static BorderRadius get topLeftBottomRight12 =>
      BorderRadius.only(
        topLeft: Radius.circular(12.r),
        bottomRight: Radius.circular(12.r),
      );
  static BorderRadius get topRightBottomLeft12 =>
      BorderRadius.only(
        topRight: Radius.circular(12.r),
        bottomLeft: Radius.circular(12.r),
      );
}
