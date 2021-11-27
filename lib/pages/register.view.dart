import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/login.view.dart';
import 'package:sorteosApp/widget/TextInput.widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {

  final nombreCompleto = TextEditingController();
  final direccion = TextEditingController();
  final telefono = TextEditingController();
  final email = TextEditingController();
  final usuario = TextEditingController();
  final contrasena = TextEditingController();
  final confirmContrasena = TextEditingController();

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
                height: 80.0,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.asset("assets/main-logo.png"),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Text(
                      "INGRESA TUS DATOS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                  ),                  
                  TextInput("Nombre completo", nombreCompleto, false),
                  TextInput("Direccion", direccion, false),
                  TextInput("Teléfono", telefono, false),
                  TextInput("E-mail", email, false),
                  TextInput("Usuario", usuario, false),
                  TextInput("Contraseña", contrasena, true),

                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10.0),
                      child: SizedBox(
                        width: 200.w,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () async {
                          
                            bool res = await registerUser(nombreCompleto.text, direccion.text, telefono.text, email.text, usuario.text, contrasena.text);
                            
                            if(res == true){
                              print("cuenta valida");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Login()),
                                );
                            } else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context){
                                return AlertDialog(
                                  title: Container(
                                    child: Text("No se pudo completar el registro",
                                    textAlign: TextAlign.center,),
                                    ),
                                  actions: [],
                                  );
                                });
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
                            "Registrarse",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp),
                          ),
                        ),
                      ),
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

registerUser(String nombreCompleto, String direccion, String telefono, String email, String usuario, String contrasena) async {
  final url = Uri.parse("http://192.168.1.77:3000/register");
  bool response = false;
  final data = {
    "nombreCompleto": nombreCompleto,
    "direccion": direccion,
    "telefono": telefono,
    "email": email,
    "usuario": usuario,
    "contrasena": contrasena
  };
  final res = await http.post(url, body: data);
  
  if(res.body == "true"){
    response = true;
  }

  return response;
}
