import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/config/locale/app_localizations.dart';
import 'package:sportify_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:sportify_app/features/home/presentation/pages/home_view.dart';
import 'package:sportify_app/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:sportify_app/features/home/presentation/widgets/custom_drawer.dart';
import 'package:sportify_app/features/home/presentation/widgets/location_permission_dialog.dart';
import 'package:sportify_app/injection_container.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  // Global Key for Drawer Control
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    // Wait a bit for UI to settle
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      final cubit = context.read<HomeCubit>();
      if (!cubit.state.hasLocationPermission) {
        _showLocationPermissionDialog();
      }
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => LocationPermissionDialog(
        onAllow: () {
          context
              .read<HomeCubit>()
              .setLocationPermissionGranted(true);
          Navigator.of(dialogContext).pop();
        },
        onDeny: () {
          context
              .read<HomeCubit>()
              .setLocationPermissionGranted(false);
          Navigator.of(dialogContext).pop();
        },
      ),
    );
  }

  // Method to open drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ← Assign GlobalKey
      backgroundColor: context.colors.backGround,
      drawer: const CustomDrawer(
        isGuest: false, // Change to true for guest mode
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentNavIndex,
            children: [
              HomeView(
                onMenuTap: _openDrawer,
              ), // ← Pass callback
              _buildPlaceholderPage('market'.tr(context)),
              _buildPlaceholderPage(
                'community'.tr(context),
              ),
              _buildPlaceholderPage('stadiums'.tr(context)),
              _buildPlaceholderPage('matches'.tr(context)),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildPlaceholderPage(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: context.colors.textColor,
        ),
      ),
    );
  }
}
