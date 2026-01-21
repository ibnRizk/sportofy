import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_app/config/routes/app_routes.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/core/utils/image_manager.dart';
import 'package:sportify_app/injection_container.dart';

class CustomDrawer extends StatelessWidget {
  final bool isGuest;

  const CustomDrawer({super.key, this.isGuest = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.w280, // ✅ Minimized drawer width
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
        padding: AppPadding.h24v20,
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
                    padding: AppPadding.h12v6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colors.textColor
                            .withValues(
                              alpha: AppDimens.opacity2,
                            ),
                      ),
                      borderRadius: AppRadius.r20,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'عربي',
                          style: TextStyles.medium14(
                            color: context.colors.textColor,
                          ),
                        ),
                        SizedBox(width: AppDimens.w6),
                        SvgPicture.asset(
                          ImgAssets.icMenuLanguage,
                          width: AppDimens.iconSize18,
                          height: AppDimens.iconSize18,
                          colorFilter: ColorFilter.mode(
                            context.colors.textColor,
                            BlendMode.srcIn,
                          ),
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
              style: TextStyles.regular16(
                color: context.colors.textColor.withValues(
                  alpha: AppDimens.opacity7,
                ),
              ).copyWith(height: 1.5),
            ),

            SizedBox(height: AppDimens.h32),

            // Sign Up Button (Green Background)
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.loginRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.greenButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r12,
                  ),
                  elevation: AppDimens.elevation0,
                ),
                child: Text(
                  'Sign up',
                  style: TextStyles.semiBold16(
                    color: MyColors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h16),

            // "Already have an account" Text
            Text(
              'Already have an account',
              style: TextStyles.regular14(
                color: context.colors.textColor.withValues(
                  alpha: AppDimens.opacity6,
                ),
              ),
            ),

            SizedBox(height: AppDimens.h12),

            // Login Button (Outlined)
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(Routes.loginRoute);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: MyColors.greenButton,
                    width: AppDimens.borderWidth2,
                  ),
                  backgroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r12,
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyles.semiBold16(
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
            padding: AppPadding.p20,
            color: context.colors.white,
            child: Row(
              children: [
                // User Avatar
                CircleAvatar(
                  radius: AppDimens.avatarSize28,
                  backgroundImage: AssetImage(
                    ImgAssets.userAvatar,
                  ),
                ),

                SizedBox(width: AppDimens.w12),

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
                            style: TextStyles.semiBold16(
                              color:
                                  context.colors.textColor,
                            ),
                          ),
                          SizedBox(width: AppDimens.w4),
                          Text(
                            '👋',
                            style: TextStyles.regular16(),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.h4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.push(Routes.profileRoute);
                        },
                        child: Text(
                          'View profile',
                          style: TextStyles.medium13(
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
            height: AppDimens.dividerThickness1,
            thickness: AppDimens.dividerThickness1,
            color: context.colors.textColor.withValues(
              alpha: AppDimens.opacity1,
            ),
          ),

          // Menu Items with Dividers
          Expanded(
            child: ListView.separated(
              padding: AppPadding.zero,
              itemCount: 9,
              separatorBuilder: (context, index) => Divider(
                height: AppDimens.dividerThickness1,
                thickness: AppDimens.dividerThickness1,
                indent: AppDimens.w60,
                color: context.colors.textColor.withValues(
                  alpha: AppDimens.opacity05,
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
            padding: AppPadding.p16,
            child: Container(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              decoration: BoxDecoration(
                color: MyColors.red,
                borderRadius: AppRadius.r12,
              ),
              child: Material(
                color: MyColors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                  borderRadius: AppRadius.r12,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImgAssets.icMenuLogout,
                        width: AppDimens.iconSize20,
                        height: AppDimens.iconSize20,
                        colorFilter: ColorFilter.mode(
                          MyColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: AppDimens.w8),
                      Text(
                        'Logout',
                        style: TextStyles.semiBold16(
                          color: MyColors.white,
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
      {
        'iconSvg': ImgAssets.icMenuActivity,
        'title': 'My Activity',
      },
      {
        'iconSvg': ImgAssets.icMenuPoints,
        'title': 'Points',
      },
      {
        'iconSvg': ImgAssets.icMenuWallet,
        'title': 'Wallet',
      },
      {'iconSvg': ImgAssets.icMenuCart, 'title': 'My Cart'},
      {
        'iconSvg': ImgAssets.icMenuTournaments,
        'title': 'Tournaments',
      },
      {
        'iconSvg': ImgAssets.icMenuOrders,
        'title': 'My Orders',
      },
      {
        'iconSvg': ImgAssets.icMenuContact,
        'title': 'Contact us',
      },
      {'iconSvg': ImgAssets.icMenuAbout, 'title': 'About'},
      {
        'iconSvg': ImgAssets.icMenuLanguage,
        'title': 'Language',
      },
    ];

    final item = menuItems[index];
    return _buildMenuItemWithSvg(
      context: context,
      iconSvg: item['iconSvg'] as String,
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
  // MENU ITEM WIDGET (SVG Icons)
  // ═══════════════════════════════════════════════
  Widget _buildMenuItemWithSvg({
    required BuildContext context,
    required String iconSvg,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPadding.h20v16,
        child: Row(
          children: [
            SvgPicture.asset(
              iconSvg,
              width: AppDimens.iconSize24,
              height: AppDimens.iconSize24,
              colorFilter: ColorFilter.mode(
                context.colors.textColor.withValues(
                  alpha: AppDimens.opacity6,
                ),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: AppDimens.w16),
            Expanded(
              child: Text(
                title,
                style: TextStyles.regular15(
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
          borderRadius: AppRadius.r16,
        ),
        title: Text(
          'Select Language',
          style: TextStyles.semiBold18(),
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
          borderRadius: AppRadius.r16,
        ),
        title: Text(
          'Logout',
          style: TextStyles.semiBold18(),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyles.regular14(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Cancel',
              style: TextStyles.semiBold14(
                color: context.colors.textColor.withValues(
                  alpha: AppDimens.opacity6,
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
              style: TextStyles.semiBold14(
                color: MyColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
