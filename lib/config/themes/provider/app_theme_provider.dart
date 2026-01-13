import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../cubit/app_theme_cubit/app_theme_cubit.dart';

/// Theme BlocProvider for dependency injection
final appThemeProvider = BlocProvider<AppThemeCubit>(
  create: (BuildContext context) => ServiceLocator.instance<AppThemeCubit>(),
);
