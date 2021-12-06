import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/LoginController.dart';
import 'dart:math';
import '/Controller/ProductController.dart';
import '/Screens/product_screen.dart';
import 'editeproductScreen.dart';

ScrollController? _scrollController;

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                      collapsedHeight: 110.0,
                      centerTitle: true,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.white,
                      floating: true,
                      pinned: true,
                      expandedHeight: 350.0,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          titlePadding: EdgeInsets.all(0),
                          title: Card(
                            margin: EdgeInsets.all(0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Store name', //LoginController.storeSPData.name!
                                          style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' محل هديا',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.purple),
                                        ),
                                        Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text('مفتوح',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Card(
                                    color: Colors.purple,
                                    elevation: 0,
                                    child: TabBar(
                                        labelPadding: EdgeInsets.all(0),
                                        unselectedLabelColor: Colors.white70,
                                        indicatorColor: Colors.white,
                                        labelColor: Colors.white,
                                        labelStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        unselectedLabelStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                        tabs: [
                                          Tab(
                                            text: 'متوفره',
                                          ),
                                          Tab(
                                            text: 'العروض',
                                          ),
                                          Tab(
                                            text: 'موقفه',
                                          ),
                                          Tab(
                                            text: 'مرفوضه',
                                          ),
                                        ]),
                                  )
                                ]),
                          ),
                          background: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/gift-app-ef689.appspot.com/o/storeImages%2F3.jpg?alt=media&token=258fdbc0-bc68-40b6-abbe-e0bbe0c2cfe9',
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                                placeholder: (context, url) => SpinKitCubeGrid(
                                  color: Colors.grey[50],
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ))),
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        ProductStateGrid(1),
                        ProductStateGrid(2),
                        ProductStateGrid(3),
                        ProductStateGrid(4),
                      ],
                    ),
                  ),
                ]),
          );
        }),
      ),
    );
  }
}

class ProductStateGrid extends StatefulWidget {
  int catNum;
  ProductStateGrid(this.catNum);
  @override
  _ProductStateGridState createState() => _ProductStateGridState();
}

class _ProductStateGridState extends State<ProductStateGrid> {
  final productController = Get.find<ProductController>();

  @override
  List pathCat = ProductController.productModel;
  Widget build(BuildContext context) {
    if (widget.catNum == 0) {
      pathCat = ProductController.productModel;
    } else if (widget.catNum == 1) {
      pathCat = ProductController.acceptedModel;
    } else if (widget.catNum == 2) {
      pathCat = ProductController.offerModel;
    } else if (widget.catNum == 3) {
      pathCat = ProductController.onHoldModel;
    } else {
      pathCat = ProductController.unAcceptedModel;
    }
    int min = 1, max = 4;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GetPlatform.isWeb ? 5 : 2, childAspectRatio: 1 / 1),
      itemCount: pathCat.length,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) => GetBuilder<ProductController>(
        builder: (controller) => GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl: pathCat[index].image.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitCubeGrid(
                          color: Colors.grey[50],
                          duration: Duration(seconds: 2),
                          size: 180,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Card(
                        margin: EdgeInsets.zero,
                        borderOnForeground: true,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20)),
                        ),
                        color: Colors.black.withOpacity(0.5),
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      buttonPadding: EdgeInsets.all(5),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'الغاء',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                      backgroundColor:
                                          Colors.white.withOpacity(0.7),
                                      contentPadding: EdgeInsets.all(10),
                                      title: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                          ),
                                          SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: pathCat[index]
                                                      .image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          )
                                        ],
                                      ),
                                      elevation: 20,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Card(
                                            margin: EdgeInsets.all(3),
                                            child: FlatButton(
                                                minWidth: 250,
                                                height: 10,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  Get.back();
                                                  Get.to(
                                                    () => EditeproductScreen(
                                                      quantity: pathCat[index]
                                                          .quantity!,
                                                      price:
                                                          pathCat[index].price!,
                                                      id: pathCat[index]
                                                          .fProductId
                                                          .toString(),
                                                      discount: pathCat[index]
                                                          .discount!,
                                                      description:
                                                          pathCat[index]
                                                              .description
                                                              .toString(),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      'تعديل المنتج',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Card(
                                            margin: EdgeInsets.all(3),
                                            // ignore: deprecated_member_use
                                            child: FlatButton(
                                                minWidth: 250,
                                                textColor: Colors.black,
                                                onPressed: pathCat[index]
                                                            .productStates ==
                                                        1
                                                    ? () async {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'productesNew')
                                                            .doc(pathCat[index]
                                                                .fProductId)
                                                            .update({
                                                          'productStates': 3
                                                        });
                                                        ProductController
                                                            .productModel;
                                                        ProductController();
                                                        Get.back();
                                                      }
                                                    : () async {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'productesNew')
                                                            .doc(pathCat[index]
                                                                .fProductId)
                                                            .update({
                                                          'productStates': min +
                                                              Random().nextInt(
                                                                  max - min)
                                                        });
                                                        ProductController
                                                            .productModel;
                                                        ProductController();
                                                        Get.back();
                                                        print(
                                                            'worrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrk');
                                                      },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.hide_image),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      pathCat[index]
                                                                  .productStates ==
                                                              3
                                                          ? 'تفعيل المنتج'
                                                          : 'ايقاف المنتج',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Card(
                                            margin: EdgeInsets.all(3),
                                            child: FlatButton(
                                                minWidth: 250,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  Get.back();
                                                  Get.to(
                                                    () => EditeproductScreen(
                                                      quantity: pathCat[index]
                                                          .quantity!,
                                                      price:
                                                          pathCat[index].price!,
                                                      id: pathCat[index]
                                                          .fProductId
                                                          .toString(),
                                                      discount: pathCat[index]
                                                          .discount!,
                                                      description:
                                                          pathCat[index]
                                                              .description
                                                              .toString(),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.add_circle),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      'تعديل الكميه',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Card(
                                            margin: EdgeInsets.all(3),
                                            // ignore: deprecated_member_use
                                            child: FlatButton(
                                                minWidth: 250,
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'productesNew')
                                                      .doc(pathCat[index]
                                                          .fProductId)
                                                      .update({
                                                    'productStates': 6
                                                  }).catchError((onError) {
                                                    print(onError.toString());
                                                  }).whenComplete(() {
                                                    Get.back();
                                                    productController
                                                        .getProduct();
                                                    setState(() {
                                                      pathCat.remove(
                                                          pathCat[index]);
                                                    });

                                                    // ProductController
                                                    //     .productModel
                                                    //     .remove();
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete_forever),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Text(
                                                      'حذف المنتج',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            constraints: BoxConstraints.tight(Size.square(40)),
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white70,
                              size: 25,
                            ))),
                  )
                ],
              ),
            ),
          ),
          onTap: () => Get.to(
              () => ProductScreen(
                  pathCat[index].name.toString(),
                  pathCat[index].image.toString(),
                  pathCat[index].price!,
                  pathCat[index].productId!,
                  pathCat[index].description.toString()),
              preventDuplicates: true),
        ),
      ),
    );
  }
}
