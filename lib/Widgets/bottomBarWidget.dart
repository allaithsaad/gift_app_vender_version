import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '/Controller/botton_bar_controller.dart';

Widget bottomNavigationBar() {
  return GetBuilder<ButtonBarController>(
    init: ButtonBarController(),
    builder: (controller) => BottomNavyBar(
      selectedIndex: controller.navigatorValue,
      onItemSelected: (index) => controller.changeSelectedValue(index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text('الرئيسيه'),
          activeColor: Colors.red,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text('الطلبات'),
            activeColor: Colors.purpleAccent),
        BottomNavyBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text('الإشعارات'),
            activeColor: Colors.blue),
        BottomNavyBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('المستخدم'),
            activeColor: Colors.red),
      ],
    ),
  );
}
