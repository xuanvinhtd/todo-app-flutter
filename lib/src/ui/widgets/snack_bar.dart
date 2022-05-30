import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';

void showMessage(String message, bool isSuccess) {
  if (message.isEmpty) return;
  if (isSuccess) {
    showSuccessSnackBar(title: 'noty_success'.tr, message: message);
  } else {
    showErrorSnackBar(title: 'noty_error'.tr, message: message);
  }
}

void showErrorSnackBar({String title = "", String message = ""}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: AppColor.red,
    colorText: AppColor.white,
    barBlur: 10.0,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.error, color: AppColor.white),
  );
}

@override
void showSuccessSnackBar({String title = "", String message = ""}) {
  Get.snackbar(
    title,
    message,
    colorText: AppColor.white,
    backgroundColor: AppColor.green,
    barBlur: 10.0,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.check_circle, color: AppColor.white),
  );
}
