import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/Screens/category_screen.dart';
import 'Controller/ExtrasProduct_controller.dart';
import 'Controller/LoginController.dart';
import 'Controller/Network_Type.dart';
import 'Controller/NotificationController.dart';
import 'Controller/ProductController.dart';
import 'Controller/botton_bar_controller.dart';
import 'Controller/categoryController.dart';
import 'Controller/order_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Screens/ControlScreen.dart';
import 'Screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Hive.registerAdapter(StoreModelAdapter());
  await Hive.initFlutter();
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
            Get.put(CategoryController()),
            Get.put(LoginController()),
            Get.put(NotificationController()),
            Get.put(NetworkConnecationType()),
            Get.put(ProductController()),
            Get.put(ExtrasProductcontroller()),
            Get.put(OrderController()),
          }),
      home: FirebaseAuth.instance.currentUser != null
          ? ControlScreen()
          : LoginScreen(),
    );
  }
}
