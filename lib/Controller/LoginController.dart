import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Models/store_model.dart';
import '../constant.dart';
import '/Screens/ControlScreen.dart';

class LoginController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  StoreModel get storeSPData => _storeSPData;
  late StoreModel _storeSPData;
  loginRequest(
      String phoneNumber, String password, BuildContext context) async {
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
        .where('phoneNumber', isEqualTo: "+967$phoneNumber")
        .where('password', isEqualTo: password)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.first.data();
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: value.docs.first.get('email'),
                  password: value.docs.first.get("emailPassword"))
              .then((value) async {
            if (_auth.currentUser!.uid.isNotEmpty) {
              await setSPUser(_auth.currentUser!.uid).then((value) async {
                await getCurrentUserSPData().then((value) {
                  print(_auth.currentUser!.uid);
                  Get.offAll(ControlScreen());
                  Loader.hide();
                });
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

  Future<void> getCurrentUserSPData() async {
    StoreModel? _storeData = await getSPUser;

    if (_storeData == null) {
    } else {
      _storeSPData = _storeData;
    }

    update();
  }

  Future<void> setSPUser(String id) async {
    print(id);
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user.isBlank!) {
        print('User is currently signed out!');
      } else {
        print(id);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await FirebaseFirestore.instance
            .collection('Store')
            .doc(id)
            .get()
            .then((value) async {
          await pref.setString(CACHED_USER_DATA,
              json.encode(StoreModel.fromJson(value.data()!)));
        });
        print('User is signed in!');
      }
    });
  }

  Future<DocumentSnapshot<Map<dynamic, dynamic>>> _getCurrentUser(
      String id) async {
    return await FirebaseFirestore.instance.collection('Store').doc(id).get();
  }

  Future<StoreModel?> get getSPUser async {
    try {
      StoreModel? userModel;
      userModel = await _getUserData();
      return userModel;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<StoreModel> _getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CACHED_USER_DATA);
    return StoreModel.fromJson(json.decode(value!));
  }

  void deleteSPUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Loader.hide();
    super.dispose();
  }
}
