import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/widgets/app_image.dart';
import 'package:sportify_app/injection_container.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingData> _getPages(BuildContext context) {
    return [
      OnboardingData(
        image: ImgAssets.onBoarding1,
        titleKey: 'onboarding3_title',
        descriptionKey: 'onboarding1_description',
      ),
      OnboardingData(
        image: ImgAssets.onBoarding2,
        titleKey: 'onboarding2_title',
        descriptionKey: 'onboarding2_description',
      ),
      OnboardingData(
        image: ImgAssets.onBoarding3,
        titleKey: 'onboarding4_title',
        descriptionKey: 'onboarding3_description',
      ),
      OnboardingData(
        image: ImgAssets.onBoarding4,
        titleKey: 'onboarding1_title',
        descriptionKey: 'onboarding4_description',
      ),
    ];
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToLogin() {
    context.go(Routes.loginRoute);
  }

  void _skip() {
    context.go(Routes.homeScreenRoute);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getPages(context);
    final isArabic = appLocalizations.isArLocale;

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Language Selector (Top Right)
            Padding(
              padding: AppPadding.h20v16,
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isArabic ? 'عربي' : 'English',
                      style: TextStyles.medium14(
                        color: MyColors.greenButton,
                      ),
                    ),
                    SizedBox(width: AppDimens.w4),
                    Icon(
                      Icons.language,
                      color: MyColors.greenButton,
                      size: AppDimens.iconSize20,
                    ),
                  ],
                ),
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPageContent(
                    context,
                    pages[index],
                  );
                },
              ),
            ),

            // Page Indicators
            _buildPageIndicators(pages.length),

            SizedBox(height: AppDimens.h24),

            // Login Button
            Padding(
              padding: AppPadding.h20,
              child: SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight56,
                child: ElevatedButton(
                  onPressed: _navigateToLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r12,
                    ),
                    elevation: AppDimens.elevation0,
                  ),
                  child: Text(
                    'login'.tr(context),
                    style: TextStyles.semiBold16(
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h16),

            // Skip Button
            TextButton(
              onPressed: _skip,
              child: Text(
                'skip'.tr(context),
                style: TextStyles.medium16(
                  color: MyColors.greenButton,
                ),
              ),
            ),

            SizedBox(height: AppDimens.h24),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    OnboardingData data,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Illustration Image
        AppImage.asset(
          imageAsset: data.image,
          width: AppDimens.w320,
          height: AppDimens.h280,
          fit: BoxFit.contain,
        ),

        SizedBox(height: AppDimens.h40),

        // Title
        Padding(
          padding: AppPadding.h40,
          child: Text(
            data.titleKey.tr(context),
            textAlign: TextAlign.center,
            style: TextStyles.bold24(
              color: context.colors.textColor,
            ).copyWith(height: 1.3),
          ),
        ),

        SizedBox(height: AppDimens.h16),

        // Description
        Padding(
          padding: AppPadding.h40,
          child: Text(
            data.descriptionKey.tr(context),
            textAlign: TextAlign.center,
            style: TextStyles.regular14(
              color: MyColors.greyText,
            ).copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicators(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => _buildIndicator(index == _currentPage),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: AppPadding.h4,
      width: isActive ? AppDimens.w32 : AppDimens.w8,
      height: AppDimens.h8,
      decoration: BoxDecoration(
        color: isActive
            ? MyColors.greenButton
            : MyColors.greyText.withValues(
                alpha: AppDimens.opacity3,
              ),
        borderRadius: AppRadius.r4,
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String titleKey;
  final String descriptionKey;

  const OnboardingData({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}
