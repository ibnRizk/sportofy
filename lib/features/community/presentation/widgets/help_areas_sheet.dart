import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

class HelpAreasSheet extends StatefulWidget {
  const HelpAreasSheet({super.key});

  @override
  State<HelpAreasSheet> createState() => _HelpAreasSheetState();
}

class _HelpAreasSheetState extends State<HelpAreasSheet> {
  final List<String> _allHelpAreas = ['Marketing', 'Assets', 'Fund'];
  final List<String> _selectedHelpAreas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.h20v20,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.top30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: AppDimens.w40,
            height: AppDimens.h4,
            decoration: BoxDecoration(
              color: MyColors.grey300,
              borderRadius: AppRadius.r2,
            ),
          ),

          SizedBox(height: AppDimens.h20),

          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: MyColors.black,
                  size: AppDimens.iconSize24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: AppPadding.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(width: AppDimens.w12),
              Text(
                'Help Areas',
                style: TextStyles.bold18(color: MyColors.black87),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h20),

          // Options List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allHelpAreas.length,
            separatorBuilder: (context, index) => Divider(
              height: AppDimens.dividerThickness1,
              color: MyColors.grey200,
              thickness: AppDimens.dividerThickness1,
            ),
            itemBuilder: (context, index) {
              final area = _allHelpAreas[index];
              final isSelected = _selectedHelpAreas.contains(area);

              return CheckboxListTile(
                title: Text(
                  area,
                  style: TextStyles.medium16(color: MyColors.black87),
                ),
                value: isSelected,
                activeColor: MyColors.greenButton,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: AppPadding.zero,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedHelpAreas.add(area);
                    } else {
                      _selectedHelpAreas.remove(area);
                    }
                  });
                },
              );
            },
          ),

          SizedBox(height: AppDimens.h20),

          // Divider
          Divider(
            height: AppDimens.dividerThickness1,
            color: MyColors.grey200,
            thickness: AppDimens.dividerThickness1,
          ),

          SizedBox(height: AppDimens.h16),

          // Footer Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Clear All Button
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedHelpAreas.clear();
                  });
                },
                child: Text(
                  'Clear All',
                  style: TextStyles.semiBold14(color: MyColors.greenButton),
                ),
              ),

              // Add Button
              ElevatedButton(
                onPressed: () {
                  // Close sheet and navigate to CreatePostView with selected areas
                  Navigator.pop(context);
                  _navigateToCreatePost(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r12,
                  ),
                  padding: AppPadding.h24v12,
                  elevation: 0,
                ),
                child: Text(
                  'Add',
                  style: TextStyles.semiBold14(),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h10),
        ],
      ),
    );
  }

  void _navigateToCreatePost(BuildContext context) {
    if (!context.mounted) return;
    try {
      context.push(
        Routes.createPostRoute,
        extra: {
          'postType': 'project',
          'helpAreas': _selectedHelpAreas,
        },
      );
    } catch (e) {
      debugPrint('Navigation error to CreatePostView: $e');
    }
  }
}
