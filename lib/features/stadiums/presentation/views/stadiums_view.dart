import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/features/stadiums/presentation/widgets/filter_sheet.dart';
import 'package:sportify_app/features/stadiums/presentation/widgets/add_sport_sheet.dart';

class StadiumsView extends StatefulWidget {
  const StadiumsView({super.key});

  @override
  State<StadiumsView> createState() => _StadiumsViewState();
}

class _StadiumsViewState extends State<StadiumsView> {
  final TextEditingController _searchController =
      TextEditingController();
  int _selectedSportIndex =
      0; // Football is selected by default
  int _selectedDateIndex = 1; // "Sat 08" is selected
  RangeValues _timeRange = const RangeValues(0.0, 1.0);
  bool _isMapView =
      false; // Toggle between List and Map view
  // ignore: unused_field
  // For future map control (camera movement, etc.)

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.black,
            size: AppDimens.iconSize24,
          ),
        ),
        title: Text(
          'Stadiums',
          style: TextStyles.bold18(color: MyColors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Fixed Filters Section
          _buildFiltersSection(),

          // Conditional Content (List or Map)
          Expanded(
            child: _isMapView
                ? _buildGoogleMap()
                : _buildStadiumsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          setState(() {
            _isMapView = !_isMapView;
          });
        },
        backgroundColor: MyColors.greenButton,
        icon: Icon(
          _isMapView ? Icons.list : Icons.map,
          color: MyColors.white,
          size: AppDimens.iconSize20,
        ),
        label: Text(
          _isMapView ? 'List' : 'Map',
          style: TextStyles.semiBold14(color: MyColors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'basketball':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }

  // Build Filters Section (Fixed at top)
  Widget _buildFiltersSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: AppPadding.h20v12,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyles.regular14(color: MyColors.grey600),
                prefixIcon: Icon(
                  Icons.search,
                  color: MyColors.grey600,
                  size: AppDimens.iconSize24,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: MyColors.greenButton,
                    size: AppDimens.iconSize24,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: MyColors.transparent,
                      builder: (context) =>
                          const FilterSheet(),
                    );
                  },
                ),
                filled: true,
                fillColor: MyColors.white,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.r12,
                  borderSide: BorderSide(
                    color: MyColors.grey300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.r12,
                  borderSide: BorderSide(
                    color: MyColors.grey300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.r12,
                  borderSide: BorderSide(
                    color: MyColors.greenButton,
                  ),
                ),
                contentPadding: AppPadding.h16v12,
              ),
            ),
          ),

          // Sports Filter
          SizedBox(
            height: AppDimens.containerHeight80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: AppPadding.h20,
              itemCount:
                  _sports.length + 1, // +1 for "Add Sport"
              itemBuilder: (context, index) {
                if (index == _sports.length) {
                  // "Add Sport" item
                  return Padding(
                    padding: AppPadding.right12,
                    child: _SportFilterItem(
                      icon: Icons.add,
                      label: 'Add Sport',
                      isSelected: false,
                      isAddButton: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              MyColors.transparent,
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
                    ),
                  );
                }

                return Padding(
                  padding: AppPadding.right12,
                  child: _SportFilterItem(
                    icon: _getSportIcon(_sports[index]),
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

          // Date Filter Section
          Padding(
            padding: AppPadding.h20,
            child: Column(
              children: [
                // Header Row
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'July 2023',
                      style: TextStyles.semiBold16(color: MyColors.black87),
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
                        style: TextStyles.medium14(color: MyColors.greenButton),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.h12),

                // Date List
                SizedBox(
                  height: AppDimens.containerHeight70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: AppPadding.right12,
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

          SizedBox(height: AppDimens.h20),

          // Date/Time Display
          if (_selectedDateIndex > 0)
            Padding(
              padding: AppPadding.h20,
              child: Column(
                children: [
                  Text(
                    'Sat 08 Jul 12:30 am - 11:30 pm',
                    style: TextStyles.medium14(color: MyColors.grey700),
                  ),
                  SizedBox(height: AppDimens.h8),
                  Divider(
                    height: AppDimens.dividerThickness1,
                    color: MyColors.grey300,
                  ),
                ],
              ),
            ),

          SizedBox(height: AppDimens.h20),

          // Time Range Section
          Padding(
            padding: AppPadding.h20,
            child: Column(
              children: [
                // Time Header
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12 : 00 am',
                      style: TextStyles.medium12(color: MyColors.grey600),
                    ),
                    Text(
                      '11 : 30 pm',
                      style: TextStyles.medium12(color: MyColors.grey600),
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.h8),

                // Range Slider
                RangeSlider(
                  values: _timeRange,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _timeRange = values;
                    });
                  },
                  activeColor: MyColors.greenButton,
                  inactiveColor: MyColors.grey300,
                  min: 0.0,
                  max: 1.0,
                ),
              ],
            ),
          ),

          SizedBox(height: AppDimens.h16),
        ],
      ),
    );
  }

  // Build Stadiums List View
  Widget _buildStadiumsList() {
    return ListView.builder(
      padding: AppPadding.h20v16,
      itemCount: 2, // Mock data count
      itemBuilder: (context, index) {
        // Alternate between light_yard and night_yard
        final image = index % 2 == 0
            ? ImgAssets.lightYard
            : ImgAssets.nightYard;
        return Padding(
          padding: AppPadding.bottom16,
          child: _StadiumCard(
            name: 'Stadium name',
            location: 'Arab Elmaadi',
            rating: 4.87,
            tags: index == 0
                ? ['5 X 5', 'Indoor']
                : ['5 X 5', 'Private', 'Indoor'],
            price: 10.00,
            image: image,
          ),
        );
      },
    );
  }

  // Build Google Map View
  Widget _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.0444, 31.2357), // Cairo, Egypt
        zoom: 12.0,
      ),
      markers: _createCustomMarkers(),
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {},
    );
  }

  // Create Custom Markers for Stadiums
  Set<Marker> _createCustomMarkers() {
    // Mock stadium locations in Cairo
    final stadiums = [
      {
        'id': '1',
        'position': LatLng(
          30.0444,
          31.2357,
        ), // Cairo center
        'name': 'Stadium name',
        'rating': 4.87,
      },
      {
        'id': '2',
        'position': LatLng(
          30.0544,
          31.2457,
        ), // Cairo slightly north
        'name': 'Stadium name',
        'rating': 4.87,
      },
    ];

    return stadiums.map((stadium) {
      return Marker(
        markerId: MarkerId(stadium['id'] as String),
        position: stadium['position'] as LatLng,
        // TODO: Implement 'widget_to_marker' to render the custom Blue Rating + Name Box exactly like the design.
        // The marker should show:
        // - Left: Blue box with Star icon + Rating (4.87)
        // - Right: White box with Stadium Name
        // For now, using default marker as placeholder
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        infoWindow: InfoWindow(
          title: stadium['name'] as String,
          snippet: 'Rating: ${stadium['rating']}',
        ),
      );
    }).toSet();
  }
}

