import 'package:flutter/material.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/widgets/app_elevated_button.dart';
import 'package:sportify_app/injection_container.dart';

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
        padding: AppPadding.p16,
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
                      height: AppDimens.buttonHeight50,
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
                      height: AppDimens.buttonHeight50,
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
              height: AppDimens.h20,
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
