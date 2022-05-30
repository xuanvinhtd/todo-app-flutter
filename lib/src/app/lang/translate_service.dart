import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';
import 'vi_vn.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('vi', 'VN');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_us,
        'vi_VN': vi_vn,
      };
}
