// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../injection_container.dart';
// import '../utils/values/strings.dart';
// import '../utils/values/text_styles.dart';
// import 'app_elevated_button.dart';

// class AppUpdateDialog extends StatelessWidget {
//   final String newVersion;

//   const AppUpdateDialog({
//     required this.newVersion,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Text(
//                 Strings.updateApp,
//                 style: TextStyles.semiBold20(),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Text(
//                   'v$newVersion',
//                   style: TextStyles.semiBold18(color: context.colors.main),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 24.h),
//           Text(
//             Strings.updateAppBody,
//             style: TextStyles.regular14(),
//           ),
//           SizedBox(height: 32.h),
//           AppElevatedButton(
//             onPressed: () async {
//               // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//               // StoreRedirect.redirect(
//               //   androidAppId: packageInfo.packageName,
//               //   iOSAppId: packageInfo.packageName,
//               // );
//             },
//             text: Strings.update,
//           ),
//         ],
//       ),
//     );
//   }
// }
