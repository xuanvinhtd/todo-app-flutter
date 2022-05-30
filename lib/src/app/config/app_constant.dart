abstract class AppConstant {
  static const int TIME_OUT = 20000;
  static const String CONTENT_TYPE = 'application/json; charset=UTF-8';
  static const String MOBILE = 'Mobile';

  static const String DEV_APP_NAME = '[DEV] Getx TODO';
  static const String STG_APP_NAME = '[STG] Getx TODO';
  static const String PRO_APP_NAME = '[PRO] Getx TODO';

// URL
  static const String DEV_BASE_URL = 'https://jsonplaceholder.typicode.com/';
  static const String STG_BASE_URL = 'https://jsonplaceholder.typicode.com/';
  static const String PRO_BASE_URL = 'https://jsonplaceholder.typicode.com/';

  // Api
  static const String TODO = 'todo';

// STORAGE
  static const String TODO_STORAGE = 'todos_storage';

//DB
  static const String dbName = 'todo.db';
  static const String tableTodo = 'todo';
  static const String columnId = '_id';
  static const String columnTitle = 'title';
  static const String columnDone = 'done';
}
