import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:sorteos_app/pages/home.view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {

  final username = TextEditingController();
  final password = TextEditingController();
  final log = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(children: <Widget>[
              Container(
                width: double.infinity,
                height: 150.0,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.asset("assets/main-logo.png"),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Text(
                      "INICIA SESION",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5),
                      child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Usuario"),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contraseña"),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10.0),
                      child: SizedBox(
                        width: 200.w,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () async {
                          
                            var res = await sendLogin(username.text, password.text);
                            print("Print res ->");
                            print(res.body);
                            if(res.body == "true"){
                              print("cuenta valida");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                            } else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context){
                                return AlertDialog(
                                  title: Container(
                                    child: Text("Datos incorrectos",
                                    textAlign: TextAlign.center,),
                                    ),
                                  actions: [],
                                  );
                                });
                              print("incorrect account");
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.sp)
                              )
                            ),
                            foregroundColor: MaterialStateProperty.all(Colors.black),
                            backgroundColor: MaterialStateProperty.all(Colors.amber),
                          ),
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),  
                  GestureDetector(
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                          fontSize: 20, decoration: TextDecoration.underline),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

sendLogin(String username, String password) async {
  final url = Uri.parse("http://192.168.1.133:3000/login");
  final data = {"username": username, "password": password};
  final res = await post(url, body: data);

  print("log to the console from post request");
  print(res.body);
  return res;
}
