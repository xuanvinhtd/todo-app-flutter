import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/data/app/bottom_bar.dart';
import 'package:getx_todo/src/ui/page/completion/completion_page.dart';
import 'package:getx_todo/src/ui/page/home/home_page.dart';
import 'package:getx_todo/src/ui/page/in_completion/in_completion_page.dart';

class TabbarController extends GetxController {
  static TabbarController get to => Get.find();

  final currentTab = BottomBar.home.obs;
  int get currentIndex => BottomBar.values.indexOf(currentTab.value);
  Widget get currentPage => pages[currentIndex];

  List<Widget> pages = [
    const HomePage(),
    const CompletionPage(),
    const InCompletionPage(),
  ];

  void onChange(int index) {
    currentTab.value = BottomBar.values[index];
  }

  IconData getTabIcon(BottomBar tab) {
    switch (tab) {
      case BottomBar.home:
        return Icons.home_outlined;
      case BottomBar.completion:
        return Icons.task_outlined;
      default:
        return Icons.pending_actions;
    }
  }

  String getTabTitle(BottomBar tab) {
    switch (tab) {
      case BottomBar.home:
        return 'home_title'.tr;
      case BottomBar.completion:
        return 'complete_title'.tr;
      default:
        return 'in_complete_title'.tr;
    }
  }
}
