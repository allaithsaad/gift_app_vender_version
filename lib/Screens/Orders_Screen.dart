import 'package:flutter/material.dart';
import '/Widgets/orderWidget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الطلبات '),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            unselectedLabelStyle:
                TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                text: "الجديده",
              ),
              Tab(
                text: "المكتمله",
              ),
              Tab(
                text: "الملغية",
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            newOrders(),
            completedOrder(),
            canceledorder(),
          ],
        ),
      ),
    );
  }

  Widget newOrders() {
    return Center(child: CartOrderWidget(1));
  }

  Widget completedOrder() {
    return Center(child: CartOrderWidget(2));
  }

  Widget canceledorder() {
    return Center(child: CartOrderWidget(3));
  }
}
