import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TodoProvider {
  late Database db;

  Future open({bool isTestMode = false}) async {
    if (isTestMode) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      db = await databaseFactory.openDatabase(AppConstant.dbName,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('''
              create table ${AppConstant.tableTodo} ( 
                ${AppConstant.columnId} integer primary key autoincrement, 
                ${AppConstant.columnTitle} text not null,
                ${AppConstant.columnDone} integer not null)
              ''');
            },
          ));
    } else {
      db = await openDatabase(AppConstant.dbName, version: 1, onCreate: (Database db, int version) async {
        await db.execute('''
create table ${AppConstant.tableTodo} (
  ${AppConstant.columnId} integer primary key autoincrement,
  ${AppConstant.columnTitle} text not null,
  ${AppConstant.columnDone} integer not null)
''');
      });
    }
  }

  Future<TodoItem> insert(TodoItem todo) async {
    todo.id = await db.insert(AppConstant.tableTodo, todo.toMap());
    return todo;
  }

  Future<List<TodoItem>> getAll() async {
    List<Map<String, Object?>> records = await db.query(AppConstant.tableTodo);
    if (records.isEmpty) {
      return [];
    }
    return records.map((e) => TodoItem.fromMap(e)).toList();
  }

  Future<TodoItem?> getTodo(int id) async {
    List<Map> maps = await db.query(AppConstant.tableTodo,
        columns: [AppConstant.columnId, AppConstant.columnDone, AppConstant.columnTitle], where: '${AppConstant.columnId} = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoItem.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(AppConstant.tableTodo, where: '${AppConstant.columnId}= ?', whereArgs: [id]);
  }

  Future<int> update(TodoItem todo) async {
    return await db.update(AppConstant.tableTodo, todo.toMap(), where: '${AppConstant.columnId} = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
