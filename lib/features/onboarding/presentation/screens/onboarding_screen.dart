import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isArabic ? 'عربي' : 'English',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greenButton,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.language,
                      color: MyColors.greenButton,
                      size: 20.w,
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

            SizedBox(height: 24.h),

            // Login Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _navigateToLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'login'.tr(context),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Skip Button
            TextButton(
              onPressed: _skip,
              child: Text(
                'skip'.tr(context),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: MyColors.greenButton,
                ),
              ),
            ),

            SizedBox(height: 24.h),
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
          width: 320.w,
          height: 280.h,
          fit: BoxFit.contain,
        ),

        SizedBox(height: 40.h),

        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            data.titleKey.tr(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.textColor,
              height: 1.3,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            data.descriptionKey.tr(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: MyColors.greyText,
              height: 1.5,
            ),
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
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 32.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive
            ? MyColors.greenButton
            : MyColors.greyText.withValues(alpha:0.3),
        borderRadius: BorderRadius.circular(4.r),
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
