import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_todo/src/app/config/app_color.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.id,
    this.title = '',
    this.isComplete = false,
    this.onTapItem,
    this.onCheck,
    this.onDismissed,
  }) : super(key: key);
  final int id;
  final String title;
  final bool isComplete;
  final Function? onTapItem;
  final Function? onCheck;
  final Function? onDismissed;

  Color _getColor(Set<MaterialState> states) {
    return AppColor.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      onDismissed: (direction) {
        onDismissed?.call();
      },
      background: Container(color: AppColor.red),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: ListTile(
              trailing: Checkbox(
                key: Key(id.toString() + "checkbox"),
                checkColor: Theme.of(context).backgroundColor,
                fillColor: MaterialStateProperty.resolveWith(_getColor),
                value: isComplete,
                shape: const CircleBorder(),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool? value) {
                  onCheck?.call();
                },
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: isComplete ? TextDecoration.lineThrough : TextDecoration.none),
              ),
              onTap: () {
                onTapItem?.call();
              }),
        ),
      ),
    );
  }
}
