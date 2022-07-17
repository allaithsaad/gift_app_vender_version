import 'dart:developer';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/ExtrasProduct_controller.dart';
import 'package:storeapp/Controller/LoginController.dart';
import 'package:storeapp/Controller/Network_Type.dart';
import 'package:storeapp/Controller/NotificationController.dart';
import 'package:storeapp/Widgets/iput_fileds.dart';
import '/Controller/ProductController.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'ControlScreen.dart';

class AddExtrasProduct extends StatefulWidget {
  @override
  _AddExtrasProductState createState() => _AddExtrasProductState();
}

class _AddExtrasProductState extends State<AddExtrasProduct> {
  bool multeTimes = false;
  var selctedcategory;
  String selctedcat = '';
  int categoryId = 0;
  final LoginController loginController = Get.find();
  final extrasRef = Get.find<ExtrasProductcontroller>();
  final networkConnecationType = Get.find<NetworkConnecationType>();
  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  var productId;
  // final categoryId = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl1;
  File? imageFile1;
  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    quantity.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('اضافه المنتجات الإضافية'),
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
                        if (imageFile1 != null) {
                          try {
                            Loader.show(context,
                                isSafeAreaOverlay: true,
                                isAppbarOverlay: true,
                                isBottomBarOverlay: true,
                                progressIndicator: CircularProgressIndicator(),
                                themeData: Theme.of(context)
                                    .copyWith(accentColor: Colors.black38),
                                overlayColor: Color(0x99E8EAF6));

                            await FirebaseFirestore.instance
                                .collection('Store')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('Extras')
                                .get()
                                .then((valuex) async {
                              setState(() {
                                productId =
                                    int.parse(loginController.shortId.value) +
                                        valuex.docs.length +
                                        1;
                              });
                              try {
                                await _uploadFile1(imageFile1!.path)
                                    .then((value) async {
                                  if (imageUrl1 != null) {
                                    DocumentReference docRef = FirebaseFirestore
                                        .instance
                                        .collection('Store')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('Extras')
                                        .doc();
                                    docRef.set({
                                      "fProductId": docRef.id,
                                      "storeId": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "name": name.text,
                                      "description": description.text,
                                      "price": int.parse(price.text),
                                      "productId": productId,
                                      "productStates": 0,
                                      "multeTimes": multeTimes,
                                      "uploadingDate": DateTime.now(),
                                      "image": imageUrl1,
                                      "discount": 0,
                                      "popular": 0,
                                      "verified": false,
                                    }).then((value) {
                                      Loader.hide();
                                      Get.back();
                                      extrasRef.getExtrasProduct();
                                      Get.snackbar(
                                          "إشعار", "تم إضافة المنتج بنجاح ");
                                    });
                                  }
                                }).onError((error, stackTrace) {
                                  Loader.hide();
                                  print(error.toString());
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
                          Get.snackbar("title", "الصورة الأمامية إجبارية   ");
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
              Container(
                width: Get.width * 0.5,
                height: Get.height * 0.25,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 40,
                                ),
                                Text(
                                  imageUrl1 == null
                                      ? 'اضغط لاضافه صوره '
                                      : 'اضغط لاتعديل صوره المنتج',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              InputFileds('اسم المنتج', name, 1, TextInputAction.next, false,
                  TextInputType.name),
              InputFileds('الوصف  ', description, 4, TextInputAction.none,
                  false, TextInputType.multiline),
              textFielNumber(price, 'السعر', TextInputAction.next),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  width: Get.width * 0.90,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3)),
                  child: CheckboxListTile(
                    title: Text('هل يمكن إضافة المنتج أكثر من مرة ؟'),
                    value: multeTimes,
                    onChanged: (v) {
                      setState(() {
                        multeTimes = v!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
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
        .child('Extras')
        .child(productId.toString())
        .child('${p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl1 = fileUrl;
    });
  }
}
