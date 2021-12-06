import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  StoreModel({
    required this.name,
    required this.shopBackground,
    required this.accountingId,
    required this.phoneNumer,
    required this.storeId,
    required this.notes,
    required this.states,
    required this.storeLocation,
  });

  StoreModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          shopBackground: json['shopBackground']! as String,
          accountingId: json['accountingId']! as String,
          phoneNumer: json['phoneNumer']! as String,
          storeId: json['storeId']! as String,
          notes: json['notes']! as String,
          states: json['states']! as bool,
          storeLocation: json['storeLocation']! as GeoPoint,
        );

  final String name;
  final String shopBackground;
  final String accountingId;
  final String phoneNumer;
  final String storeId;
  final String notes;
  final bool states;
  final GeoPoint storeLocation;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'shopBackground': shopBackground,
      'accountingId': accountingId,
      'phoneNumer': phoneNumer,
      'storeId': storeId,
      'notes': notes,
      'states': states,
      'storeLocation': storeLocation,
    };
  }
}
