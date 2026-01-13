import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/core/widgets/app_image.dart';
import 'package:sportify_app/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> _splashImages = [
    ImgAssets.splashSoccer,
    ImgAssets.splashBasket,
    ImgAssets.splashTennis,
    ImgAssets.appLogo,
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSequenceAnimation();
  }

  void _startSequenceAnimation() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 600),
      (timer) {
        if (_currentIndex < _splashImages.length - 1) {
          setState(() {
            _currentIndex++;
          });
        } else {
          // Stop timer when reaching the logo
          timer.cancel();
          // Wait on logo then navigate
          Future.delayed(
            const Duration(milliseconds: 1500),
            () {
              if (mounted) {
                context.go(Routes.homeScreenRoute);
              }
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder:
              (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale:
                        Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutExpo,
                          ),
                        ),
                    child: child,
                  ),
                );
              },
          child: Container(
            key: ValueKey<int>(_currentIndex),
            child: AppImage.asset(
              imageAsset: _splashImages[_currentIndex],
              width:
                  _currentIndex == _splashImages.length - 1
                  ? 200.w
                  : 120.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
