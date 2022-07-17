import 'dart:developer';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/ExtrasProduct_controller.dart';
import 'package:storeapp/Controller/LoginController.dart';
import 'package:storeapp/Controller/Network_Type.dart';

import 'package:storeapp/Screens/addExtrasProduct.dart';
import 'package:storeapp/Widgets/iput_fileds.dart';
import '/Controller/ProductController.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'ControlScreen.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> extraProducts = [];
  @override
  void initState() {
    extraProducts.clear();
    // TODO: implement initState

    super.initState();
  }

  var selctedcategory;
  String selctedcat = '';
  int categoryId = 0;
  var productId;
  final LoginController loginController = Get.find();
  final productRef = Get.find<ProductController>();
  final extrasProductcontroller = Get.find<ExtrasProductcontroller>();
  final networkConnecationType = Get.find<NetworkConnecationType>();
  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

  // final categoryId = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<String> imageUrls = [];

  String? imageUrl1;
  File? imageFile1;
  String? imageUrl2;
  File? imageFile2;
  String? imageUrl3;
  File? imageFile3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('اضافه منتج جديد'),
        actions: [
          TextButton(
              onPressed: () async {
                if (networkConnecationType.connectionType == 0) {
                  Get.snackbar("خطاء", "لا يوجد اتصال بالانترنت .  ");
                } else {
                  if (name.text.length < 5) {
                    Get.snackbar("خطاء", "يجب انا يكون الاسم أكبر من 5 حروف ");
                  } else {
                    if (price.text.length < 2) {
                      Get.snackbar("خطاء", "السعر قليل جداً  ");
                    } else {
                      if (description.text.length < 10) {
                        Get.snackbar(
                            "خطاء ", "يجب أن يكون الوصف أكبر من 10 حروف ");
                      } else {
                        if (quantity.text.length == 0) {
                          Get.snackbar(
                              "خطاء ", "الكمية يجب أن تكون أكبر من 0 . ");
                        } else {
                          if (selctedcat.length < 2) {
                            Get.snackbar(
                                "خطاء ", "يجب إختيار مناسبة المنتج    . ");
                          } else {
                            if (imageFile1 != null) {
                              try {
                                Loader.show(context,
                                    isSafeAreaOverlay: false,
                                    isAppbarOverlay: true,
                                    isBottomBarOverlay: false,
                                    progressIndicator:
                                        CircularProgressIndicator(),
                                    themeData: Theme.of(context)
                                        .copyWith(accentColor: Colors.black38),
                                    overlayColor: Color(0x99E8EAF6));

                                await FirebaseFirestore.instance
                                    .collection('productesNew1')
                                    .where('storeId',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .get()
                                    .then((valuex) async {
                                  setState(() {
                                    productId = int.parse(loginController
                                            .shortId.value
                                            .toString()) +
                                        valuex.docs.length +
                                        1;
                                  });

                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Category')
                                        .where('name', isEqualTo: selctedcat)
                                        .get()
                                        .then((value) async {
                                      if (value.docs.isNotEmpty) {
                                        setState(() {
                                          categoryId = value.docs.first
                                              .get('categoryId');
                                        });
                                        await _uploadFile1(imageFile1!.path)
                                            .then((value) async {
                                          if (imageFile2 != null)
                                            await _uploadFile2(
                                                imageFile2!.path);

                                          if (imageFile3 != null)
                                            await _uploadFile3(
                                                imageFile3!.path);

                                          if (imageUrl1 != null) {
                                            DocumentReference docRef =
                                                FirebaseFirestore.instance
                                                    .collection('productesNew1')
                                                    .doc();
                                            docRef.set({
                                              "fProductId": docRef.id,
                                              "storeId": FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              "name": name.text,
                                              "description": description.text,
                                              "price": int.parse(price.text),
                                              "productId": productId,
                                              "categoryId": categoryId,
                                              "quantity":
                                                  int.parse(quantity.text),
                                              "extraProducts": extraProducts,
                                              "productStates": 0,
                                              "image": imageUrls,
                                              "discount": 0,
                                              "popular": 0,
                                              "verified": false,
                                            }).then((value) {
                                              Loader.hide();
                                              Get.offAll(ControlScreen());
                                              productRef.getProduct();
                                              Get.snackbar("إشعار",
                                                  "تم إضافة المنتج بنجاح ");
                                            });
                                          }
                                        }).onError((error, stackTrace) {
                                          Loader.hide();
                                          print(error.toString());
                                        });
                                      }
                                    });
                                  } catch (error) {
                                    Loader.hide();
                                    print(error.toString());
                                  }
                                });
                              } catch (e) {
                                Loader.hide();
                                log(e.toString());
                              }
                            } else {
                              Get.snackbar(
                                  "title", "الصورة الأمامية إجبارية   ");
                            }
                          }
                        }
                      }
                    }
                  }
                }
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('حفظ')
                    ],
                  ),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _selectPhoto1(),
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: imageFile1 != null
                              ? Stack(children: [
                                  Image.file(
                                    imageFile1!,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Badge(
                                      toAnimate: true,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(0),
                                          topLeft: Radius.circular(5)),
                                      badgeContent: Icon(Icons.edit),
                                    ),
                                  )
                                ])
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 40,
                                    ),
                                    Text(
                                      imageUrl1 == null
                                          ? 'اضغط لاضافه صوره من الأمام'
                                          : 'اضغط لاتعديل صوره المنتج',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _selectPhoto2(),
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: imageFile2 != null
                              ? Stack(children: [
                                  Image.file(
                                    imageFile2!,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Badge(
                                      toAnimate: true,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(0),
                                          topLeft: Radius.circular(5)),
                                      badgeContent: Icon(Icons.edit),
                                    ),
                                  )
                                ])
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 40,
                                    ),
                                    Text(
                                      imageUrl2 == null
                                          ? 'اضغط لاضافه صوره من اليمين'
                                          : 'اضغط لاتعديل صوره المنتج',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _selectPhoto3(),
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: imageFile3 != null
                              ? Stack(children: [
                                  Image.file(
                                    imageFile3!,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Badge(
                                      toAnimate: true,
                                      shape: BadgeShape.square,
                                      badgeColor: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(0),
                                          topLeft: Radius.circular(5)),
                                      badgeContent: Icon(Icons.edit),
                                    ),
                                  )
                                ])
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 40,
                                    ),
                                    Text(
                                      imageUrl3 == null
                                          ? 'اضغط لاضافه صوره من اليسار'
                                          : 'اضغط لاتعديل صوره المنتج',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputFileds('اسم المنتج', name, 1, TextInputAction.next, false,
                  TextInputType.name),
              InputFileds('الوصف  ', description, 4, TextInputAction.none,
                  false, TextInputType.multiline),
              textFielNumber(price, 'السعر', TextInputAction.next),
              textFielNumber(quantity, 'الكميه', TextInputAction.done),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 4)),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Category")
                        .orderBy('categoryId')
                        .where('categoryStatues', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('جاري التحميل ');
                      } else if (snapshot.error == true) {
                        return Text("هناك خطاء بالاتصال معى قاعدة البينات ");
                      }
                      if (snapshot.hasData) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text('إختار مناسبة المنتج '),
                            isExpanded: true,
                            value: selctedcategory,
                            iconSize: 35,
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            items: snapshot.data!.docs.map((value) {
                              return DropdownMenuItem(
                                value: value.get('name'),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text('${value.get('name')}'),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(
                                () {
                                  selctedcat = v.toString();
                                  selctedcategory = v;
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Text('جاري التحميل ');
                      }
                    },
                  ),
                ),
              ),
              Container(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'يرجاء تحديد الإضافات الخاصة بهذا المنتج ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GetBuilder<ExtrasProductcontroller>(
                          init: Get.find<ExtrasProductcontroller>(),
                          builder: (controller) => controller
                                  .extrasProducIsLoding
                              ? SpinKitCircle(
                                  size: 35,
                                  color: Colors.black,
                                )
                              : controller.extarsModel.length == 0
                                  ? Text('لايوجد إضافات ')
                                  : ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: controller.extarsModel.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CheckboxListTile(
                                              title: Text(controller
                                                  .extarsModel[index].name!),
                                              secondary: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .extarsModel[index]
                                                        .image!,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child: SpinKitCubeGrid(
                                                        color:
                                                            Colors.purpleAccent,
                                                        duration: Duration(
                                                            seconds: 2),
                                                        size: 20,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              activeColor: Colors.green,
                                              value: controller
                                                  .extarsValueModel[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  controller.extarsValueModel[
                                                      index] = value!;

                                                  if (value) {
                                                    extraProducts.add(controller
                                                        .extarsModel[index]
                                                        .fProductId!);
                                                  } else {
                                                    extraProducts.remove(
                                                        controller
                                                            .extarsModel[index]
                                                            .fProductId!);
                                                  }
                                                });
                                              },
                                            ),
                                            Divider()
                                          ],
                                        );
                                      },
                                    ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width,
                          child: IconButton(
                            onPressed: () {
                              Get.to(AddExtrasProduct());
                            },
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('إضفة جديدة'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFielNumber(TextEditingController quantity, String title,
      TextInputAction textInputAction) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          textInputAction: textInputAction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: quantity,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: title,
          ),
        ),
      ),
    );
  }

