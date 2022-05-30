import 'package:get/get.dart';
import 'package:getx_todo/src/ui/page/tabbar/tabbar_controller.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabbarController>(() => TabbarController());
  }
}
