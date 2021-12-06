import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/LoginController.dart';
import 'package:storeapp/Screens/LoginScreen.dart';

class UserinfoScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('الحسابات'),
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[200],
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.blue,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: Text(
                                          '7',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Text(' جديده')
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.green,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: Text(
                                          '30',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Text(' مكتمله ')
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.red,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Text(' ملغيه')
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('اجمالي المبيعات'),
                              Text(
                                '150000RY',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ],
                          ),
                          Card(
                            color: Colors.grey[200],
                            elevation: 0,
                            child: SizedBox(
                              width: 2,
                              height: 50,
                            ),
                          ),
                          Column(
                            children: [
                              Text('اجمالي المدفوع'),
                              Text(
                                '95000RY',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            ],
                          ),
                          Card(
                            color: Colors.grey[200],
                            elevation: 0,
                            child: SizedBox(
                              width: 2,
                              height: 50,
                            ),
                          ),
                          Column(
                            children: [
                              Text(' المتبقي'),
                              Text(
                                '55000RY',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orangeAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // loginController.deleteSPUser();
                    Get.offAll(LoginScreen());
                  },
                  child: Text("Exit")),
            )
          ],
        ));
  }
}
