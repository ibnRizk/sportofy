import 'package:country_picker/country_picker.dart'
    as picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/log_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/utils/app_strings.dart';
import '../../config/locale/app_localizations.dart';
import '../../injection_container.dart';
import 'extension.dart';

final Color baseColorShimmer = Colors.grey.shade300;
final Color highlightColorShimmer = Colors.grey.shade100;

abstract class Constants {
  static const String appVersionType = 'test'; // live, test
  static String getSystemLang() {
    // Locale locale = PlatformDispatcher.instance.locale;
    // return locale.languageCode;
    return 'en';
  }

  // static Future<void> makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   try {
  //     await launchUrl(launchUri);
  //   } catch (e) {
  //     throw 'Could not launch $launchUri';
  //   }
  // }
  static Future<void> openUrl(String url) async {
    Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Couldn\'t launch $url';
      }
    } catch (e) {
      Log.e(e.toString());
      throw 'Couldn\'t launch $url';
    }
  }

  static picker.Country egyptCountryPicker = picker.Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: -1,
    name: 'Egypt',
    example: '1020304050',
    displayName: 'Egypt (EG) [+20]',
    displayNameNoCountryCode: 'Egypt (EG)',
    e164Key: '20-EG-0',
  );

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  static Color iconColor(
    FocusNode focusNode,
    BuildContext context,
  ) {
    return focusNode.hasFocus
        ? context.colors.main
        : context.colors.iconColor;
  }

  static ColorFilter colorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }

  // static Future<String?> phoneParsing(
  //     {String? phone, String? countryCode}) async {
  //   PhoneNumber phoneParsed;
  //   try {
  //     phoneParsed =
  //         await PhoneNumberUtil().parse(phone!, regionCode: countryCode);

  //     return phoneParsed.nationalNumber;
  //   } on PlatformException {
  //     rethrow;
  //   }
  // }

  static bool checkPDFFiles(String file) {
    var newString = file.substring(file.length - 5);

    debugPrint('file $file');
    debugPrint('checkFile pdf or image  $newString');
    return newString.contains('pdf') ? true : false;
  }

  static bool checkAuth(String msg) {
    return msg == AppStrings.unAuthorizedFailure ||
        msg == AppStrings.tokenFailure;
  }

  static void showErrorDialog({
    required BuildContext context,
    required String msg,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: Text(
              msg,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }

  // static void showToast(
  //     {required String msg, Color? color, ToastGravity? gravity}) {
  //   Fluttertoast.showToast(
  //       toastLength: Toast.LENGTH_LONG,
  //       msg: msg,
  //       backgroundColor: color ?? context.colors.main,
  //       gravity: gravity ?? ToastGravity.BOTTOM);
  // }

  /// Type: 1 done , 2: warning, 3: error
  static void showSnakToast({
    required BuildContext context,
    message,
    type,
  }) {
    Color background = context.colors.main;
    Color iconColor = context.colors.upBackGround;
    Color textColor = context.colors.upBackGround;
    var width = MediaQuery.of(context).size.width;

    String icon = '';

    switch (type) {
      // Add to WishList
      case 1:
        background = Colors.green;
        icon = 'assets/images/done.png';
        textColor = context.colors.upBackGround;
        iconColor = context.colors.upBackGround;
        break;

      // warning
      case 2:
        background = Colors.orangeAccent;
        icon = 'assets/images/warning.png';
        textColor = context.colors.upBackGround;
        iconColor = context.colors.upBackGround;
        break;
      // error
      case 3:
        background = Colors.red;
        icon = 'assets/images/warning.png';
        textColor = context.colors.upBackGround;
        iconColor = context.colors.upBackGround;
        break;

      // General
      case 4:
        background = context.colors.upBackGround;
        icon = 'assets/address.svg';
        textColor = Colors.black;
        iconColor = context.colors.upBackGround;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        elevation: 3,
        content: type != 5
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Image.asset(
                      icon,
                      width: 25,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Text(
                      message,
                      style: TextStyle(color: textColor),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  SizedBox(
                    height: 35,
                    width: width * 0.8,
                    child: Center(
                      child: Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: textColor),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  //openGallery
  static void imagesSourcesShowModel({
    required BuildContext context,
    Function? onCameraPressed,
    Function? onGalleryPressed,
    Function? onPDFPressed,
    bool? containPDF = false,
    bool? allowMultible = false,
  }) async {
    buildCustomShowModel(
      context: context,
      height: containPDF == true ? 210.0 : 140.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.text('takePhoto'),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium,
                ),
              ),
              onPressed: () {
                onCameraPressed!();
                //
              },
            ),
          ),
          // Gallery //
          Expanded(
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.text(
                    allowMultible == true
                        ? 'selectImages'
                        : 'selectImage',
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium,
                ),
              ),
              onPressed: () {
                onGalleryPressed!();
              },
            ),
          ),
          containPDF == true
              ? Expanded(
                  child: TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!.text('selectPDF'),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium,
                      ),
                    ),
                    onPressed: () {
                      onPDFPressed!();
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  static void buildCustomShowModel({
    required BuildContext context,
    required Widget child,
    double? height,
    EdgeInsets? padding,
  }) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: context.colors.upBackGround,
          ),
          height: height,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 16.0),
          child: child,
        );
      },
    );
  }

  static showLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.upBackGround,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(50.0),
            child: CircularProgressIndicator(
              color: context.colors.main,
            ).appLoading,
          ),
        );
      },
    );
  }

  static hideLoading(context) {
    Navigator.of(context).pop();
  }

  // static void navigateTo(double lat, double lng) async {
  //   var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch ${uri.toString()}';
  //   }
  // }
}

abstract class ArabicNumeric {
  static String zero = '٠';
  static String one = '١';
  static String two = '٢';
  static String three = '٣';
  static String four = '٤';
  static String five = '٥';
  static String six = '٦';
  static String seven = '٧';
  static String eight = '٨';
  static String nine = '٩';
}
