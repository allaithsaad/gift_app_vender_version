import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Screens/ControlScreen.dart';

class LoginController extends GetxController {
  late Box box1;
  var storeNameE = ''.obs;
  var storeName = ''.obs;
  var storeImageUrl = ''.obs;
  var shortId = ''.obs;
  var phoneNumber = '770000002'.obs;
  var password = '000000'.obs;

  @override
  void onInit() {
    createOpenBox();

    super.onInit();
  }

  Future<void> createOpenBox() async {
    box1 = await Hive.openBox('logindata');
  }

  void storeTheStoreDate(
      String name, String nameE, String shopBackground, String shortId) {
    box1.put('name', name);
    box1.put('nameE', nameE);
    box1.put('shopBackground', shopBackground);
    box1.put('shortId', shortId);
    log(name);
    log(nameE);
    log(shopBackground);
    log(shortId);
  }

  void getStoreName() async {
    if (box1.isOpen) {
      if (box1.get('name') != null) {
        storeName.value = box1.get('name');
        update();
      }
      if (box1.get('nameE') != null) {
        storeNameE.value = box1.get('nameE');
        update();
      }
      if (box1.get('shopBackground') != null) {
        storeImageUrl.value = box1.get('shopBackground');
        update();
      }
      if (box1.get('shortId') != null) {
        shortId.value = box1.get('shortId');
        update();
      }
    } else {
      await createOpenBox();
      await Hive.openBox('logindata');
      if (box1.get('name') != null) {
        storeName.value = box1.get('name');
        update();
      }
      if (box1.get('nameE') != null) {
        storeNameE.value = box1.get('nameE');
        update();
      }
      if (box1.get('shopBackground') != null) {
        storeImageUrl.value = box1.get('shopBackground');
        update();
      }
      if (box1.get('shortId') != null) {
        shortId.value = box1.get('shortId');
        update();
      }
    }
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  loginRequest(BuildContext context) async {
    Loader.show(context,
        isSafeAreaOverlay: false,
        isAppbarOverlay: true,
        isBottomBarOverlay: false,
        progressIndicator: SpinKitDancingSquare(
          color: Colors.red,
          size: 100,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.black38),
        overlayColor: Color(0x99E8EAF6));
    await _firestore
        .collection('Store')
        .where('phoneNumber', isEqualTo: "+967${phoneNumber.value}")
        .where('password', isEqualTo: password.value)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.first.data();
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: value.docs.first.data()['email'],
                  password: value.docs.first.data()['emailPassword'])
              .then((value) async {
            if (_auth.currentUser!.uid.isNotEmpty) {
              String id = _auth.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection("Store")
                  .doc(id)
                  .get()
                  .then((value) async {
                if (value.exists) {
                  /** */
                  storeTheStoreDate(value.get("name"), value.get("nameE"),
                      value.get("shopBackground"), value.get("shortId"));
                  getStoreName();
                  print("---------------------------------------");
                  print(value.data());
                  Loader.hide();
                  Get.offAll(ControlScreen());
                }
              });
            }
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
          Loader.hide();
        }
      } else {
        print(password);
        print("+967$phoneNumber");
        Get.snackbar("error",
            "  لا تمتلك صلاحية تسجيل دخول تأكد من أن الرقم و كلمة السر صحيحة  ");
        Loader.hide();
      }
    }).catchError((onError) {
      print(onError);
      Loader.hide();
    });
  }

  @override
  void dispose() {
    box1.close();

    // TODO: implement dispose

    super.dispose();
  }
}
