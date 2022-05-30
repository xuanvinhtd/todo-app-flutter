import 'package:getx_todo/src/app/config/app_constant.dart';

class TodoItem {
  TodoItem({this.id, required this.title, this.isComplete = false});
  int? id;
  String title;
  bool isComplete;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{AppConstant.columnTitle: title, AppConstant.columnDone: isComplete == true ? 1 : 0};
    if (id != null) {
      map[AppConstant.columnId] = id;
    }
    return map;
  }

  factory TodoItem.fromMap(Map<dynamic, dynamic> map) {
    return TodoItem(id: map[AppConstant.columnId], title: map[AppConstant.columnTitle], isComplete: map[AppConstant.columnDone] == 1);
  }
}
