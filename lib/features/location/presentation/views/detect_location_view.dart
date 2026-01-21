import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class DetectLocationView extends StatelessWidget {
  const DetectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            size: AppDimens.iconSize24,
            color: MyColors.black,
          ),
        ),
        title: Text(
          'Detect location',
          style: TextStyles.bold18(color: MyColors.black),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // ═══════════════════════════════════════════════
          // LAYER 1: MAP BACKGROUND (Placeholder)
          // ═══════════════════════════════════════════════
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: MyColors.grey200,
              // Optional: Add a map pattern image if available
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/map_pattern.png'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Center(
                child: Text(
                  'Map Placeholder\n(Google Maps will be integrated here)',
                  textAlign: TextAlign.center,
                  style: TextStyles.regular14(color: MyColors.grey600),
                ),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 2: TOP SEARCH BAR (Floating)
          // ═══════════════════════════════════════════════
          SafeArea(
            child: Padding(
              padding: AppPadding.h20v20,
              child: Container(
                height: AppDimens.buttonHeight50,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: AppRadius.r8,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.black.withValues(alpha: AppDimens.opacity12),
                      blurRadius: AppDimens.elevation8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: AppDimens.w16),
                    Icon(
                      Icons.search,
                      size: AppDimens.iconSize24,
                      color: MyColors.grey600,
                    ),
                    SizedBox(width: AppDimens.w12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyles.regular16(color: MyColors.grey500),
                          border: InputBorder.none,
                          contentPadding: AppPadding.zero,
                        ),
                        style: TextStyles.regular16(color: MyColors.black87),
                      ),
                    ),
                    SizedBox(width: AppDimens.w16),
                  ],
                ),
              ),
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 3: CENTER PIN (Fixed Marker)
          // ═══════════════════════════════════════════════
          Center(
            child: Icon(
              Icons.location_on,
              size: AppDimens.iconSize50,
              color: MyColors.greenButton,
            ),
          ),

          // ═══════════════════════════════════════════════
          // LAYER 4: BOTTOM CONTROLS (Floating Actions)
          // ═══════════════════════════════════════════════
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // My Location Button (Right-aligned)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: AppPadding.right20.copyWith(bottom: AppDimens.h20),
                    child: Container(
                      width: AppDimens.containerHeight50,
                      height: AppDimens.containerHeight50,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.black.withValues(alpha: AppDimens.opacity12),
                            blurRadius: AppDimens.elevation8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Get current location
                        },
                        icon: Icon(
                          Icons.my_location,
                          size: AppDimens.iconSize24,
                          color: MyColors.black87,
                        ),
                        padding: AppPadding.zero,
                      ),
                    ),
                  ),
                ),

                // Select Button (Full width)
                Padding(
                  padding: AppPadding.h20.copyWith(bottom: AppDimens.h20),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return selected location and close
                        context.pop();
                        // TODO: Return location data
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.greenButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.r10,
                        ),
                        elevation: AppDimens.elevation0,
                      ),
                      child: Text(
                        'Select the location',
                        style: TextStyles.bold16(color: MyColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
