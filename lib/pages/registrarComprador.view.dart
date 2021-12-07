import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/login.view.dart';
import 'package:sorteosApp/widget/TextInput.widget.dart';

class RegisterComprador extends StatefulWidget {
  final String numBoleto;
  final String idColaborador;

  const RegisterComprador({Key? key, required this.numBoleto, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterComprador();
  }
}

class _RegisterComprador extends State<RegisterComprador> {

  final nombre = TextEditingController();
  final apellido1 = TextEditingController();
  final apellido2 = TextEditingController();
  final calle = TextEditingController();
  final numint = TextEditingController();
  final numext = TextEditingController();
  final colonia = TextEditingController();
  final codigoPostal = TextEditingController();
  final ciudad = TextEditingController();
  final correo = TextEditingController();
  final telefono = TextEditingController();

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
                      width: 50.w,
                    ),
                    Text(
                      "Registro Comprador",
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
                      TextInput("Nombre", nombre, false),
                      TextInput("Apellido Paterno", apellido1, false),
                      TextInput("Apellido Materno", apellido2, false),
                      TextInput("Calle", calle, false),
                      TextInput("Número interior", numint, false),
                      TextInput("Número Exterior", numext, false),
                      TextInput("Colonia", colonia, false),
                      TextInput("Codigo Postal", codigoPostal, false),
                      TextInput("Ciudad", ciudad, false),
                      TextInput("Correo", correo, false),
                      TextInput("Telefono (solo número)", telefono, false),

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

                                  bool res = await registerUser(nombre.text, apellido1.text, apellido2.text, calle.text, numint.text, numext.text, colonia.text, codigoPostal.text, ciudad.text, correo.text, telefono.text, widget.numBoleto);

                                  if(res == true){
                                    print("cuenta valida");

                                    showAlertDialog(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home(idColaborador:widget.idColaborador,)),
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
                                  "Guardar",
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

registerUser(String nombre, String apellido1, String apellido2, String calle, String numint, String numext, String colonia, String codigoPostal, String ciudad, String correo, String telefono, String numBoleto) async {
  final url = Uri.parse("http://192.168.1.133:3000/registerComprador");
  bool response = false;
  final data = {
    "nombre": nombre,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "calle": calle,
    "numint": numint,
    "numext": numext,
    "colonia": colonia,
    "codigoPostal": codigoPostal,
    "ciudad": ciudad,
    "correo": correo,
    "telefono": telefono,
    "boleto": numBoleto,
  };
  final res = await http.post(url, body: data);
  if(res.body == "true"){
    response = true;
  }

  return response;
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(

    title: Text("Se ha guardado y asignado el boleto al comprador"),
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