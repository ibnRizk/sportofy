// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../injection_container.dart';
// import '../utils/values/strings.dart';
// import '../utils/values/text_styles.dart';
// import 'app_outlined_button.dart';

// class CancelAccountDialog extends StatelessWidget {
//   const CancelAccountDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             Strings.cancelAccount,
//             style: TextStyles.semiBold20(),
//           ),
//           SizedBox(height: 24.h),
//           Text(
//             Strings.cancelAccountWarning,
//             style: TextStyles.regular16(color: context.colors.body),
//           ),
//           SizedBox(height: 32.h),
//           Row(
//             children: [
//               Expanded(
//                 child: AppOutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   text: Strings.cancelAccount,
//                   textStyle: TextStyles.regular14(color: context.colors.errorColor),
//                   borderColor: context.colors.errorColor,
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: AppOutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                   },
//                   text: Strings.no,
//                   textStyle: TextStyles.regular14(color: context.colors.main),
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ConfirmDeleteAccountDialog extends StatelessWidget {
//   const ConfirmDeleteAccountDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             Strings.confirmCancelAccount,
//             style: TextStyles.semiBold20(),
//           ),
//           SizedBox(height: 24.h),
//           Text(
//             Strings.areYouSureCancelAccount,
//             style: TextStyles.medium16(),
//           ),
//           SizedBox(height: 32.h),
//           Row(
//             children: [
//               Expanded(
//                 child: AppOutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   text: Strings.yes,
//                   borderColor: context.colors.errorColor,
//                   textColor: context.colors.errorColor,
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: AppOutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                   },
//                   text: Strings.no,
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
