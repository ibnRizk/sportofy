import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injection_container.dart';
import '../utils/extension.dart';

class LoadingView extends StatelessWidget {
  final Color? bgColor;
  final Color? loadingColor;
  final double? height;
  final double? width;

  const LoadingView({
    super.key,
    this.height,
    this.width,
    this.bgColor,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: width ?? screenWidth,
      height: height,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colors.dividerColor),
        color: bgColor ?? context.colors.main,
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: loadingColor ?? context.colors.upBackGround,
        ).appLoading,
      ),
    );
  }
}
