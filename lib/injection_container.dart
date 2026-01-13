import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sportify_app/features/splash/splash_injection.dart';

import 'config/locale/app_localizations.dart';
import 'config/themes/theme_injection.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/services/local_storage/app_secure_storage.dart';
import 'core/services/local_storage/app_shared_preferences.dart';
import 'core/services/network/netwok_info.dart';
import 'core/utils/app_colors.dart';
import 'features/language/language_injection.dart';

abstract class ServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    instance.allowReassignment = true;

    /// Features
    // await initSplashFeatureInjection();
    await initLanguageFeatureInjection();
    await initThemeFeatureInjection();

    /// Core
    await _injectSharedPreferences();
    _injectSecureStorage();
    _injectDioConsumer();
    _injectNetworkInfo();
    _injectAppInterceptors();
    _injectLogInterceptor();
    injectRoutesStackSingleton(<String>[]);
    _injectFirebaseRemoteConfigServiceSingleton();
  }

  static void _injectDioConsumer() {
    instance.registerLazySingleton<DioConsumer>(
      () => DioConsumerImpl(client: Dio()),
    );
  }

  static void _injectNetworkInfo() {
    instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(),
    );
  }

  static void _injectAppInterceptors() {
    instance.registerLazySingleton(() => AppInterceptors());
  }

  static void _injectLogInterceptor() {
    instance.registerLazySingleton(
      () => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  static Future<void> _injectSharedPreferences() async {
    final sharedPreferences =
        await SharedPreferences.getInstance();
    instance.registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferencesImpl(
        instance: sharedPreferences,
      ),
    );
  }

  static void _injectSecureStorage() {
    AndroidOptions androidOptions = const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage secureStorage =
        FlutterSecureStorage(aOptions: androidOptions);
    instance.registerLazySingleton<AppSecureStorage>(
      () => AppSecureStorageImpl(instance: secureStorage),
    );
  }

  // static void injectAppColors(
  //     {AppColors? appColors, BuildContext? context}) async {
  //   instance.registerLazySingleton<AppColors>(() {
  //     if (context != null) {
  //       return Theme.of(context).extension<AppColors>()!;
  //     }
  //     return appColors!;
  //   });
  // }

  static void injectAppLocalizations({
    AppLocalizations? appLocalizations,
    BuildContext? context,
  }) async {
    instance.registerLazySingleton<AppLocalizations>(() {
      if (context != null) {
        return AppLocalizations.of(context)!;
      }
      return appLocalizations!;
    });
  }

  static void injectRoutesStackSingleton(
    List<String> routes,
  ) {
    instance.registerLazySingleton<List<String>>(
      () => routes,
      instanceName: 'routesStack',
    );
  }

  static void injectTokenFCMSingleton(String? tokenFCM) =>
      instance.registerLazySingleton<String>(
        () => tokenFCM ?? '',
        instanceName: 'tokenFCM',
      );

  static void
  _injectFirebaseRemoteConfigServiceSingleton() {
    // instance.registerLazySingleton<FirebaseRemoteConfigService>(
    //     () => FirebaseRemoteConfigService());
  }
}

AppSharedPreferences get sharedPreferences =>
    ServiceLocator.instance<AppSharedPreferences>();

AppSecureStorage get secureStorage =>
    ServiceLocator.instance<AppSecureStorage>();

DioConsumer get dioConsumer =>
    ServiceLocator.instance<DioConsumer>();

NetworkInfo get networkInfo =>
    ServiceLocator.instance<NetworkInfo>();

AppInterceptors get appInterceptors =>
    ServiceLocator.instance<AppInterceptors>();

LogInterceptor get logInterceptor =>
    ServiceLocator.instance<LogInterceptor>();

AppLocalizations get appLocalizations =>
    ServiceLocator.instance<AppLocalizations>();

List<String> get routesStack =>
    ServiceLocator.instance<List<String>>(
      instanceName: 'routesStack',
    );

String get tokenFCM => ServiceLocator.instance<String>(
  instanceName: 'tokenFCM',
);

// FirebaseRemoteConfigService get remoteConfigService =>
//     ServiceLocator.instance<FirebaseRemoteConfigService>();
extension ThemeContextExtension on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>()!;
}
