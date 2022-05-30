import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/ui/page/splash/splash_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 90.w,
              ),
              SizedBox(
                height: 30.w,
              ),
              Text(
                controller.appTitle().tr,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 45.h),
            child: Text("email".tr,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      decoration: TextDecoration.underline,
                    )),
          ),
        ),
      ]),
    );
  }
}
