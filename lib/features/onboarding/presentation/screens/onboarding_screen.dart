import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/widgets/frame_animated_widget.dart';
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
      // Screen 1: Reserving stadiums nearby
      OnboardingData(
        images: [
          'assets/images/onboarding1_1.png',
          'assets/images/onboarding1_2.png',
          'assets/images/onboarding1_3.png',
        ],
        title: 'Reserving stadiums nearby',
        body:
            'Book your favorite stadium, and enjoy playing with your friends',
      ),
      // Screen 2: Get to know amazing people
      OnboardingData(
        images: [
          'assets/images/onboarding2_1.png',
          'assets/images/onboarding2_2.png',
          'assets/images/onboarding2_3.png',
        ],
        title: 'Get to know amazing people',
        body:
            'Play and interact with others who share your talent',
      ),
      // Screen 3: Play and get points
      OnboardingData(
        images: [
          'assets/images/onboarding3_1.png',
          'assets/images/onboarding3_2.png',
          'assets/images/onboarding3_3.png',
          'assets/images/onboarding3_4.png',
        ],
        title: 'Play and get points',
        body:
            'Play and get points to get a discount on your purchases',
      ),
      // Screen 4: The best sports equipment
      OnboardingData(
        images: [
          'assets/images/onboarding4_1.png',
          'assets/images/onboarding4_2.png',
          'assets/images/onboarding4_3.png',
        ],
        title: 'The best sports equipment',
        body: 'Get everything you need in our sports store',
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
                    style: TextStyles.semiBold20(
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
                style: TextStyles.medium20(
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
        // Illustration Image - Always use FrameAnimatedWidget
        FrameAnimatedWidget(
          imagePaths: data.images,
          width: AppDimens.w320,
          height: AppDimens.h280,
          fit: BoxFit.contain,
          interval: const Duration(milliseconds: 1500),
        ),

        SizedBox(height: AppDimens.h40),

        // Title
        Padding(
          padding: AppPadding.h40,
          child: Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.darkGrayColor,
            ),
          ),
        ),

        SizedBox(height: AppDimens.h16),

        // Body
        Padding(
          padding: AppPadding.h40,
          child: Text(
            data.body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: MyColors.darkGrayColor,
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
      margin: AppPadding.h4,
      width: isActive ? AppDimens.w32 : AppDimens.w16,
      height: 5.h,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF3C9BBE)
            : MyColors.grey,
        borderRadius: AppRadius.r4,
      ),
    );
  }
}

class OnboardingData {
  /// List of image paths for frame-by-frame animation
  /// Even if a page has only 1 frame, pass it as a list of one string
  final List<String> images;
  final String
  title; // Direct string instead of translation key
  final String
  body; // Direct string instead of translation key

  const OnboardingData({
    required this.images,
    required this.title,
    required this.body,
  });
}
