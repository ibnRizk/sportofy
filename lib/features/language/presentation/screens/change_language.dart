import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';

import '../../../../core/utils/values/text_styles.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../injection_container.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  ChangeLanguageState createState() =>
      ChangeLanguageState();
}

class ChangeLanguageState extends State<ChangeLanguage> {
  bool? check;

  @override
  Widget build(BuildContext context) {
    if (check == null) {
      final arg =
          ModalRoute.of(context)!.settings.arguments as Map;
      check = arg['isRTL'];
    }
    AlignmentGeometry alignmentGeometry =
        appLocalizations.isArLocale
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr(context)),
        iconTheme: IconThemeData(
          color: context.colors.main,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  check = false;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: alignmentGeometry,
                      height: 50.h,
                      child: Text(
                        'english'.tr(context),
                        style: TextStyles.medium20(),
                      ),
                    ),
                  ),
                  Radio(
                    value: false,
                    groupValue: check,
                    onChanged: (val) {
                      setState(() {
                        check = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  check = true;
                });
              },
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: alignmentGeometry,
                      height: 50.h,
                      child: Text(
                        'arabic'.tr(context),
                        style: TextStyles.medium20(),
                      ),
                    ),
                  ),
                  Radio(
                    value: true,
                    groupValue: check,
                    onChanged: (val) {
                      setState(() {
                        check = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height:
                  MediaQuery.sizeOf(context).height *
                  0.02111,
            ),
            AppElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(check);
              },
              text: 'change'.tr(context),
            ),
          ],
        ),
      ),
    );
  }
}
