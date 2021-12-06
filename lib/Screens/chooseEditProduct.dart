import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/Controller/ProductController.dart';
import 'editeproductScreen.dart';

class ChooseEditProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('قائمه المنتجات'),
        ),
        body: SingleChildScrollView(
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: ProductController.productModel.length,
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
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: CachedNetworkImage(
                                    imageUrl: ProductController
                                        .productModel[index].image
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SpinKitCubeGrid(
                                      color: Colors.grey[50],
                                      duration: Duration(seconds: 2),
                                      size: 180,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => Get.to(
                          () => EditeproductScreen(
                                description: ProductController
                                    .productModel[index].description,
                                discount: ProductController
                                    .productModel[index].discount,
                                id: ProductController
                                    .productModel[index].fProductId,
                                price:
                                    ProductController.productModel[index].price,
                                quantity: ProductController
                                    .productModel[index].quantity,
                              ),
                          preventDuplicates: false),
                    ),
                  )),
        ));
  }
}
