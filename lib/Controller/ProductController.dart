import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Models/productModel.dart';
import '/Services/product_serivce.dart';

class ProductController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ProductController() {
    getProduct();
  }

  static List<ProductModel> get productModel => _productModel.toSet().toList();
  static List<ProductModel> _productModel = [];
  static List<ProductModel> get acceptedModel =>
      _acceptedModel.toSet().toList();
  static List<ProductModel> _acceptedModel = [];
  static List<ProductModel> get offerModel => _offerModel.toSet().toList();
  static List<ProductModel> _offerModel = [];
  static List<ProductModel> get onHoldModel => _onHoldModel.toSet().toList();
  static List<ProductModel> _onHoldModel = [];
  static List<ProductModel> get unAcceptedModel =>
      _unAcceptedModel.toSet().toList();
  static List<ProductModel> _unAcceptedModel = [];

  getProduct() async {
    _productModel.clear();
    _unAcceptedModel.clear();
    _onHoldModel.clear();
    _offerModel.clear();
    _acceptedModel.clear();
    _loading.value = true;
    await ProductService().getProduct().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModel.add(
          ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>),
        );
      }

      _loading.value = false;
      _acceptedModel = _productModel
          .where((_productModel) => _productModel.productStates == 1)
          .toSet()
          .toList();
      _offerModel = _productModel
          .where((_productModel) => _productModel.productStates == 2)
          .toSet()
          .toList();
      _onHoldModel = _productModel
          .where((_productModel) => _productModel.productStates == 3)
          .toSet()
          .toList();
      _unAcceptedModel = _productModel
          .where((_productModel) => _productModel.productStates == 4)
          .toSet()
          .toList();
      print('ddddddddddddddddddddd');
      update();
    });
  }
}
