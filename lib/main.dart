import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/app_bindings.dart';
import 'package:getx_todo/src/app/config/app_config.dart';
import 'package:getx_todo/src/app/config/app_theme.dart';
import 'package:getx_todo/src/app/lang/translate_service.dart';
import 'package:getx_todo/src/app/routes/app_pages.dart';
import 'package:getx_todo/src/app/routes/app_routes.dart';
import 'package:getx_todo/src/app/config/app_env.dart';

class App extends StatelessWidget {
  final AppConfig appConfig;

  const App({Key? key, required this.appConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823),
      builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: appConfig.env.isDev,
          defaultTransition: Transition.fade,
          getPages: AppPages.routes,
          initialBinding: AppBindings(appConfig),
          smartManagement: SmartManagement.keepFactory,
          title: 'title_app'.tr,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          theme: lightThemeData,
          darkTheme: dartThemeData,
          initialRoute: Routes.SPLASH,
          routingCallback: (routing) {}),
    );
  }
}
