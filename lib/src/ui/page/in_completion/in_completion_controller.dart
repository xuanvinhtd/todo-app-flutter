import 'package:get/get.dart';
import 'package:getx_todo/src/ui/page/home/home_controller.dart';

class InCompletionController extends GetxController {
  HomeController get homeController => HomeController.to;

  RxList get todoInCompleteds => homeController.todos.where((e) => !e.isComplete).toList().obs;
}
