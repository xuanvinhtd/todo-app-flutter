import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';
import 'package:getx_todo/src/ui/page/completion/completion_controller.dart';
import 'package:getx_todo/src/ui/widgets/app_bar.dart';
import 'package:getx_todo/src/ui/widgets/app_dialog.dart';
import 'package:getx_todo/src/ui/widgets/empty_msg.dart';
import 'package:getx_todo/src/ui/widgets/snack_bar.dart';
import 'package:getx_todo/src/ui/widgets/todo_item_widget.dart';

class CompletionPage extends GetView<CompletionController> {
  const CompletionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ToDoAppBar(
          title: 'all_complete'.tr,
        ),
        backgroundColor: AppColor.greyBackground,
        body: Obx(
          () => controller.todoCompleteds.isEmpty
              ? EmptyMsg(msg: 'task_complete_empty'.tr)
              : ListView.builder(
                  padding: EdgeInsets.all(8.w),
                  itemCount: controller.todoCompleteds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todoCompleteds[index];
                    return TodoItemWidget(
                      key: Key('todoCell${item.id}'),
                      id: item.id,
                      title: item.title,
                      isComplete: item.isComplete,
                      onTapItem: () => {
                        showAppDialog(
                          context,
                          isUpdate: true,
                          onUpdate: (value) => {
                            controller.homeController.updateTodoItem(item, title: value, onComplete: (success, msg) => {showMessage(msg, success)})
                          },
                          item: item,
                        )
                      },
                      onCheck: () => {controller.homeController.updateTodoItem(item, isComplete: !item.isComplete)},
                      onDismissed: () => {
                        controller.homeController.deleteTodoItem(item, onComplete: (success, msg) => {showMessage(msg, success)})
                      },
                    );
                  }),
        ));
  }
}
