import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/features/stadiums/presentation/widgets/reviews_sheet.dart';

class StadiumDetailsView extends StatefulWidget {
  const StadiumDetailsView({super.key});

  @override
  State<StadiumDetailsView> createState() =>
      _StadiumDetailsViewState();
}

class _StadiumDetailsViewState
    extends State<StadiumDetailsView> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // Mock images - using the stadium yard images
  final List<String> _stadiumImages = [
    ImgAssets.lightYard,
    ImgAssets.nightYard,
    ImgAssets.lightYard,
    ImgAssets.nightYard,
    ImgAssets.lightYard,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          CustomScrollView(
            slivers: [
              // Image Header Slider
              SliverToBoxAdapter(
                child: _buildImageHeader(),
              ),

              // Main Content
              SliverPadding(
                padding: EdgeInsets.all(20.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildMainInfoSection(),
                    SizedBox(height: 24.h),
                    _buildFacilitiesSection(),
                    SizedBox(height: 24.h),
                    _buildOpeningTimesCard(),
                    SizedBox(height: 16.h),
                    _buildStadiumLocationCard(),
                    SizedBox(
                      height: 100.h,
                    ), // Space for bottom bar
                  ]),
                ),
              ),
            ],
          ),

          // Fixed Bottom Bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  // Image Header with Slider
  Widget _buildImageHeader() {
    return SizedBox(
      height: 250.h,
      child: Stack(
        children: [
          // Image Slider
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: _stadiumImages.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _stadiumImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 48.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Overlay Gradient (for better text visibility)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 40.h,
            left: 20.w,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black
                          .withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Stadium Name',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Share Button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.share),
                color: Colors.black87,
                onPressed: () {
                  // TODO: Implement share functionality
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),

          // Page Indicators
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _stadiumImages.length,
                (index) => Container(
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Main Info Section
  Widget _buildMainInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            Expanded(
              child: Text(
                'Stadium name',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            // Rating (Tappable)
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  builder: (context) =>
                      const ReviewsSheet(),
                );
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '4.87',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '(255 Persons)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greenButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Subtitle
        Text(
          '5 X 5  |  Indoor',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Facilities Section
  Widget _buildFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _FacilityItem(
              icon: Icons.sports_soccer,
              label: 'Balls',
            ),
            _FacilityItem(
              icon: Icons.local_cafe,
              label: 'Cafe',
            ),
            _FacilityItem(
              icon: Icons.water_drop,
              label: 'Water',
            ),
            _FacilityItem(icon: Icons.wc, label: 'Toilets'),
            _FacilityItem(
              icon: Icons.shower,
              label: 'Showers',
            ),
          ],
        ),
      ],
    );
  }

  // Opening Times Card
  Widget _buildOpeningTimesCard() {
    return _InfoCard(
      title: 'Opening times',
      subtitle: '04 : 00 PM - 11 : 00 PM',
      buttonText: 'Contact Info',
      buttonIcon: Icons.phone,
      onButtonTap: () {
        // TODO: Handle contact info
      },
    );
  }

  // Stadium Location Card
  Widget _buildStadiumLocationCard() {
    return _InfoCard(
      title: 'Stadium location',
      subtitle: 'Arab Elmaadi',
      subtitleIcon: Icons.location_on,
      buttonText: 'Direction',
      buttonIcon: Icons.send,
      onButtonTap: () {
        // TODO: Handle direction
      },
    );
  }

  // Fixed Bottom Bar
  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.all(20.w),
        child: SafeArea(
          child: Row(
            children: [
              // Price Section
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Starting from',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '50 EGP',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.greenButton,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Booking Button
              ElevatedButton(
                onPressed: () {
                  context.push(Routes.appointmentRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                ),
                child: Text(
                  'Booking',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Facility Item Widget
class _FacilityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: MyColors.greenButton,
            size: 24.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Info Card Widget
class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? subtitleIcon;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onButtonTap;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    this.subtitleIcon,
    required this.buttonText,
    required this.buttonIcon,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    if (subtitleIcon != null) ...[
                      Icon(
                        subtitleIcon,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Right Side - Button
          OutlinedButton(
            onPressed: onButtonTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: MyColors.greenButton,
                width: 1,
              ),
              foregroundColor: MyColors.greenButton,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(buttonIcon, size: 16.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
