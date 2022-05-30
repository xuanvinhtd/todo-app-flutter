import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_config.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:getx_todo/src/respository/db/todo_provider.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final todos = <TodoItem>[].obs;
  TodoProvider get todoProvider => Get.find();

  @override
  void onInit() async {
    final appConfig = Get.find<AppConfig>();
    await todoProvider.open(isTestMode: appConfig.isTestMode);
    final data = await todoProvider.getAll();
    todos.addAll(data);
    super.onInit();
  }

  void addTodoItem(String title, {bool? isComplete, Function(bool, String)? onComplete}) async {
    if (title.isEmpty) {
      onComplete?.call(false, 'contents_not_empty'.tr);
      return;
    }

    final todoItem = TodoItem(title: title);
    try {
      todos.add(await todoProvider.insert(todoItem));
      onComplete?.call(true, 'add_success'.tr);
    } catch (e) {
      onComplete?.call(true, e.toString());
    }
  }

  void updateTodoItem(TodoItem todoItem, {Function(bool, String)? onComplete, String? title, bool? isComplete}) async {
    if (todoItem.id == null) {
      onComplete?.call(false, '');
      return;
    }
    var item = await todoProvider.getTodo(todoItem.id ?? 0);

    if (item != null) {
      if (title != null) {
        if (title.isEmpty) {
          onComplete?.call(false, 'contents_not_empty'.tr);
          return;
        }
        if (title == todoItem.title) {
          onComplete?.call(false, '');
          return;
        }

        item.title = title;
        todoItem.title = title;
      }

      if (isComplete != null) {
        item.isComplete = isComplete;
        todoItem.isComplete = isComplete;
      }
      try {
        await todoProvider.update(item);
        todos.refresh();
        if (isComplete == null) {
          onComplete?.call(true, 'update_success'.tr);
        }
      } catch (e) {
        onComplete?.call(true, e.toString());
      }
    } else {
      onComplete?.call(false, '');
    }
  }

  void deleteTodoItem(TodoItem todoItem, {Function(bool, String)? onComplete}) async {
    if (todoItem.id != null) {
      try {
        final count = await todoProvider.delete(todoItem.id ?? 0);
        if (count > 0) {
          todos.removeWhere((element) => element.id == todoItem.id);
          onComplete?.call(true, 'delete_success'.tr);
        } else {
          onComplete?.call(false, '');
        }
      } catch (e) {
        onComplete?.call(true, e.toString());
      }
    } else {
      onComplete?.call(false, '');
    }
  }
}
