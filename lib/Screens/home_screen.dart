import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/ExtrasProduct_controller.dart';
import 'package:storeapp/Controller/LoginController.dart';
import 'package:storeapp/Controller/Network_Type.dart';
import 'package:storeapp/Screens/LoginScreen.dart';
import 'Store_Screen.dart';
import 'addExtrasProduct.dart';
import 'addProduct.dart';
import 'chooseEditProduct.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.find();
  final NetworkConnecationType networkConnecationType = Get.find();
  final extrasProductcontroller = Get.find<ExtrasProductcontroller>();
  @override
  void initState() {
    extrasProductcontroller.getExtrasProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: loginController
            .createOpenBox()
            .then((value) => loginController.getStoreName()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return LoginScreen();
            } else {
              return Scaffold(
                backgroundColor: Colors.grey[300],
                appBar: AppBar(
                  title: Text(
                    loginController.storeName.value,
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
                          networkConnecationType.connectionType == 0
                              ? Get.snackbar('', 'لايوجد اتصال بالإنترنت .')
                              : Get.to(() => StoreScreen());
                        }),
                        addNewProduct(
                          () {
                            networkConnecationType.connectionType == 0
                                ? Get.snackbar('', 'لايوجد اتصال بالإنترنت .')
                                : Get.to(() => AddProduct());
                          },
                        ),
                        addExtrasProduct(
                          () {
                            networkConnecationType.connectionType == 0
                                ? Get.snackbar('', 'لايوجد اتصال بالإنترنت .')
                                : Get.to(() => AddExtrasProduct());
                          },
                        ),
                        editProduct(() {
                          networkConnecationType.connectionType == 0
                              ? Get.snackbar('', 'لايوجد اتصال بالإنترنت .')
                              : Get.to(() => ChooseEditProduct());
                        }),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
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

  Widget addExtrasProduct(Function? onTap()) {
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
              'إضافت المنتجات الإضافية ',
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
                        imageUrl: loginController.storeImageUrl.value != ''
                            ? loginController.storeImageUrl.value
                            : "https://images.pexels.com/photos/844297/pexels-photo-844297.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",

                        // ,
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
                        errorWidget: (context, url, error) =>
                            Image(image: AssetImage('asset/images/3.png')),
                      ),
                    ),
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
