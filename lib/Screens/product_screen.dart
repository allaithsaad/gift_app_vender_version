import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/Screens/viewProductImage.dart';

class ProductScreen extends StatelessWidget {
  final String name;
  final String productImageUrl;
  final int price;
  final int productId;
  final String description;

  ProductScreen(this.name, this.productImageUrl, this.price, this.productId,
      this.description);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: ProductWidget(
                name, productImageUrl, price, productId, description),
          ),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String name;
  final String productImageUrl;
  final int price;
  final int productId;
  final String description;
  ProductWidget(this.name, this.productImageUrl, this.price, this.productId,
      this.description);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                        child: GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: productImageUrl,
                          fit: BoxFit.cover,
                          height: 400,
                          width: double.infinity,
                          placeholder: (context, url) => SpinKitCubeGrid(
                            color: Colors.grey[50],
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      onTap: () => Get.to(ViewProductImage(productImageUrl)),
                    )),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40))),
                      color: Colors.white.withOpacity(0.3),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () => Get.back()),
                          IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.black),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.share, color: Colors.black),
                              onPressed: () {}),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '#' + productId.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      price.toString() + 'RY',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                'التفاصيل',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                softWrap: false,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: true,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        ' مكونات الهديه و الاضافات',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        ' مكونات ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                  collapsed: Text('this is great'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
