import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:storeapp/Models/NotificationModel.dart';

class NotificationController extends GetxController {
  static List<NotificationModel> get notificationList => _notificationList;
  static List<NotificationModel> _notificationList = [];
  bool getNotificationsIsloading = false;
  getNotifications() {
    getNotificationsIsloading = true;
    _notificationList.clear();
    try {
      FirebaseFirestore.instance
          .collection("Store")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Notification")
          .orderBy("date")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _notificationList.add(NotificationModel.fromJson(element.data()));
        });
        update();
        getNotificationsIsloading = false;
      });
    } catch (error) {
      getNotificationsIsloading = false;
      print(error);
    }
  }
}
