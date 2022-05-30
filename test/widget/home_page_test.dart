import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_keys.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:getx_todo/src/ui/page/home/home_controller.dart';
import 'package:integration_test/integration_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/main_test.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Testing Home Page', () {
    testWidgets('Create success a new todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      // Tab add button
      final Finder addButton = find.byKey(AppWidgetKeys.addButton);

      await tester.tap(addButton);

      await tester.pumpAndSettle();

      // Open create todo dialog
      expect(find.text('create_task'.tr), findsOneWidget);

      var textField = find.byKey(AppWidgetKeys.dialogTextField);
      const taskTitle = 'Add new a task';
      await tester.enterText(textField, taskTitle);

      await tester.pumpAndSettle();

      final createButton = find.widgetWithText(TextButton, 'create'.tr);
      await tester.tap(createButton);

      await tester.pumpAndSettle();

      // Close create dialog
      expect(find.text('create_task'.tr), findsNothing);

      // Check inserted 'Add new a task' data
      final homeController = HomeController.to;
      final todos = homeController.todos.firstWhere((element) => element.title == taskTitle, orElse: () => TodoItem(title: ""));
      expect(todos.title.isNotEmpty, true);
    });

    testWidgets('Create fail a new todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      final homeController = HomeController.to;
      var todoLength = homeController.todos.length;

      // Tab add button
      final Finder addButton = find.byKey(AppWidgetKeys.addButton);

      await tester.tap(addButton);

      await tester.pumpAndSettle();

      // Open create todo dialog
      expect(find.text('create_task'.tr), findsOneWidget);

      var textField = find.byKey(AppWidgetKeys.dialogTextField);
      const taskTitle = '';
      await tester.enterText(textField, taskTitle);

      await tester.pumpAndSettle();

      final createButton = find.widgetWithText(TextButton, 'create'.tr);
      await tester.tap(createButton);

      await tester.pumpAndSettle();

      // Close create dialog
      expect(find.text('create_task'.tr), findsNothing);

      // Check number of todo item
      final todos = homeController.todos;
      expect(todos.length == todoLength, true);
    });

    testWidgets('Update success a new todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      //Count data
      final homeController = HomeController.to;
      expect(homeController.todos.isNotEmpty, true);

      // Touch the first item in listview
      final firstItem = homeController.todos.first;
      final Finder firstCell = find.byKey(
        Key('todoCell${firstItem.id}'),
      );

      await tester.tap(firstCell);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Open update todo dialog
      expect(find.text('update_task'.tr), findsOneWidget);

      var textField = find.byKey(AppWidgetKeys.dialogTextField);
      const taskTitle = 'Update a task';
      await tester.enterText(textField, taskTitle);

      await tester.pumpAndSettle();

      final updateButton = find.widgetWithText(TextButton, 'update'.tr);
      await tester.tap(updateButton);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      // // Close create dialog
      expect(find.text('update_task'.tr), findsNothing);

      // // Check data already update
      expect(find.text(taskTitle), findsOneWidget);
    });

    testWidgets('Update complete status for a todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      //Firt  item
      final homeController = HomeController.to;
      final firstItem = homeController.todos.first;

      final isCompleteStatus = firstItem.isComplete;

      final Finder checkBox = find.byKey(
        Key(firstItem.id.toString() + "checkbox"),
      );

      await tester.tap(checkBox);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      final updatedItem = homeController.todos.firstWhere(
        (element) => firstItem.id == element.id,
      );

      // Check item already change status
      expect(updatedItem.isComplete != isCompleteStatus, true);
    });

    testWidgets('Delete success a new todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      //Count data
      final firstItem = HomeController.to.todos.first;
      expect(HomeController.to.todos.isNotEmpty, true);

      expect(find.text(firstItem.title), findsWidgets);

      // Touch the first item in listview
      final Finder firstCell = find.byKey(
        Key('todoCell${firstItem.id}'),
      );

      await tester.drag(firstCell, const Offset(500.0, 0.0));

      await tester.pumpAndSettle();

      // Check item existing
      expect(find.byKey(Key('todoCell${firstItem.id}')), findsNothing);
    });
  });
}
