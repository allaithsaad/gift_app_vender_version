import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  StoreModel({
    required this.name,
    required this.shopBackground,
    required this.accountingId,
    required this.phoneNumber,
    required this.storeId,
    required this.notes,
    required this.nameE,
    required this.shortId,
    required this.status,
    required this.storeLocation,
  });

  StoreModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          shopBackground: json['shopBackground']! as String,
          accountingId: json['accountingId']! as String,
          phoneNumber: json['phoneNumber']! as String,
          storeId: json['storeId']! as String,
          notes: json['notes']! as String,
          nameE: json['nameE']! as String,
          shortId: json['shortId']! as String,
          status: json['status']! as bool,
          storeLocation: json['storeLocation']! as GeoPoint,
        );

  final String name;
  final String shopBackground;
  final String accountingId;
  final String phoneNumber;
  final String storeId;
  final String notes;
  final String nameE;
  final String shortId;
  final bool status;
  final GeoPoint storeLocation;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'shopBackground': shopBackground,
      'accountingId': accountingId,
      'phoneNumber': phoneNumber,
      'storeId': storeId,
      'notes': notes,
      'nameE': nameE,
      'shortId': shortId,
      'status': status,
      'storeLocation': storeLocation,
    };
  }
}
