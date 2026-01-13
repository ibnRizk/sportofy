import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import 'cubit/app_theme_cubit/app_theme_cubit.dart';

Future<void> initThemeFeatureInjection() async {
  /// Cubit
  ServiceLocator.instance.registerLazySingleton(() => AppThemeCubit());
}

/// BlocProviders
List<BlocProvider<StateStreamableSource<Object?>>> get themeBlocs =>
    <BlocProvider<StateStreamableSource<Object?>>>[
      BlocProvider<AppThemeCubit>(
        create: (BuildContext context) =>
            ServiceLocator.instance<AppThemeCubit>(),
      ),
    ];

