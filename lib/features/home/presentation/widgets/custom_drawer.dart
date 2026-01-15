import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class CustomDrawer extends StatelessWidget {
  final bool isGuest;

  const CustomDrawer({super.key, this.isGuest = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w, // ✅ Minimized drawer width
      child: Drawer(
        backgroundColor: context.colors.white,
        child: isGuest
            ? _buildGuestDrawer(context)
            : _buildUserDrawer(context),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // GUEST DRAWER (Not Logged In)
  // ═══════════════════════════════════════════════
  Widget _buildGuestDrawer(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            // Language Selector (Top Right)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colors.textColor
                            .withValues(alpha: 0.2),
                      ),
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'عربي',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.language,
                          size: 18.w,
                          color: context.colors.textColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Welcome Text (Centered)
            Text(
              'Log in and be part of an amazing\nsports community',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.textColor.withValues(
                  alpha: 0.7,
                ),

                height: 1.5,
              ),
            ),

            SizedBox(height: 32.h),

            // Sign Up Button (Green Background)
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.loginRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // "Already have an account" Text
            Text(
              'Already have an account',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.textColor.withOpacity(
                  0.6,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Login Button (Outlined)
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.loginRoute);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: MyColors.greenButton,
                    width: 1.5,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.greenButton,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // USER DRAWER (Logged In)
  // ═══════════════════════════════════════════════
  Widget _buildUserDrawer(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(20.w),
            color: context.colors.white,
            child: Row(
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 28.r,
                  backgroundImage: AssetImage(
                    ImgAssets.userAvatar,
                  ),
                ),

                SizedBox(width: 12.w),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi, Ahmed Hassen',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  context.colors.textColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '👋',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.push(Routes.profileRoute);
                        },
                        child: Text(
                          'View profile',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greenButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 1,
            color: context.colors.textColor.withOpacity(
              0.1,
            ),
          ),

          // Menu Items with Dividers
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 9,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                indent: 60.w,
                color: context.colors.textColor.withOpacity(
                  0.05,
                ),
              ),
              itemBuilder: (context, index) {
                return _buildMenuItemByIndex(
                  context,
                  index,
                );
              },
            ),
          ),

          // Logout Button (Red Container at Bottom)
          Container(
            padding: EdgeInsets.all(16.w),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 20.w,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build menu items by index
  Widget _buildMenuItemByIndex(
    BuildContext context,
    int index,
  ) {
    final menuItems = [
      {'iconData': Icons.refresh, 'title': 'My Activity'},
      {'iconData': Icons.star_border, 'title': 'Points'},
      {
        'iconData': Icons.account_balance_wallet_outlined,
        'title': 'Wallet',
      },
      {
        'iconData': Icons.shopping_cart_outlined,
        'title': 'My Cart',
      },
      {
        'iconData': Icons.emoji_events_outlined,
        'title': 'Tournaments',
      },
      {
        'iconData': Icons.receipt_long_outlined,
        'title': 'My Orders',
      },
      {
        'iconData': Icons.phone_outlined,
        'title': 'Contact us',
      },
      {'iconData': Icons.info_outline, 'title': 'About'},
      {'iconData': Icons.language, 'title': 'Language'},
    ];

    final item = menuItems[index];
    return _buildMenuItemWithIconData(
      context: context,
      iconData: item['iconData'] as IconData,
      title: item['title'] as String,
      onTap: () {
        Navigator.pop(context);
        // Navigate based on index
        switch (index) {
          case 0: // My Activity
            context.push('/my-activity');
            break;
          case 1: // Points
            context.push('/points');
            break;
          case 2: // Wallet
            context.push('/wallet');
            break;
          case 3: // My Cart
            // TODO: Navigate to My Cart screen
            break;
          case 4: // Tournaments
            context.push('/tournaments');
            break;
          case 5: // My Orders
            context.push('/my-orders');
            break;
          case 6: // Contact us
            // TODO: Navigate to Contact us screen
            break;
          case 7: // About
            // TODO: Navigate to About screen
            break;
          case 8: // Language
            _showLanguageDialog(context);
            break;
        }
      },
    );
  }

  // ═══════════════════════════════════════════════
  // MENU ITEM WIDGET (Material Icons)
  // ═══════════════════════════════════════════════
  Widget _buildMenuItemWithIconData({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 24.w,
              color: context.colors.textColor.withOpacity(
                0.6,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.textColor,
                ),
              ),
            ),
            // ✅ NO TRAILING ARROW
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // LANGUAGE DIALOG
  // ═══════════════════════════════════════════════
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Select Language',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              leading: Radio(
                value: 'en',
                groupValue: 'en',
                onChanged: (value) {
                  Navigator.pop(dialogContext);
                },
              ),
            ),
            ListTile(
              title: const Text('العربية'),
              leading: Radio(
                value: 'ar',
                groupValue: 'en',
                onChanged: (value) {
                  Navigator.pop(dialogContext);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  // LOGOUT CONFIRMATION DIALOG
  // ═══════════════════════════════════════════════
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.textColor.withOpacity(
                  0.6,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // Perform logout
              context.go(Routes.loginRoute);
            },
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
