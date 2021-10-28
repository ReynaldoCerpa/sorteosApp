import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sorteos_app/pages/home.view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Usuario"),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
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
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}