import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../../injection_container.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeState(isLight: _getInitialTheme()));

  static bool _getInitialTheme() {
    final savedTheme = sharedPreferences.getAppTheme();
    return savedTheme == Themes.light;
  }

  Themes get currentTheme => state.isLight ? Themes.light : Themes.dark;

  Future<void> toggleTheme() async {
    final newTheme = state.isLight ? Themes.dark : Themes.light;
    await changeTheme(newTheme);
  }

  Future<void> changeTheme(Themes theme) async {
    try {
      await sharedPreferences.saveAppTheme(theme);
      final isLight = theme == Themes.light;
      emit(AppThemeState(isLight: isLight));
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  Future<void> getSavedTheme() async {
    try {
      final savedTheme = sharedPreferences.getAppTheme();
      final isLight = savedTheme == Themes.light;
      emit(AppThemeState(isLight: isLight));
    } catch (e) {
      debugPrint('Error getting saved theme: $e');
    }
  }
}
