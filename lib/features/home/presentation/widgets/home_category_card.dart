import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/injection_container.dart';

class HomeCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const HomeCategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimens.cardHeight140,
        decoration: BoxDecoration(
          borderRadius: AppRadius.r16,
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.r16,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MyColors.transparent,
                MyColors.black.withValues(alpha: AppDimens.opacity7),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: AppPadding.p12,
              child: Text(
                title,
                style: TextStyles.bold14(
                  color: context.colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
