import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/NotificationController.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationController = Get.find<NotificationController>();

  @override
  void initState() {
    notificationController.getNotifications();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات '),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: Get.find<NotificationController>(),
        builder: (controller) => notificationController
                .getNotificationsIsloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GetBuilder<NotificationController>(
                    init: Get.find<NotificationController>(),
                    builder: (controller) =>
                        notificationController.getNotificationsIsloading == true
                            ? Center(child: CircularProgressIndicator())
                            : NotificationController.notificationList.isEmpty
                                ? Center(child: Text('لا يوجد إشعارات  '))
                                : ListView.builder(
                                    itemCount: NotificationController
                                        .notificationList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(NotificationController
                                                .notificationList[index].name!),
                                            subtitle: Column(
                                              children: [
                                                Text(
                                                  NotificationController
                                                      .notificationList[index]
                                                      .body!,
                                                  maxLines: 3,
                                                ),
                                                Text(
                                                  DateTime(
                                                          NotificationController
                                                              .notificationList[
                                                                  index]
                                                              .date!
                                                              .year,
                                                          NotificationController
                                                              .notificationList[
                                                                  index]
                                                              .date!
                                                              .month,
                                                          NotificationController
                                                              .notificationList[
                                                                  index]
                                                              .date!
                                                              .day,
                                                          NotificationController
                                                              .notificationList[
                                                                  index]
                                                              .date!
                                                              .hour,
                                                          NotificationController
                                                              .notificationList[
                                                                  index]
                                                              .date!
                                                              .minute)
                                                      .toString()
                                                      .replaceAll(
                                                          ":00.000", ""),
                                                ),
                                              ],
                                            ),
                                            isThreeLine: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            selected: true,
                                            selectedTileColor: Colors.grey[300],
                                            leading: Image.asset(
                                              'assets/images/3.png',
                                              fit: BoxFit.cover,
                                            ),
                                            onTap: () {},
                                          ),
                                          Divider()
                                        ],
                                      );
                                    }),
                  ),
                )),
      ),
    );
  }
}
