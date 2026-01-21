import 'dart:async';
import 'package:flutter/material.dart';
import 'app_image.dart';

/// Widget that cycles through a list of images to create a frame-by-frame animation
class FrameAnimatedWidget extends StatefulWidget {
  /// List of image asset paths to cycle through
  final List<String> imagePaths;

  /// Duration between frame changes (default: 700ms)
  final Duration interval;

  /// Width of the image
  final double? width;

  /// Height of the image
  final double? height;

  /// BoxFit for the image
  final BoxFit fit;

  const FrameAnimatedWidget({
    super.key,
    required this.imagePaths,
    this.interval = const Duration(milliseconds: 700),
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<FrameAnimatedWidget> createState() => _FrameAnimatedWidgetState();
}

class _FrameAnimatedWidgetState extends State<FrameAnimatedWidget> {
  Timer? _timer;
  int _currentFrameIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.imagePaths.isEmpty) {
      return;
    }

    // Reset to first frame when widget is initialized
    _currentFrameIndex = 0;

    // Start the animation sequence (plays once, then stops on last frame)
    _timer = Timer.periodic(widget.interval, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      // Check if we've reached the last frame
      if (_currentFrameIndex < widget.imagePaths.length - 1) {
        // Move to next frame
        setState(() {
          _currentFrameIndex++;
        });
      } else {
        // Reached the last frame - stop the animation
        timer.cancel();
        _timer = null;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: AppImage(
        key: ValueKey(_currentFrameIndex),
        imageAsset: widget.imagePaths[_currentFrameIndex],
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}
