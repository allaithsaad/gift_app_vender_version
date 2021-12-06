import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/LoginController.dart';
import 'Controller/NotificationController.dart';
import 'Controller/ProductController.dart';
import 'Controller/botton_bar_controller.dart';
import 'Controller/order_controller.dart';
import 'Screens/ControlScreen.dart';
import 'Screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        fontFamily: "Questv1",
        primarySwatch: Colors.purple,
      ),
      initialBinding: BindingsBuilder(() => {
            Get.put(ButtonBarController()),
            Get.put(LoginController()),
            Get.put(NotificationController()),
            Get.put(ProductController()),
            Get.put(OrderController()),
          }),
      home: FirebaseAuth.instance.currentUser != null
          ? ControlScreen()
          : LoginScreen(),
    );
  }
}
