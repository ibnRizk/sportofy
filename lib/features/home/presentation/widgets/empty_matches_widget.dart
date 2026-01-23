import 'package:flutter/material.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

class EmptyMatchesWidget extends StatelessWidget {
  const EmptyMatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.w16),
      padding: AppPadding.p40,
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: AppRadius.r16,
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withValues(alpha: AppDimens.opacity05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'no_matches_near'.tr(context),
          textAlign: TextAlign.center,
          style: TextStyles.medium14(
            color: MyColors.darkGrayColor,
          ),
        ),
      ),
    );
  }
}
