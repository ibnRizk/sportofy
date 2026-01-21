import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'app.dart';
import 'core/services/bloc_observer/bloc_observer.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffFFFFFF),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor:
          Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.light, // for iOS
      statusBarIconBrightness:
          Brightness.dark, // for Android
    ),
  );

  Bloc.observer = AppBlocObserver();
  dioConsumer.updateDeviceTypeHeader();

  runApp(const SportifyApp());
}
