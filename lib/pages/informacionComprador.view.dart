import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/login.view.dart';
import 'package:sorteosApp/widget/TextInputDisable.widget.dart';

class InformacionCompradores extends StatefulWidget {
  final String numBoleto;
  final String idColaborador;
  final String idComprador;


  const InformacionCompradores({Key? key, required this.numBoleto, required this.idColaborador, required this.idComprador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InforamcionCompradores();
  }
}

class _InforamcionCompradores extends State<InformacionCompradores> {

  Future<List> _loadData(String filtro) async {
    List posts = [];
    try {
      final idComprador = widget.idComprador;
      final body = {
        'idComprador': idComprador,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.77:3000', '/infoComprador');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      posts = jsonDecode(response.body);
      print(posts);
    } catch (err) {
      print(err);
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    const lightGrey = Color(0xFFD2D2D2);
    const yellow = Color(0xFFF1D100);
    const lightyellow = Color(0xFFF1D100);
    return WillPopScope(
      onWillPop: () async => false,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: false,
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
                      width: 90.w,
                    ),
                    Text(
                      "Boleto #" + widget.numBoleto,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(width: 15.w),
                  ],
                )
              ],

            ),
            body: FutureBuilder(
                future: _loadData("0"),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) =>
                      SizedBox(
                          child: Column(children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  "Verificar Datos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Container(
                                  height: 50.h,
                                  width: double.maxFinite,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "Información del Vendedor",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        NombreText(context, "Nombre:"),
                                        DatosText(
                                            context,
                                            snapshot.data![index]
                                            ['nombre']
                                                .toString()),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        NombreText(
                                            context, "Dirección:"),
                                        DatosText(
                                            context,
                                            snapshot.data![index]
                                            ['direccion']
                                                .toString()),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        NombreText(context, "Correo:"),
                                        DatosText(
                                            context,
                                            snapshot.data![index]
                                            ['correo']
                                                .toString()),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        NombreText(
                                            context, "Teléfono:"),
                                        DatosText(
                                            context,
                                            snapshot.data![index]
                                            ['telefono']
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50.h,),
                                Row(
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

                                        bool res = await registerUser(widget.idComprador, widget.numBoleto);

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
                              ],
                            ),
                          ])
                      ),
                )
                    : Center(
                  child: CircularProgressIndicator(),
                )),
          ),
        ),
      ),
    );
  }
}

Widget DatosText(BuildContext context, String text) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w400, color: Colors.black));
}

Widget NombreText(BuildContext context, String text) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black));
}

registerUser(String nombre, String numBoleto) async {
  final url = Uri.parse("http://192.168.1.77:3000/asignarBoleto");
  bool response = false;
  final data = {
    "idComprador": nombre,
    "numBoleto": numBoleto,
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