// Sport Filter Item Widget
class _SportFilterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isAddButton;
  final VoidCallback onTap;

  const _SportFilterItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.isAddButton = false,
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
            width: AppDimens.containerWidth50,
            height: AppDimens.containerWidth50,
            decoration: BoxDecoration(
              color: isSelected
                  ? MyColors.greenButton
                  : (isAddButton
                        ? MyColors.grey200
                        : MyColors.grey100),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? MyColors.white
                  : (isAddButton
                        ? MyColors.greenButton
                        : MyColors.grey700),
              size: AppDimens.iconSize24,
            ),
          ),
          SizedBox(height: AppDimens.h6),
          Text(
            label,
            style: TextStyles.medium12(
              color: isSelected
                  ? MyColors.greenButton
                  : (isAddButton
                        ? MyColors.greenButton
                        : MyColors.grey700),
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
        padding: AppPadding.h16v8,
        decoration: BoxDecoration(
          color: isSelected
              ? MyColors.greenButton.withValues(alpha: AppDimens.opacity1)
              : MyColors.transparent,
          borderRadius: AppRadius.r8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAllDates)
              Text(
                'All',
                style: TextStyles.semiBold14(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey600,
                ),
              )
            else ...[
              Text(
                date.split(' ')[0],
                style: TextStyles.medium12(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey600,
                ),
              ),
              SizedBox(height: AppDimens.h2),
              Text(
                date.split(' ')[1],
                style: TextStyles.semiBold14(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.black87,
                ),
              ),
            ],
            if (isSelected)
              Container(
                margin: AppPadding.top4,
                height: AppDimens.h2,
                width: isAllDates ? AppDimens.w20 : AppDimens.w30,
                decoration: BoxDecoration(
                  color: MyColors.greenButton,
                  borderRadius: AppRadius.r3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Stadium Card Widget
class _StadiumCard extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final List<String> tags;
  final double price;
  final String image;

  const _StadiumCard({
    required this.name,
    required this.location,
    required this.rating,
    required this.tags,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.stadiumDetailsRoute);
      },
      borderRadius: AppRadius.r12,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.r12,
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withValues(alpha: AppDimens.opacity05),
              blurRadius: AppDimens.elevation8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.top12,
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: AppDimens.containerHeight180,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: AppDimens.containerHeight180,
                            color: MyColors.grey300,
                            child: Icon(
                              Icons.image,
                              size: AppDimens.iconSize50,
                              color: MyColors.grey600,
                            ),
                          );
                        },
                  ),
                ),
                // Map Button (floating at bottom-center of image)
                Positioned(
                  bottom: AppDimens.h12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to map view
                      },
                      icon: Icon(
                        Icons.map,
                        size: AppDimens.iconSize16,
                        color: MyColors.white,
                      ),
                      label: Text(
                        'Map',
                        style: TextStyles.semiBold12(color: MyColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MyColors.greenButton,
                        padding: AppPadding.h16v10,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              AppRadius.r20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Info Section
            Padding(
              padding: AppPadding.p16,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Name and Rating Row
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyles.bold16(color: MyColors.black87),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: MyColors.amber,
                            size: AppDimens.iconSize18,
                          ),
                          SizedBox(width: AppDimens.w4),
                          Text(
                            rating.toStringAsFixed(2),
                            style: TextStyles.semiBold14(color: MyColors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.h8),

                  // Location Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: AppDimens.iconSize16,
                        color: MyColors.grey600,
                      ),
                      SizedBox(width: AppDimens.w4),
                      Text(
                        location,
                        style: TextStyles.regular14(color: MyColors.grey600),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.h8),

                  // Tags Row
                  Row(
                    children: tags.asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final tag = entry.value;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tag,
                            style: TextStyles.medium12(color: MyColors.grey700),
                          ),
                          if (index < tags.length - 1) ...[
                            Padding(
                              padding: AppPadding.h8,
                              child: Container(
                                width: AppDimens.w1,
                                height: AppDimens.h12,
                                color: MyColors.grey300,
                              ),
                            ),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: AppDimens.h12),

                  // Price Row
                  Text(
                    'Starting from ${price.toStringAsFixed(2)} EGP',
                    style: TextStyles.semiBold14(color: MyColors.greenButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
