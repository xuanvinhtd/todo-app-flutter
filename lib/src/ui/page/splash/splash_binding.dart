import 'package:get/get.dart';
import 'package:getx_todo/src/ui/page/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
