import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Stadiums',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          _isMapView ? 'List' : 'Map',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
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
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
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

          SizedBox(height: 20.h),

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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
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

          // Date/Time Display
          if (_selectedDateIndex > 0)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                children: [
                  Text(
                    'Sat 08 Jul 12:30 am - 11:30 pm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ],
              ),
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
                  max: 1.0,
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  // Build Stadiums List View
  Widget _buildStadiumsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      itemCount: 2, // Mock data count
      itemBuilder: (context, index) {
        // Alternate between light_yard and night_yard
        final image = index % 2 == 0
            ? ImgAssets.lightYard
            : ImgAssets.nightYard;
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
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
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? MyColors.greenButton
                  : (isAddButton
                        ? Colors.grey[200]
                        : Colors.grey[100]),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : (isAddButton
                        ? MyColors.greenButton
                        : Colors.grey[700]),
              size: 24.sp,
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
                  : (isAddButton
                        ? MyColors.greenButton
                        : Colors.grey[700]),
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
              ? MyColors.greenButton.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAllDates)
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[600],
                ),
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
                width: isAllDates ? 20.w : 30.w,
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
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
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 180.h,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.image,
                              size: 48.sp,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                  ),
                ),
                // Map Button (floating at bottom-center of image)
                Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to map view
                      },
                      icon: Icon(
                        Icons.map,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Map',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MyColors.greenButton,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Info Section
            Padding(
              padding: EdgeInsets.all(16.w),
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
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            rating.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Location Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

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
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          if (index < tags.length - 1) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                              ),
                              child: Container(
                                width: 1.w,
                                height: 12.h,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12.h),

                  // Price Row
                  Text(
                    'Starting from ${price.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.greenButton,
                    ),
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
