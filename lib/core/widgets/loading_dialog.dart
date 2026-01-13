import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/extension.dart';
import '../utils/values/text_styles.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  const LoadingDialog({
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 72.h),
      child: Builder(
        builder: (context) {
          if(message != null){
            return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              runAlignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: Center(child: const CircularProgressIndicator().appLoading),
                ),
                SizedBox(height: 16.h),
                Text(
                  message!,
                  style: TextStyles.medium14(),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          return SizedBox(
            width: 64.w,
            height: 64.h,
            child: Center(child: const CircularProgressIndicator().appLoading),
          );
        }
      ),
    );
  }
}