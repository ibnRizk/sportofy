import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/widgets/app_image.dart';
import 'package:sportify_app/injection_container.dart';

// Define all splash stages
enum SplashStage {
  blank,
  soccer,
  basketball,
  tennis,
  miniball,
  sportifyWithBall,
  logoWithText,
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  SplashStage _currentStage = SplashStage.blank;

  // Animation for the miniball pop in sportifyWithBall stage
  late AnimationController _ballPopController;
  late Animation<double> _ballPopAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _ballPopController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _ballPopAnimation = CurvedAnimation(
      parent: _ballPopController,
      curve: Curves.elasticOut,
    );
  }

  void _startSplashSequence() {
    // 0ms - 500ms: Blank white screen
    // (Initial state is already blank)

    // 500ms: Show Soccer
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted)
        setState(() => _currentStage = SplashStage.soccer);
    });

    // 1000ms: Show Basketball
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted)
        setState(
          () => _currentStage = SplashStage.basketball,
        );
    });

    // 1500ms: Show Tennis
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted)
        setState(() => _currentStage = SplashStage.tennis);
    });

    // 2000ms: Show Miniball alone
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted)
        setState(
          () => _currentStage = SplashStage.miniball,
        );
    });

    // 2500ms: Show Sportify text + Miniball together
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(
          () =>
              _currentStage = SplashStage.sportifyWithBall,
        );
        // Trigger ball pop animation
        _ballPopController.forward();
      }
    });

    // 3500ms: Show Logo with text
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted)
        setState(
          () => _currentStage = SplashStage.logoWithText,
        );
    });

    // 4500ms: Navigate to Onboarding
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (!mounted) return;
      if (!context.mounted) return;
      try {
        context.go(Routes.onboardingRoute);
      } catch (e) {
        debugPrint('Navigation error from splash: $e');
      }
    });
  }

  @override
  void dispose() {
    _ballPopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder:
            (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.7, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                  child: child,
                ),
              );
            },
        child: _buildStageWidget(),
      ),
    );
  }

  Widget _buildStageWidget() {
    switch (_currentStage) {
      case SplashStage.blank:
        return const SizedBox.shrink(
          key: ValueKey('blank'),
        );

      case SplashStage.soccer:
        return Center(
          key: const ValueKey('soccer'),
          child: AppImage.asset(
            imageAsset: ImgAssets.splashSoccer,
            width: 90.w,
            fit: BoxFit.contain,
          ),
        );

      case SplashStage.basketball:
        return Center(
          key: const ValueKey('basketball'),
          child: AppImage.asset(
            imageAsset: ImgAssets.splashBasket,
            width: 90.w,
            fit: BoxFit.contain,
          ),
        );

      case SplashStage.tennis:
        return Center(
          key: const ValueKey('tennis'),
          child: AppImage.asset(
            imageAsset: ImgAssets.splashTennis,
            width: 90.w,
            fit: BoxFit.contain,
          ),
        );

      case SplashStage.miniball:
        return Center(
          key: const ValueKey('miniball'),
          child: AppImage.asset(
            imageAsset: ImgAssets.splashSmallBall,
            width: 60.w,
            fit: BoxFit.contain,
          ),
        );

      case SplashStage.sportifyWithBall:
        return Center(
          key: const ValueKey('sportifyWithBall'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sportify Text
              AppImage.asset(
                imageAsset: ImgAssets.sportifyText,
                width: 180.w,
                fit: BoxFit.contain,
              ),

              SizedBox(width: 8.w),

              // Miniball (Pops In)
              ScaleTransition(
                scale: _ballPopAnimation,
                child: AppImage.asset(
                  imageAsset: ImgAssets.splashSmallBall,
                  width: 24.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );

      case SplashStage.logoWithText:
        return Center(
          key: const ValueKey('logoWithText'),
          child: AppImage.asset(
            imageAsset: ImgAssets.logoWithText,
            width: 200.w,
            fit: BoxFit.contain,
          ),
        );
    }
  }
}
