import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/botton_bar_controller.dart';
import '/Widgets/bottomBarWidget.dart';

class ControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonBarController>(
      init: Get.find<ButtonBarController>(),
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}
