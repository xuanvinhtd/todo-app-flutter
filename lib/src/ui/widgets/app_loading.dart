import 'package:flutter/material.dart';

class AppCircleProgress extends StatelessWidget {
  const AppCircleProgress({Key? key, this.strokeWidth = 5.0, this.height = 40, this.width = 40, this.color}) : super(key: key);
  final double strokeWidth;
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
      ),
    ));
  }
}