//<<<------------------------------ frist Upload ----------------------->>>
  Future _selectPhoto1() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage1(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage1(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage1(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (file == null) {
      return;
    }

    file = await compressImagePath1(file.path, 35);

    setState(() {
      imageFile1 = file;
    });
  }

  Future<File?> compressImagePath1(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '1${DateTime.now().toIso8601String()}1${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile1(String path) async {
    print("*****************************************************");
    print(loginController.storeNameE.value);

    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('stores')
        .child(loginController.storeNameE.value)
        .child('products')
        .child(productId.toString())
        .child('${p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrls.add(fileUrl);
      imageUrl1 = fileUrl;
    });
  }

  //<<<---------- sceand upload --------------->>>
  Future _selectPhoto2() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage2(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage2(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage2(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (file == null) {
      return;
    }

    file = await compressImagePath2(file.path, 35);

    setState(() {
      imageFile2 = file;
    });
  }

  Future<File?> compressImagePath2(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '2${DateTime.now().toIso8601String()}2${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile2(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('stores')
        .child(loginController.storeNameE.value)
        .child('products')
        .child(productId.toString())
        .child('${DateTime.now()}${p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrls.add(fileUrl);
      imageUrl2 = fileUrl;
    });
  }

  //<<<---------- thired  upload --------------->>>
  Future _selectPhoto3() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage3(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage3(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage3(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (file == null) {
      return;
    }

    file = await compressImagePath2(file.path, 35);

    setState(() {
      imageFile3 = file;
    });
  }

  Future<File?> compressImagePath3(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '3${DateTime.now().toIso8601String()}3${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile3(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('stores')
        .child(loginController.storeNameE.value)
        .child('products')
        .child(productId.toString())
        .child('${p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrls.add(fileUrl);
      imageUrl3 = fileUrl;
    });
  }
}
