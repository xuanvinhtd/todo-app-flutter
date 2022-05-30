import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_config.dart';
import 'package:getx_todo/src/app/config/app_env.dart';
import 'package:getx_todo/src/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.offAndToNamed(Routes.TABBAR);
    });
    super.onInit();
  }

  String appTitle() {
    final appConfig = Get.find<AppConfig>();
    switch (appConfig.env) {
      case AppEnv.dev:
        return 'title_dev_app';
      case AppEnv.stg:
        return 'title_stg_app';
      default:
        return 'title_app';
    }
  }
}
