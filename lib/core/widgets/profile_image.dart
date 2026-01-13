import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

import '../utils/constants.dart';
import 'diff_img.dart';

class ProfileImage extends StatefulWidget {
  final ValueChanged<File>? updateBannerImage;
  final String? image;
  final double? custonWeight;
  final double? customHeight;
  final double? customRaduis;

  final bool? showBaseEditButton;
  const ProfileImage({
    super.key,
    this.updateBannerImage,
    this.image,
    this.custonWeight,
    this.customHeight,
    this.showBaseEditButton,
    this.customRaduis,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker _picker = ImagePicker();
  File? avatarImageFile;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(
      context,
    ).size.height;
    double raduis = (screenWidth * 0.388) * 0.01;
    double width = screenWidth * 0.3;
    double height = screenHeight * 0.15;
    return InkWell(
      onTap: () => onPickImage(),
      child: SizedBox(
        width: widget.custonWeight ?? width,
        height: widget.custonWeight ?? height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: widget.custonWeight ?? width,
                height: widget.custonWeight ?? height,
                decoration: BoxDecoration(
                  color: const Color(0xffEDEEEF),
                  borderRadius: BorderRadius.circular(
                    widget.customRaduis ?? raduis,
                  ),
                ),
                child: avatarImageFile == null
                    ? widget.image == null
                          ? ClipRRect(
                              // borderRadius: BorderRadius.circular(raduis),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  screenWidth * 0,
                                ), //padding_16
                                child: Image.asset(
                                  ImgAssets
                                      .selectImageProfileImage,
                                ),
                              ),
                            )
                          : DiffImage(
                              width: width,
                              height: width,
                              image: widget.image ?? '',
                              fitType: BoxFit.cover,
                              radius:
                                  widget.customRaduis ??
                                  raduis,
                            )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffEDEEEF),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                widget.customRaduis ??
                                    raduis,
                              ),
                          child: Image.file(
                            avatarImageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            widget.showBaseEditButton ?? true
                ? Positioned(
                    bottom: 0,
                    right: -10.r,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: context.colors.main,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: context.colors.upBackGround,
                        size: 15,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  onPickImage() async {
    Constants.imagesSourcesShowModel(
      context: context,
      onCameraPressed: () => _onCameraTapped(),
      onGalleryPressed: () => _onGalleryTapped(),
    );
  }

  _onCameraTapped() async {
    Navigator.pop(context);
    final XFile? xImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 88,
    );
    if (!mounted) return;
    if (xImage != null) {
      setState(() {
        avatarImageFile = File(xImage.path);
        widget.updateBannerImage!(avatarImageFile!);
      });
    }
  }

  _onGalleryTapped() async {
    Navigator.pop(context);
    final XFile? xImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
    );
    if (!mounted) return;
    if (xImage != null) {
      setState(() {
        avatarImageFile = File(xImage.path);
        widget.updateBannerImage!(avatarImageFile!);
      });
    }
  }
}
