import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../config/locale/app_localizations.dart';
import '../../injection_container.dart';
import '../utils/extension.dart';

class FullPhotoScreen extends StatelessWidget {
  final String image;

  const FullPhotoScreen({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.text('imagePreview'),
        ),
        elevation: 4,
      ),
      body: Container(
        color: context.colors.backGround,
        child: PhotoView(
          imageProvider: NetworkImage(image),
          // initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: image),
          loadingBuilder: (_, event) => Center(
            child: const CircularProgressIndicator().appLoading,
          ),
          backgroundDecoration: BoxDecoration(
            color: context.colors.backGround,
          ),
        ),
      ),
    );
  }
}
