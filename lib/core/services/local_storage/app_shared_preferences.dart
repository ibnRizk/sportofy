import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/core/utils/constants.dart';

import '../../utils/enums.dart';
import '../../utils/extension.dart';

abstract class _AppSharedPreferencesKeys {
  static const countryId = 'countryId';
  static const appTheme = 'appTheme';
  static const languageCode = 'languageCode';
  static const userType = 'userType';
  static const userRole = 'userRole';
}

abstract class AppSharedPreferences {
  final SharedPreferences instance;

  const AppSharedPreferences({required this.instance});

  //region:: Country Id
  int? getCountryId();

  Future<bool> saveCountryId(int countryId);

  Future<bool> removeCountryId();

  //endregion

  //region:: Language Code
  LanguageCode getLanguageCode();

  Future<bool> saveLanguageCode(String value);

  Future<bool> removeLanguageCode();

  //endregion

  //region:: App Theme
  Themes getAppTheme();

  Future<bool> saveAppTheme(Themes theme);

  Future<bool> removeAppTheme();

  //endregion

  //region:: User Type
  UserType getUserType();

  Future<bool> saveUserType(UserType value);

  Future<bool> removeUserType();
  UserType getUserRole();

  Future<bool> saveUserRole(UserType value);

  Future<bool> removeUserRole();

  //endregion

  Future<bool> clearAll();
}

class AppSharedPreferencesImpl
    extends AppSharedPreferences {
  AppSharedPreferencesImpl({required super.instance});

  //region:: Country Id
  @override
  int? getCountryId() =>
      instance.getInt(_AppSharedPreferencesKeys.countryId);

  @override
  Future<bool> saveCountryId(int countryId) =>
      instance.setInt(
        _AppSharedPreferencesKeys.countryId,
        countryId,
      );

  @override
  Future<bool> removeCountryId() =>
      instance.remove(_AppSharedPreferencesKeys.countryId);

  //endregion

  //region:: Language Code
  @override
  LanguageCode getLanguageCode() {
    // String value = instance.getString(_AppSharedPreferencesKeys.languageCode) ??
    //     Intl.systemLocale.split('_').first;
    String value =
        instance.getString(
          _AppSharedPreferencesKeys.languageCode,
        ) ??
        Constants.getSystemLang();
    final lang = LanguageCodeExtension.fromString(value);
    log(
      'getLanguageCode Intl.systemLocale: ${Intl.systemLocale}',
    );
    log('getLanguageCode lang: $lang');
    return lang;
  }

  @override
  Future<bool> saveLanguageCode(String value) {
    final languageCode = LanguageCodeExtension.fromString(
      value,
    );
    return instance.setString(
      _AppSharedPreferencesKeys.languageCode,
      languageCode.name,
    );
  }

  @override
  Future<bool> removeLanguageCode() => instance.remove(
    _AppSharedPreferencesKeys.languageCode,
  );

  //endregion

  //region:: App Theme
  @override
  Themes getAppTheme() {
    String value =
        instance.getString(
          _AppSharedPreferencesKeys.appTheme,
        ) ??
        '';
    return ThemesExtension.fromString(value);
  }

  @override
  Future<bool> saveAppTheme(Themes theme) =>
      instance.setString(
        _AppSharedPreferencesKeys.appTheme,
        theme.name,
      );

  @override
  Future<bool> removeAppTheme() =>
      instance.remove(_AppSharedPreferencesKeys.appTheme);

  //endregion

  //region:: User Type
  @override
  UserType getUserType() => UserTypeExtension.fromString(
    instance.getString(
          _AppSharedPreferencesKeys.userType,
        ) ??
        '',
  );

  @override
  Future<bool> saveUserType(UserType value) =>
      instance.setString(
        _AppSharedPreferencesKeys.userType,
        value.name,
      );

  @override
  Future<bool> removeUserType() =>
      instance.remove(_AppSharedPreferencesKeys.userType);

  //  @override
  @override
  UserType getUserRole() => UserTypeExtension.fromString(
    instance.getString(
          _AppSharedPreferencesKeys.userRole,
        ) ??
        '',
  );

  @override
  Future<bool> saveUserRole(UserType value) =>
      instance.setString(
        _AppSharedPreferencesKeys.userRole,
        value.name,
      );

  @override
  Future<bool> removeUserRole() =>
      instance.remove(_AppSharedPreferencesKeys.userRole);

  //endregion

  @override
  Future<bool> clearAll() => instance.clear();
}
