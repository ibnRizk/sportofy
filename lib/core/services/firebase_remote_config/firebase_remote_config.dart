/*
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/extension.dart';
import '../../widgets/app_update_dialog.dart';
import '../../widgets/show_dialog.dart';

abstract class _RemoteConfigKeys{
  static const String version = 'doctor_version';
  static const String testVersion = 'test_doctor_version';
  static const String showUpdateDialog = 'doctor_showUpdateDialog';
  static const String updateType = 'doctor_updateType';
}

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _instance = FirebaseRemoteConfig.instance;

  FirebaseRemoteConfigService() {
    _init();
  }

  Future<void> _init() async {
    _instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await _instance.fetchAndActivate();
  }

  String _getAppLatestVersion() {
    return _instance.getString(_RemoteConfigKeys.version);
  }

  bool _getShowUpdateDialog() {
    return _instance.getBool(_RemoteConfigKeys.showUpdateDialog);
  }

  String _getAppLatestTestVersion() {
    return _instance.getString(_RemoteConfigKeys.testVersion);
  }

  AppUpdateType _getAppUpdateType() {
    String updateTypeStr = _instance.getString(_RemoteConfigKeys.updateType);
    try{
      AppUpdateType updateType = AppUpdateTypeExtension.fromString(updateTypeStr);
      return updateType;
    } catch(e){
      return AppUpdateType.flexible;
    }
  }

  Future<String> _getAppCurrentVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    log('@FirebaseRemoteConfigService:: PackageInfo version: $version, buildNumber: $buildNumber');
    return '$version+$buildNumber';
  }

  Future<void> checkForUpdates(BuildContext context) async {
    _getAppCurrentVersion().then((String currentVersion) {
      if(Constants.appVersionType == 'test'){
        String latestTestVersion = _getAppLatestTestVersion();
        log('@FirebaseRemoteConfigService:: appVersionType: test, currentVersion: $currentVersion, latestVersion: $latestTestVersion');
        if (latestTestVersion.isNotEmpty && currentVersion != latestTestVersion){
          // Show a dialog or notification to prompt the user to update
          _showAppUpdateDialog(
            context: context,
            version: latestTestVersion,
            updateType: AppUpdateType.flexible,
          );
        }
      } else if (Constants.appVersionType == 'live'){
        String latestVersion = _getAppLatestVersion();
        AppUpdateType updateType = _getAppUpdateType();
        bool showUpdateDialog = _getShowUpdateDialog();
        log('@FirebaseRemoteConfigService:: appVersionType: live, currentVersion: $currentVersion, latestVersion: $latestVersion, showUpdateDialog: $showUpdateDialog, updateType: $updateType');
        if (showUpdateDialog && latestVersion.isNotEmpty && currentVersion != latestVersion) {
          // Show a dialog or notification to prompt the user to update
          _showAppUpdateDialog(
            context: context,
            version: latestVersion,
            updateType: updateType,
          );
        }
      }
    });
  }

  void _showAppUpdateDialog({
    required BuildContext context,
    required String version,
    required AppUpdateType updateType,
}) {
    showAppDialog(
      context: context,
      isDismissible: updateType == AppUpdateType.flexible,
      child: AppUpdateDialog(newVersion: version.split('+').first),
    );
  }
}



*/