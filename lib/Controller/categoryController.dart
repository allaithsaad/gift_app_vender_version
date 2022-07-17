import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:storeapp/Models/category_model.dart';
import 'package:storeapp/Models/productModel.dart';

class CategoryController extends GetxController {
  CategoryController() {
    getCategoryProducte();
    getCategory();
  }

  final _firebaseFirestore = FirebaseFirestore.instance;
  RxBool isLoadingCategory = false.obs;

  List<CategoryModel> get categorylist => _categorylist;
  List<CategoryModel> _categorylist = [];

//"يـرجـاء الانـتـظـار"
  Future<void> getCategory() async {
    isLoadingCategory.value = true;
    _categorylist.clear();
    try {
      await _firebaseFirestore
          .collection('Category')
          .orderBy("categoryId")
          .get()
          .then((value) {
        log(value.docs.length.toString());
        value.docs.forEach((element) {
          _categorylist.add(CategoryModel.fromJson(element.data()));
          log(element.id);
        });
      });
      isLoadingCategory = false.obs;
    } catch (e) {
      isLoadingCategory = false.obs;
      log(e.toString());
    }
    update();
  }

  List<ProductModel> get categorylistProducte => _categorylistProducte;
  List<ProductModel> _categorylistProducte = [];

  getCategoryProducte() {
    isLoadingCategory.value = true;
    _categorylist.clear();
    try {
      _firebaseFirestore
          .collection('productesNew1')
          .orderBy("categoryId")
          .get()
          .then((value) {
        log(value.docs.length.toString());
        value.docs.forEach((element) {
          _categorylistProducte.add(ProductModel.fromJson(element.data()));
          log(element.id);
        });
      });
      isLoadingCategory = false.obs;
    } catch (e) {
      isLoadingCategory = false.obs;
      log(e.toString());
    }
    update();
  }

  List<ProductModel> get selectedcategoryProducte => _selectedcategoryProducte;
  List<ProductModel> _selectedcategoryProducte = [];

  moveListFromAllToSelectedProducte(int selectedcategoryId) {
    _selectedcategoryProducte.clear();
    for (int i = 0; i < _categorylistProducte.length; i++) {
      _selectedcategoryProducte.addIf(
          _categorylistProducte[i].categoryId == selectedcategoryId,
          _categorylistProducte[i]);
    }
    update();
  }
}
