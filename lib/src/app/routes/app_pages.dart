import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:getx_todo/src/app/routes/app_routes.dart';
import 'package:getx_todo/src/ui/page/splash/splash_binding.dart';
import 'package:getx_todo/src/ui/page/splash/splash_page.dart';
import 'package:getx_todo/src/ui/page/tabbar/tabbar_binding.dart';
import 'package:getx_todo/src/ui/page/tabbar/tabbar_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      transition: Transition.noTransition,
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.TABBAR,
      page: () => const TabbarPage(),
      binding: TabbarBinding(),
    ),
  ];
}
