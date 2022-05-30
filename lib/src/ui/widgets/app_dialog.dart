import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';
import 'package:getx_todo/src/app/config/app_keys.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';

Future<void> showAppDialog(BuildContext context,
    {TodoItem? item, Function(String)? onUpdate, Function(String)? onCreate, Function? onDismiss, bool isUpdate = false}) async {
  TextEditingController textController = TextEditingController();
  final isUpdate = item != null;
  if (isUpdate) {
    textController.text = item.title;
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        key: AppWidgetKeys.dialog,
        title: Text(
          isUpdate ? 'update_task'.tr : 'create_task'.tr,
          key: AppWidgetKeys.dialogTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
        ),
        content: TextField(
          key: AppWidgetKeys.dialogTextField,
          controller: textController,
          autofocus: false,
          maxLength: 1000,
          maxLines: 5,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: const OutlineInputBorder(),
            hintText: 'task_des'.tr,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColor.red)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(isUpdate ? 'update'.tr : 'create'.tr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).primaryColor)),
            onPressed: () {
              if (isUpdate) {
                onUpdate?.call(textController.text);
              } else {
                onCreate?.call(textController.text);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
