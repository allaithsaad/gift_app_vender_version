import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
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
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final productRef = Get.find<ProductController>();
    final name = TextEditingController();
    final description = TextEditingController();
    final price = TextEditingController();
    final quantity = TextEditingController();
    final productId = TextEditingController();
    final categoryId = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('اضافه منتج جديد'),
        actions: [
          TextButton(
              onPressed: () async {
                if (name.text.length > 5 &&
                    price.text.length > 2 &&
                    description.text.length > 10 &&
                    productId.text.length > 5 &&
                    quantity.text.length > 0) {
                  if (imageFile != null) {
                    try {
                      Loader.show(context,
                          isSafeAreaOverlay: false,
                          isAppbarOverlay: true,
                          isBottomBarOverlay: false,
                          progressIndicator: CircularProgressIndicator(),
                          themeData: Theme.of(context)
                              .copyWith(accentColor: Colors.black38),
                          overlayColor: Color(0x99E8EAF6));
                      await _uploadFile(imageFile!.path).then((value) async {
                        if (imageUrl != null) {
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection('productesNew')
                              .doc();
                          docRef.set({
                            "fProductId": docRef.id,
                            "storeId": FirebaseAuth.instance.currentUser!.uid,
                            "name": name.text,
                            "description": description.text,
                            "price": int.parse(price.text),
                            "productId": int.parse(productId.text),
                            "categoryId": int.parse(categoryId.text),
                            "quantity": int.parse(quantity.text),
                            "productStates": 0,
                            "favorite": false,
                            "image": imageUrl,
                            "discount": 0,
                            "popular": 0,
                            "componentId": "0",
                            "verified": false,
                          }).then((value) {
                            Loader.hide();
                            Get.offAll(ControlScreen());
                            productRef.getProduct();
                            Get.snackbar("إشعار", "تم إضافة المنتج بنجاح ");
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
                  } else {
                    Get.snackbar("title", "تأكد من إضافة صورة ");
                  }
                } else {
                  Get.snackbar("خطاء", "تأكد من ملُ الحقول  ");
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
              GestureDetector(
                onTap: () => _selectPhoto(),
                child: Card(
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.image,
                          size: 40,
                        ),
                        Text(imageUrl != null
                            ? 'اضغط لاضافه صوره المنتج'
                            : 'اضغط لاتعديل صوره المنتج'),
                      ],
                    ),
                  ),
                ),
              ),
              InputFileds('اسم المنتج', name, 1, TextInputAction.next, false),
              InputFileds(
                  'الوصف  ', description, 3, TextInputAction.next, false),
              textFielNumber(price, 'السعر', TextInputAction.next),
              textFielNumber(categoryId, 'نوع الهدية', TextInputAction.next),
              textFielNumber(
                  productId, 'الرمزالخاص بالمنتج', TextInputAction.next),
              textFielNumber(quantity, 'الكميه', TextInputAction.done),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectPhoto() async {
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
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
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

    file = await compressImagePath(file.path, 35);

    setState(() {
      imageFile = file;
    });
  }

  Future<File?> compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('stores')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });
  }

  Widget textFielNumber(TextEditingController quantity, String title,
      TextInputAction textInputAction) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: true,
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
}

class InputFileds extends StatelessWidget {
  final TextEditingController controller;
  final String feildName;
  final TextInputAction textInputAction;
  final int maxline;
  final bool autofocus;
  InputFileds(this.feildName, this.controller, this.maxline,
      this.textInputAction, this.autofocus);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          textInputAction: textInputAction,
          autofocus: autofocus,
          keyboardType: TextInputType.name,
          controller: controller,
          maxLines: maxline,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: feildName,
          ),
        ),
      ),
    );
  }
}
