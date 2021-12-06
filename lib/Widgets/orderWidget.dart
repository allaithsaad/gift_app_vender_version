import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/Controller/order_controller.dart';

class CartOrderWidget extends StatelessWidget {
  int orderSatate;
  CartOrderWidget(this.orderSatate);
  List pathOrder = [];

  @override
  Widget build(BuildContext context) {
    if (orderSatate == 1) {
      pathOrder = OrderController.newOrder;
    } else if (orderSatate == 2) {
      pathOrder = OrderController.completedOrder;
    } else if (orderSatate == 3) {
      pathOrder = OrderController.canceledOrder;
    }

    return GetBuilder<OrderController>(
        builder: (controller) => ListView.builder(
            itemCount: pathOrder.length,
            padding: const EdgeInsets.only(top: 10.0),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Wrap(
                      children: [
                        Card(
                          color: Colors.deepPurple[100],
                          elevation: 0,
                          margin: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  DateTime(
                                          pathOrder[i].orderDate!.year,
                                          pathOrder[i].orderDate!.day,
                                          pathOrder[i].orderDate!.month)
                                      .toString()
                                      .replaceAll('00:00:00.000', ''),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '#' + pathOrder[i].orderId.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Card(
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        pathOrder[i].productImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SpinKitCircle(
                                      color: Colors.grey[50],
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    pathOrder[i].productName.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    pathOrder[i].productId.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                        ),
                        Stack(
                          children: [
                            Card(
                              margin: EdgeInsets.all(0),
                              elevation: 0,
                              child: SizedBox(
                                width: double.infinity,
                                height: 40,
                              ),
                            ),
                            Positioned(
                              left: 5,
                              bottom: -5,
                              child: Text(
                                pathOrder[i].totalPrice.toString() + 'RY',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: OrderState(pathOrder[i].orderState!)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

Widget OrderState(int orderState) {
  Color color = Colors.white;
  String title = '';

  if (orderState == 1) {
    color = Colors.green;
    title = '   طلب جديد   ';
  } else if (orderState == 2) {
    color = Colors.grey;
    title = '   مكتمل   ';
  } else if (orderState == 3) {
    color = Colors.red;
    title = '   ملغي   ';
  }
  return Badge(
      padding: EdgeInsets.all(5),
      toAnimate: true,
      shape: BadgeShape.square,
      badgeColor: color,
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(0),
          topLeft: Radius.circular(10)),
      badgeContent: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ));
}
