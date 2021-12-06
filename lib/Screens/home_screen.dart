import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/LoginController.dart';
import '/Controller/ProductController.dart';
import '../constant.dart';
import 'Store_Screen.dart';
import 'addProduct.dart';
import 'chooseEditProduct.dart';
import 'editeproductScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          loginController.storeSPData.name,
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showMyStore(() {
                Get.to(
                  () => StoreScreen(),
                );
              }),
              addNewProduct(() {
                Get.to(AddProduct());
              }),
              editProduct(() {
                Get.to(ChooseEditProduct());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewProduct(Function? onTap()) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'إضافة منتج جديد',
              style: TextStyle(fontSize: 20, color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }

  Widget editProduct(Function? onTap()) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'تعديل  منتج ',
              style: TextStyle(fontSize: 20, color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }

  Widget showMyStore(Function? onTap()) {
    final LoginController loginController = Get.find();
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        width: Get.width * 0.95,
                        imageUrl: loginController.storeSPData.shopBackground,
                        height: 200,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: SpinKitCircle(
                                size: 50,
                                color: Colors.purple,
                              )),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white.withOpacity(0.5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Store name', //LoginController.storeSPData.name!
                              style:
                                  TextStyle(fontSize: 30, color: Colors.purple),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'عرض متجري الآلكتروني ',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
