import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_todo/src/app/config/app_color.dart';

ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    backgroundColor: AppColor.white,
    appBarTheme: const AppBarTheme(color: AppColor.white),
    errorColor: AppColor.red,
    splashColor: Colors.transparent,
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w800,
        color: AppColor.primary,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ));

// TODO: Will setup dart mode later
ThemeData dartThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    backgroundColor: AppColor.white,
    appBarTheme: const AppBarTheme(color: AppColor.white),
    errorColor: AppColor.red,
    splashColor: Colors.transparent,
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w800,
        color: AppColor.primary,
      ),
      labelSmall: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        decoration: TextDecoration.underline,
      ),
    ));
