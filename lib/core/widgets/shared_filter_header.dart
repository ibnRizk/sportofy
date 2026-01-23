import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/features/stadiums/presentation/widgets/add_sport_sheet.dart';
import 'package:sportify_app/features/stadiums/presentation/widgets/filter_sheet.dart';

class SharedFilterHeader extends StatefulWidget {
  final TextEditingController? searchController;
  final VoidCallback? onFilterTap;
  final VoidCallback? onAddSportTap;

  const SharedFilterHeader({
    super.key,
    this.searchController,
    this.onFilterTap,
    this.onAddSportTap,
  });

  @override
  State<SharedFilterHeader> createState() =>
      _SharedFilterHeaderState();
}

class _SharedFilterHeaderState
    extends State<SharedFilterHeader> {
  late TextEditingController _searchController;
  int _selectedSportIndex =
      0; // Football is selected by default
  int _selectedDateIndex = 0; // "All Dates" is selected
  RangeValues _timeRange = const RangeValues(0.0, 1.0);

  final List<String> _sports = [
    'Football',
    'Basketball',
    'Tennis',
  ];

  final List<String> _dates = [
    'All Dates',
    'Sat 08',
    'Sun 09',
    'Mon 10',
    'Tue 11',
    'Wed 12',
    'Thu 13',
    'Fri 14',
  ];

  @override
  void initState() {
    super.initState();
    _searchController =
        widget.searchController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _searchController.dispose();
    }
    super.dispose();
  }

  IconData? _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return null; // Use SVG instead
      default:
        return Icons.sports;
    }
  }

  String? _getSportIconPath(String sport) {
    switch (sport.toLowerCase()) {
      case 'tennis':
        return ImgAssets.icTennis;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: MyColors.greenButton,
                    size: 24.sp,
                  ),
                  onPressed:
                      widget.onFilterTap ??
                      () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              Colors.transparent,
                          builder: (context) =>
                              const FilterSheet(),
                        );
                      },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: MyColors.greenButton,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),

          // Sports Filter
          SizedBox(
            height: 80.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              itemCount:
                  _sports.length + 1, // +1 for "Add Sport"
              itemBuilder: (context, index) {
                if (index == _sports.length) {
                  // "Add Sport" item
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap:
                          widget.onAddSportTap ??
                          () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor:
                                  Colors.transparent,
                              builder: (context) =>
                                  const AddSportSheet(),
                            ).then((selectedSports) {
                              // Handle the returned selected sports if needed
                              if (selectedSports != null &&
                                  selectedSports
                                      is List<String>) {
                                // Update the sports list or perform any action
                                // For now, just a placeholder
                              }
                            });
                          },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: MyColors.greenButton,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Add Sport',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: MyColors.greenButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _SportFilterItem(
                    icon: _getSportIcon(_sports[index]),
                    iconPath: _getSportIconPath(
                      _sports[index],
                    ),
                    label: _sports[index],
                    isSelected:
                        _selectedSportIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedSportIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: AppDimens.h20),
          Divider(
            height: AppDimens.dividerThickness1,
            color: MyColors.grey300,
          ),
          // Date Filter Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Header Row
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'July 2023',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: MyColors.darkGrayColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedDateIndex = 0;
                          _timeRange = const RangeValues(
                            0.0,
                            1.0,
                          );
                        });
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greenButton,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Date List
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 12.w,
                        ),
                        child: _DateFilterItem(
                          date: _dates[index],
                          isSelected:
                              _selectedDateIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedDateIndex = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Divider between dates and time
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200]!,
          ),

          SizedBox(height: 20.h),

          // Time Range Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Time Header
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12 : 00 am',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '11 : 30 pm',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Range Slider
                RangeSlider(
                  values: _timeRange,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _timeRange = values;
                    });
                  },
                  activeColor: MyColors.greenButton,
                  inactiveColor: Colors.grey[300],
                  min: 0.0,
                  max: 1,
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

// Sport Filter Item Widget
class _SportFilterItem extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SportFilterItem({
    this.icon,
    this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? MyColors.greenButton
                  : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: iconPath != null
                  ? SvgPicture.asset(
                      iconPath!,
                      width: 24.sp,
                      height: 24.sp,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? Colors.white
                            : Colors.grey[700]!,
                        BlendMode.srcIn,
                      ),
                    )
                  : Icon(
                      icon,
                      color: isSelected
                          ? Colors.white
                          : Colors.grey[700],
                      size: 24.sp,
                    ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? MyColors.greenButton
                  : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

// Date Filter Item Widget
class _DateFilterItem extends StatelessWidget {
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateFilterItem({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAllDates = date == 'All Dates';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? MyColors.greenButton.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAllDates)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? MyColors.greenButton
                          : Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Dates',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? MyColors.greenButton
                          : Colors.grey[600],
                    ),
                  ),
                ],
              )
            else ...[
              Text(
                date.split(' ')[0],
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[600],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                date.split(' ')[1],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.black87,
                ),
              ),
            ],
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4.h),
                height: 2.h,
                width: isAllDates ? 30.w : 30.w,
                decoration: BoxDecoration(
                  color: MyColors.greenButton,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
