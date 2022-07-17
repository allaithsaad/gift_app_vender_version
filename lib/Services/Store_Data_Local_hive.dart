// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:storeapp/Models/storeModel.dart';

// class HiveStorge {
//   static Future<void> saveUser(StoreModel user) async {
//     var box = await Hive.openBox('user');
//     box.put('user', user);
//     box.close();
//   }

//   static Future<StoreModel?> getUser() async {
//     var box = await Hive.openBox<StoreModel>('user');
//     StoreModel? user = box.get('user');
//     box.close();
//     return user;
//   }
// }
