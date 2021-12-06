import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/Controller/LoginController.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    final phoneNumber = TextEditingController();
    final password = TextEditingController();
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
                                  new TextFormField(
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    controller: phoneNumber,
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
                                  new TextFormField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    controller: password,
                                    textAlign: TextAlign.center,
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
                          if (phoneNumber.text.length == 9 &&
                              password.text.length >= 6 &&
                              phoneNumber.text != '777777777' &&
                              phoneNumber.text != '711111211' &&
                              (phoneNumber.text.startsWith('77') ||
                                  phoneNumber.text.startsWith('70') ||
                                  phoneNumber.text.startsWith('73') ||
                                  phoneNumber.text.startsWith('71'))) {
                            loginController.loginRequest(
                                phoneNumber.text, password.text, context);
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
                ))),
      ),
    );
  }
}
