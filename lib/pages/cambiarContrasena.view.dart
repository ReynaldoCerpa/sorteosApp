import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/login.view.dart';
import 'package:sorteosApp/widget/TextInput.widget.dart';

class CambiarContrasena extends StatefulWidget {
  final String idColaborador;

  const CambiarContrasena({Key? key, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CambiarContrasena();
  }
}

class _CambiarContrasena extends State<CambiarContrasena> {

  final nueva = TextEditingController();
  final nueva2 = TextEditingController();
  final vieja = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const lightGrey = Color(0xFFD2D2D2);
    return WillPopScope(
      onWillPop: () async => false,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              toolbarHeight: 60.h,
              backgroundColor: Colors.amber,
              title: Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                ),
              ),
              actions: [
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 90.w,
                      child: Image.asset("assets/main-logo.png"),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    Text(
                      "Cambiar Contraseña",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(width: 15.w),
                  ],
                )
              ],
            ),
            body: SafeArea(
                child:  SingleChildScrollView(
                  child:
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
                      TextInput("Contraseña Nueva", nueva, true),
                      TextInput("Confirmar Contraseña", nueva2, true),
                      TextInput("Contraseña Anterior", vieja, true),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10.0),
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(Size(140.w, 40.h)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.sp)
                                      )
                                  ),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                  backgroundColor: MaterialStateProperty.all(lightGrey),
                                ),
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              ElevatedButton(
                                onPressed: () async {

                                  bool res = await registerUser(nueva.text, nueva2.text, vieja.text, widget.idColaborador);

                                  if(res == true){
                                    print("cuenta valida");


                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Login()),

                                    );
                                    showAlertDialog(context);

                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Container(
                                              child: Text("No se pudo cambiar la contraseña",
                                                textAlign: TextAlign.center,),
                                            ),
                                            actions: [],
                                          );
                                        });
                                  }
                                },
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(Size(140.w, 40.h)),

                                  shape: MaterialStateProperty.all(

                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.sp)
                                      )
                                  ),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                                ),
                                child: Text(
                                  "Cambiar",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) ,
                )),
          ),
        ),
      ),
    );
  }
}

registerUser(String nueva, String nueva2, String vieja, String idColaborador) async {
  final url = Uri.parse("http://192.168.1.77:3000/cambiarContraColaborador");
  bool response = false;
  final data = {
    "idColaborador":idColaborador,
    "nueva": nueva,
    "nueva2": nueva2,
    "vieja": vieja,

  };
  final res = await http.post(url, body: data);
  if(res.body == "true"){
    response = true;
  }

  return response;
}


showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(

    title: Text("Se ha cambiado la contraseña"),
    actions: [
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showNegativeAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(

    title: Text("No se pudo completar el cambio"),
    actions: [
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}