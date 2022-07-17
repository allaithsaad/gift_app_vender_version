import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/Controller/LoginController.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول '),
          centerTitle: true,
        ),
        body: new Material(
          child: new Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.white38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: new Container(
                      child: new Center(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '''
أهلا بك في تطبيق
 بوكية للمحلات
                                ''',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onChanged: (v) {
                                  setState(() {
                                    loginController.phoneNumber.value = v;
                                  });
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        bool? isFocused}) =>
                                    null,
                                maxLength: 9,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.phone,
                                decoration: new InputDecoration(
                                  labelText: " رقم الهاتف ",

                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.center,
                                onChanged: (v) {
                                  setState(() {
                                    loginController.password.value = v;
                                  });
                                },
                                decoration: new InputDecoration(
                                  labelText: " كلمة السر ",
                                  hintText: "إدخل كلمة السر ",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                                obscureText: true,
                              ),
                            ]),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      if (loginController.phoneNumber.value.length == 9 &&
                          loginController.password.value.length >= 6 &&
                          loginController.phoneNumber.value != '777777777' &&
                          loginController.phoneNumber.value != '711111211' &&
                          (loginController.phoneNumber.value.startsWith('77') ||
                              loginController.phoneNumber.value
                                  .startsWith('70') ||
                              loginController.phoneNumber.value
                                  .startsWith('73') ||
                              loginController.phoneNumber.value
                                  .startsWith('71'))) {
                        loginController.loginRequest(context);
                      } else {
                        Get.snackbar("Error",
                            "هناك خطاء في رقم الهاتف أو في كلمة المرور ");
                      }
                    },
                    child: Text('تأكيد '),
                    style: TextButton.styleFrom(
                      primary: Colors.redAccent,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.deepOrange, width: 1),
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
