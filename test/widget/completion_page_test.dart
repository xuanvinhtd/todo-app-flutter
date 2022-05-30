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
  group('Testing Completion Page', () {
    testWidgets('Create success a new todo to test Completion page', (tester) async {
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

    testWidgets('Move to completion page and check number of todo list', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      final homeController = HomeController.to;
      var hasComplete = homeController.todos.where((e) => e.isComplete).toList().isNotEmpty;

      // Tab tab button
      final Finder addButton = find.text('complete_title'.tr);
      await tester.tap(addButton);

      await tester.pumpAndSettle();

      // Check Open completion page
      expect(find.text("all_complete".tr), findsOneWidget);

      // Check page is empty
      expect(find.text("task_complete_empty".tr), hasComplete ? findsNothing : findsOneWidget);
    });

    testWidgets('Update success a todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      // Tab tab button
      final Finder addButton = find.text('complete_title'.tr);
      await tester.tap(addButton);

      //Count data
      final homeController = HomeController.to;

      var items = homeController.todos.where((e) => e.isComplete).toList();
      if (items.isEmpty) return;

      // Touch the first item in listview
      final firstItem = items.first;
      final Finder firstCell = find.byKey(
        Key('todoCell${firstItem.id}'),
      );

      await tester.tap(firstCell);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Open update todo dialog
      expect(find.text('update_task'.tr), findsOneWidget);

      var textField = find.byKey(AppWidgetKeys.dialogTextField);
      const taskTitle = 'Update a task at completion page';
      await tester.enterText(textField, taskTitle);

      await tester.pumpAndSettle();

      final updateButton = find.widgetWithText(TextButton, 'update'.tr);
      await tester.tap(updateButton);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // // Close create dialog
      expect(find.text('update_task'.tr), findsNothing);

      // // Check data already update
      expect(find.text(taskTitle), findsWidgets);
    });

    testWidgets('Update complete status for a todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      // Tab tab button
      final Finder addButton = find.text('complete_title'.tr);
      await tester.tap(addButton);

      await tester.pumpAndSettle();

      //Count data
      final homeController = HomeController.to;
      var completeItems = homeController.todos.where((e) => e.isComplete).toList();
      var hasComplete = completeItems.isNotEmpty;
      if (!hasComplete) return;

      //Check first item
      final firstItem = completeItems.first;
      expect(firstItem.isComplete, true);

      final Finder checkBox = find.byKey(
        Key(firstItem.id.toString() + "checkbox"),
      );

      await tester.tap(checkBox);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      final updatedItem = homeController.todos.where((e) => e.id == firstItem.id).first;

      // Check item already change status
      expect(updatedItem.isComplete, false);
    });

    testWidgets('Delete success a todo', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check Open home page
      expect(find.text("all_todo".tr), findsOneWidget);

      // Tab tab button
      final Finder addButton = find.text('complete_title'.tr);
      await tester.tap(addButton);

      await tester.pumpAndSettle();

      //Count data
      var completeItems = HomeController.to.todos.where((e) => e.isComplete).toList();
      var hasComplete = completeItems.isNotEmpty;
      if (!hasComplete) return;

      final firstItem = completeItems.first;

      expect(find.text(firstItem.title), findsWidgets);

      // Touch the first item in listview
      final Finder firstCell = find.byKey(
        Key('todoCell${firstItem.id}'),
      );

      await tester.drag(firstCell, const Offset(500.0, 0.0));

      await tester.pumpAndSettle();

      expect(find.byKey(Key('todoCell${firstItem.id}')), findsNothing);
    });
  });
}
