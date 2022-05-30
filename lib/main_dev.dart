import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getx_todo/main.dart';
import 'package:getx_todo/src/app/app_orientation.dart';
import 'package:getx_todo/src/app/config/app_config.dart';
import 'package:getx_todo/src/app/dependency_injection.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  AppOrientation.setOrientationPortrait();
  await DependencyInjection.init();
  runApp(App(appConfig: AppConfig.dev()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
