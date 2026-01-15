import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

class AudienceSheet extends StatefulWidget {
  final String selected;

  const AudienceSheet({super.key, required this.selected});

  @override
  State<AudienceSheet> createState() =>
      _AudienceSheetState();
}

class _AudienceSheetState extends State<AudienceSheet> {
  late String _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black87,
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Audience',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Options List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _audienceOptions.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.grey[300]),
            itemBuilder: (context, index) {
              final option = _audienceOptions[index];
              final isSelected =
                  _currentSelection == option['value'];

              return _AudienceOption(
                icon: option['icon'] as IconData,
                label: option['label'] as String,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _currentSelection =
                        option['value'] as String;
                  });
                  // Close sheet and return selected value
                  Navigator.pop(context, _currentSelection);
                },
              );
            },
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _audienceOptions =
      [
        {
          'icon': Icons.public,
          'label': 'Public',
          'value': 'Public',
        },
        {
          'icon': Icons.person_outline,
          'label': 'Friends',
          'value': 'Friends',
        },
        {
          'icon': Icons.lock_outline,
          'label': 'Only me',
          'value': 'Only me',
        },
      ];
}

// Audience Option Widget
class _AudienceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AudienceOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            // Icon
            Icon(
              icon,
              size: 24.sp,
              color: Colors.grey[700],
            ),
            SizedBox(width: 16.w),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Radio Button
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected
                    ? MyColors.greenButton
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
