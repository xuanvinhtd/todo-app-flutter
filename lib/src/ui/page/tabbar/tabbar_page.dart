import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/data/app/bottom_bar.dart';
import 'package:getx_todo/src/ui/page/tabbar/tabbar_controller.dart';

class TabbarPage extends GetView<TabbarController> {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.currentPage,
          bottomNavigationBar: BottomNavigationBar(
              elevation: 40,
              currentIndex: controller.currentIndex,
              onTap: controller.onChange,
              showUnselectedLabels: true,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).primaryColor,
              selectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
              unselectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp),
              backgroundColor: Theme.of(context).backgroundColor,
              items: BottomBar.values.map((tab) {
                return BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      controller.getTabIcon(tab),
                      color: controller.currentTab.value == tab ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
                    ),
                  ),
                  label: controller.getTabTitle(tab),
                );
              }).toList()),
        ));
  }
}
