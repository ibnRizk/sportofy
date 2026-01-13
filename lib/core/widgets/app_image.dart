import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_shimmer.dart';

class AppImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final String? imageAsset;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit fit;
  final Color? color;
  final bool? isCached;
  final bool? isCircle;

  const AppImage({
    this.imageUrl,
    this.imageFile,
    this.imageAsset,
    this.borderRadius,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.color,
    this.isCached = false,
    this.isCircle = false,
    super.key,
  });

  factory AppImage.network({
    String? imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.scaleDown,
    Color? color,
    bool? isCached,
    bool? isCircle,
  }) {
    return AppImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      isCached: isCached ?? false,
      isCircle: isCircle ?? false,
    );
  }

  factory AppImage.file({
    File? imageFile,
    double? width,
    double? height,
    BoxFit fit = BoxFit.scaleDown,
    Color? color,
    bool? isCircle,
  }) {
    return AppImage(
      imageFile: imageFile,
      width: width,
      height: height,
      fit: fit,
      color: color,
      isCircle: isCircle ?? false,
    );
  }

  factory AppImage.asset({
    String? imageAsset,
    double? width,
    double? height,
    BoxFit fit = BoxFit.scaleDown,
    Color? color,
    bool? isCircle,
  }) {
    return AppImage(
      imageAsset: imageAsset,
      width: width,
      height: height,
      fit: fit,
      color: color,
      isCircle: isCircle ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (imageUrl != null) {
        return _imageNetwork;
      }
      if (imageFile != null) {
        return _imageFile;
      }
      if (imageAsset != null) {
        return _imageAsset;
      }
      return const SizedBox();
    });
  }

  Widget _buildBaseCircle(ImageProvider child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: child,
          fit: fit,
        ),
      ),
    );
  }

  Image get _imageAssetItem => Image.asset(
        imageAsset!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (BuildContext context, Object url, StackTrace? error) =>
            _errorWidget,
      );

  Widget get _imageAsset {
    if (isCircle == true) {
      return _buildBaseCircle(_imageAssetItem.image);
    }
    return _imageAssetItem;
  }

  Image get _imageFileItem => Image.file(
        imageFile!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (BuildContext context, Object url, StackTrace? error) =>
            _errorWidget,
      );

  Widget get _imageFile {
    if (isCircle == true) {
      return _buildBaseCircle(_imageFileItem.image);
    }
    return _imageFileItem;
  }

  Image get _imageNetworkItem => Image.network(
        imageUrl!,
        color: color,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return _loadingWidget;
        },
        errorBuilder: (BuildContext context, _, dynamic error) => _errorWidget,
      );

  Widget get _imageNetwork {
    if (isCached == true) {
      if (isCircle == true) {
        return _buildBaseCircle(CachedNetworkImageProvider(
          imageUrl!,
          maxWidth: width?.toInt(),
          maxHeight: height?.toInt(),
        ));
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          color: color,
          width: width,
          height: height,
          fit: fit,
          placeholderFadeInDuration: const Duration(milliseconds: 500),
          placeholder: (BuildContext context, String url) => _loadingWidget,
          errorWidget: (BuildContext context, String url, dynamic error) =>
              _errorWidget,
        ),
      );
    }
    if (isCircle == true) {
      return _buildBaseCircle(_imageNetworkItem.image);
    }
    return _imageNetworkItem;
  }

  Widget get _loadingWidget => Center(
        child: AppShimmer(
          child: Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
          ),
        ),
      );

  Widget get _errorWidget => Center(
        child: Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(
            Icons.error,
            color: Colors.grey,
          ),
        ),
      );
}
