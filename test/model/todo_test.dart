import 'package:flutter_test/flutter_test.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:getx_todo/src/respository/db/todo_provider.dart';

void main() {
  group('Testing Todo Provider', () {
    const todoTitle = 'Todo item title';
    final newTodoItem = TodoItem(title: todoTitle);
    final todoProvider = TodoProvider();

    test('Insert a new todo item', () async {
      await todoProvider.open(isTestMode: true);
      final newItem = await todoProvider.insert(newTodoItem);
      newTodoItem.id = newItem.id;
      expect(newItem.title, todoTitle);
    });

    test('Get a todo item by Id', () async {
      var item = await todoProvider.getTodo(newTodoItem.id ?? 0);
      expect(item?.id, newTodoItem.id);
    });

    test('Update a todo item', () async {
      const newTitle = 'New todo item';
      newTodoItem.title = newTitle;
      final count = await todoProvider.update(newTodoItem);
      expect(count > 0, true);
    });

    test('Delete a todo item', () async {
      final count = await todoProvider.delete(newTodoItem.id ?? 0);
      expect(count > 0, true);
    });
  });
}
