import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_config.dart';
import 'package:getx_todo/src/common/base/network/api_provider.dart';
import 'package:getx_todo/src/respository/api/app_repository.dart';
import 'package:getx_todo/src/respository/db/todo_provider.dart';
import 'package:getx_todo/src/ui/page/completion/completion_controller.dart';
import 'package:getx_todo/src/ui/page/home/home_controller.dart';
import 'package:getx_todo/src/ui/page/in_completion/in_completion_controller.dart';

class AppBindings extends Bindings {
  AppBindings(this.appConfig);
  AppConfig appConfig;
  @override
  void dependencies() {
    final apiProvider = APIProvider(appConfig.env);
    final todoProvider = TodoProvider();
    Get.put<AppConfig>(appConfig);
    Get.put<AppRepository>(AppRepository(apiProvider));
    Get.put<TodoProvider>(todoProvider);
    Get.put<HomeController>(HomeController());
    Get.put<InCompletionController>(InCompletionController());
    Get.put<CompletionController>(CompletionController());
  }
}
