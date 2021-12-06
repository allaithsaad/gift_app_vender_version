import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Screens/Orders_Screen.dart';
import '/Screens/notification_screen.dart';
import '../../screens/User_info_screen.dart';

import '../../screens/home_screen.dart';
import 'LoginController.dart';

class ButtonBarController extends GetxController {
  inStart2() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        final local = Get.find<LoginController>();
        await local
            .setSPUser(user.uid)
            .then((value) => local.getCurrentUserSPData());
        print('User is signed in!');
      }
    });
  }

  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = HomeScreen();

  void changeSelectedValue(int selectedValue) {
    inStart2();
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = HomeScreen();
          break;
        }
      case 1:
        {
          currentScreen = OrdersScreen();
          break;
        }
      case 2:
        {
          currentScreen = NotificationScreen();
          break;
        }
      case 3:
        {
          currentScreen = UserinfoScreen();
          break;
        }
    }
    update();
  }
}
