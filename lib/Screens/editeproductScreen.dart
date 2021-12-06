import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class EditeproductScreen extends StatefulWidget {
  final String? id;
  final String? description;
  final int? price;
  final int? quantity;
  final int? discount;

  const EditeproductScreen(
      {Key? key,
      this.id,
      this.description,
      this.price,
      this.quantity,
      this.discount})
      : super(key: key);

  @override
  _EditeproductScreenState createState() => _EditeproductScreenState();
}

class _EditeproductScreenState extends State<EditeproductScreen> {
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final description = TextEditingController();
    final price = TextEditingController();
    final quantity = TextEditingController();
    final discount = TextEditingController();

    description.text = widget.description!;
    price.text = widget.price.toString();
    quantity.text = widget.quantity.toString();
    discount.text = widget.discount.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('تعديل منتج جديد'),
        actions: [
          TextButton(
              onPressed: () {
                if (price.text.length > 2 &&
                    description.text.length > 30 &&
                    quantity.text.length > 0) {
                  try {
                    print(widget.id);
                    FirebaseFirestore.instance
                        .collection('productesNew')
                        .doc(widget.id)
                        .update({
                      'description': description.text,
                      'price': int.parse(price.text),
                      'quantity': int.parse(quantity.text),
                      'discount': int.parse(discount.text),
                    }).whenComplete(() {
                      Get.back();
                      Get.snackbar("Done", "تم تعديل المنتج بنجاح ");
                    });
                  } catch (e) {
                    Get.snackbar("error", "هناك خطاء حاول مرة آخرى");
                  }
                } else {
                  Get.snackbar("خطاء", "تأكد من صحت البينات في الحقول ");
                }
              },

              // () async {
              //   if (name.text.length > 5 &&
              //       price.text.length > 2 &&
              //       description.text.length > 30 &&
              //       productId.text.length > 5 &&
              //       quantity.text.length > 0) {
              //     if (imageFile != null) {
              //       try {
              //         Loader.show(context,
              //             isSafeAreaOverlay: false,
              //             isAppbarOverlay: true,
              //             isBottomBarOverlay: false,
              //             progressIndicator: CircularProgressIndicator(),
              //             themeData: Theme.of(context)
              //                 .copyWith(accentColor: Colors.black38),
              //             overlayColor: Color(0x99E8EAF6));
              //         await _uploadFile(imageFile!.path).then((value) async {
              //           if (imageUrl != null) {
              //             DocumentReference docRef = FirebaseFirestore.instance
              //                 .collection('productesNew')
              //                 .doc();
              //             docRef.set({
              //               "fProductId": docRef.id,
              //               "storeId": FirebaseAuth.instance.currentUser!.uid,
              //               "name": name.text,
              //               "description": description.text,
              //               "price": int.parse(price.text),
              //               "productId": int.parse(productId.text),
              //               "categoryId": int.parse(categoryId.text),
              //               "quantity": int.parse(quantity.text),
              //               "available": false,
              //               "favorite": false,
              //               "image": imageUrl,
              //               "discount": 0,
              //               "popular": 0,
              //               "componentId": "0",
              //               "verified": false,
              //             }).then((value) {
              //               Loader.hide();
              //               Get.offAll(ControlScreen());
              //               Get.snackbar("إشعار", "تم إضافة المنتج بنجاح ");
              //             });
              //           }
              //         }).onError((error, stackTrace) {
              //           Loader.hide();
              //           print(error.toString());
              //         });
              //       } catch (error) {
              //         Loader.hide();
              //         print(error.toString());
              //       }
              //     } else {
              //       Get.snackbar("title", "تأكد من إضافة صورة ");
              //     }
              //   } else {
              //     Get.snackbar("خطاء", "تأكد من ملُ الحقول  ");
              //   }
              // },

              child: Card(
                color: Colors.white38,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(
                      width: 5,
                    ),
                    Text('حفظ')
                  ],
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Card(
              //   child: GestureDetector(
              //     onTap: () => _selectPhoto(),
              //     child: SizedBox(
              //       height: 100,
              //       width: double.infinity,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Icon(
              //             Icons.image,
              //             size: 40,
              //           ),
              //           Text(imageUrl != null
              //               ? 'اضغط لاضافه صوره المنتج'
              //               : 'اضغط لاتعديل صوره المنتج'),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              InputFileds(
                  'الوصف  ', description, 3, TextInputAction.next, false),
              textFielNumber(price, 'السعر', TextInputAction.next),

              textFielNumber(discount, 'إضف تخفيض', TextInputAction.next),

              textFielNumber(quantity, 'الكميه', TextInputAction.done),
            ],
          ),
        ),
      ),
    );
  }

  // Future _selectPhoto() async {
  //   await showModalBottomSheet(
  //       context: context,
  //       builder: (context) => BottomSheet(
  //             builder: (context) => Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 ListTile(
  //                     leading: Icon(Icons.camera),
  //                     title: Text('Camera'),
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       _pickImage(ImageSource.camera);
  //                     }),
  //                 ListTile(
  //                     leading: Icon(Icons.filter),
  //                     title: Text('Pick a file'),
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       _pickImage(ImageSource.gallery);
  //                     }),
  //               ],
  //             ),
  //             onClosing: () {},
  //           ));
  // }

  // Future _pickImage(ImageSource source) async {
  //   final pickedFile =
  //       await _picker.pickImage(source: source, imageQuality: 50);
  //   if (pickedFile == null) {
  //     return;
  //   }

  //   var file = await ImageCropper.cropImage(
  //       sourcePath: pickedFile.path,
  //       aspectRatioPresets: Platform.isAndroid
  //           ? [
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio16x9
  //             ]
  //           : [
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio5x3,
  //               CropAspectRatioPreset.ratio5x4,
  //               CropAspectRatioPreset.ratio7x5,
  //               CropAspectRatioPreset.ratio16x9
  //             ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         title: 'Cropper',
  //       ));
  //   if (file == null) {
  //     return;
  //   }

  //   file = await compressImagePath(file.path, 35);

  //   setState(() {
  //     imageFile = file;
  //   });
  // }

  // Future<File?> compressImagePath(String path, int quality) async {
  //   final newPath = p.join((await getTemporaryDirectory()).path,
  //       '${DateTime.now()}.${p.extension(path)}');

  //   final result = await FlutterImageCompress.compressAndGetFile(
  //     path,
  //     newPath,
  //     quality: quality,
  //   );

  //   return result!;
  // }

  // Future _uploadFile(String path) async {
  //   final ref = storage.FirebaseStorage.instance
  //       .ref()
  //       .child('stores')
  //       .child('${DateTime.now().toIso8601String() + p.basename(path)}');

  //   final result = await ref.putFile(File(path));
  //   final fileUrl = await result.ref.getDownloadURL();

  //   setState(() {
  //     imageUrl = fileUrl;
  //   });
  // }

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
