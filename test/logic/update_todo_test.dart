import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:getx_todo/src/ui/page/home/home_controller.dart';
import 'package:integration_test/integration_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/main_test.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Testing main logic of todo app', () {
    const todoTitle = 'Todo item title';

    testWidgets('Create success a new todo item', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final homeController = HomeController.to;
      homeController.addTodoItem(todoTitle, onComplete: (success, msg) {
        expect('add_success'.tr, msg);
        expect(success, true);
      });
    });

    test('Create error a new todo item', () async {
      final homeController = HomeController.to;
      homeController.addTodoItem('', onComplete: (success, msg) {
        expect('contents_not_empty'.tr, msg);
        expect(success, false);
      });
    });

    test('Update success a todo item', () async {
      final homeController = HomeController.to;
      final item = homeController.todos.last;
      homeController.updateTodoItem(item, title: 'Update new title', onComplete: (success, msg) {
        expect('update_success'.tr, msg);
        expect(success, true);
      });
    });

    test('Not update a todo item', () async {
      final homeController = HomeController.to;
      homeController.updateTodoItem(TodoItem(title: 'Hello word'), title: '', onComplete: (success, msg) {
        expect(msg.isEmpty, true);
        expect(success, false);
      });
    });

    test('Delete success a todo item', () async {
      final homeController = HomeController.to;
      final item = homeController.todos.last;
      homeController.deleteTodoItem(item, onComplete: (success, msg) {
        expect('delete_success'.tr, msg);
        expect(success, true);
      });
    });

    test('Delete error a todo item', () async {
      final homeController = HomeController.to;
      final newTodoItem = TodoItem(id: 100, title: todoTitle);
      homeController.deleteTodoItem(newTodoItem, onComplete: (success, msg) {
        expect(msg.isEmpty, true);
        expect(success, false);
      });
    });
  });
}
