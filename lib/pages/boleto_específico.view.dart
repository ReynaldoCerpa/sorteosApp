import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Boleto_especifico extends StatefulWidget {
  final String numBoleto;
  const Boleto_especifico({Key? key, required this.numBoleto})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Boleto_especifico();
  }
}

class _Boleto_especifico extends State<Boleto_especifico> {
  Future<List> _loadData(String filtro) async {
    List posts = [];
    try {
      final numBoleto = widget.numBoleto;
      final body = {
        'numBoleto': numBoleto,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/boletoespecifico');
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
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 60.h,
            backgroundColor: Colors.amber,
            title: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
            actions: [
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: Image.asset("assets/main-logo.png"),
                  ),
                  SizedBox(
                    width: 90.w,
                  ),
                  Text(
                    "Boletos #" + widget.numBoleto,
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
                            child: (snapshot.data![index]['nombre']
                                        .toString() !=
                                    "null")
                                ? Column(children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        (snapshot.data![index]['fecha']
                                                    .toString() ==
                                                "null")
                                            ? Text(
                                                "No vendido",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                "Fecha de venta " +
                                                    snapshot.data![index]
                                                            ['fecha']
                                                        .toString(),
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
                                          color: Colors.amber,
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
                                        SizedBox(
                                          height: 25.h,
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
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ])
                                : Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        Text(
                                          "No vendido",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
        ),
      ),
    );
  }

  void onPress(int id) {
    print('pressed $id');
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
//Text(snapshot.data![index]['title']),
