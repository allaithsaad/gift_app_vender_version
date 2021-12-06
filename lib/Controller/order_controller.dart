import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/Models/orderModel.dart';

class OrderController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  static List<OrderModel> get orderList => _orderlist;
  static List<OrderModel> _orderlist = [];
  static List<OrderModel> get newOrder => _newOrder;
  static List<OrderModel> _newOrder = [];
  static List<OrderModel> get completedOrder => _completedOrder;
  static List<OrderModel> _completedOrder = [];
  static List<OrderModel> get canceledOrder => _canceledOrder;
  static List<OrderModel> _canceledOrder = [];

  OrderController() {
    getOrders();
  }

  getOrders() async {
    _loading.value = true;
    _orderlist.clear();
    _canceledOrder.clear();
    _completedOrder.clear();
    _newOrder.clear();
    await FirebaseFirestore.instance
        .collection("Orders")
        .where('userId')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _orderlist.add(OrderModel.fromJson(element.data()));
        print('ssssssssssssssssssssssssssssss');
      });
      _loading.value = false;
      _newOrder =
          _orderlist.where((_orderlist) => _orderlist.orderState == 1).toList();
      _completedOrder =
          _orderlist.where((_orderlist) => _orderlist.orderState == 2).toList();
      _canceledOrder =
          _orderlist.where((_orderlist) => _orderlist.orderState == 3).toList();

      update();
    });
  }
}
