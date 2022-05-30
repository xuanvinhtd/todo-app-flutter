import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToDoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToDoAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(55.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
