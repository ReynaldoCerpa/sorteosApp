import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/widget/TextInput.widget.dart';

class Abonar extends StatefulWidget {
  final String numBoleto;
  final String idColaborador;

  const Abonar({Key? key, required this.numBoleto, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Abonar();
  }
}

class _Abonar extends State<Abonar> {
  Future<List> _loadData(String filtro) async {
    List posts = [];
    try {
      final numBoleto = widget.numBoleto;
      final body = {
        'numBoleto': numBoleto,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/abonos');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      posts = jsonDecode(response.body);
      print(posts);
    } catch (err) {
      print(err);
    }
    return posts;
  }

  Future<List> _loadTotal() async {
    List posts = [];
    try {
      final numBoleto = widget.numBoleto;
      final body = {
        'numBoleto': numBoleto,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/totalabono');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      posts = jsonDecode(response.body);
      print(posts.toString());
    } catch (err) {
      print(err);
    }
    return posts;
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final cantidad = TextEditingController();
    const lightGrey = Color(0xFFD2D2D2);
    const yellow = Color(0xFFF1D100);
    const lightyellow = Color(0xFFF1D100);
    return WillPopScope(
        onWillPop: () async {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The System Back Button is Deactivated')));
      return false;
    },
    child: ScreenUtilInit(
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
                    "Boleto #" + widget.numBoleto,
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            color: Colors.amber,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text("Abonos",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ))),
                  ],
                ),
                FutureBuilder(
                    future: _loadTotal(),
                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),

                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, index) =>
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 50.w,
                                            top: 30.h,
                                            right: 50.w,
                                            bottom: 30.h),
                                        child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            child: (snapshot.data![index]
                                                            ['saldoPendiente']
                                                        .toString() !=
                                                    "0.0")
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Saldo Pendiente",
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .black)),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        "\$ " +
                                                            snapshot
                                                                .data![index][
                                                                    'saldoPendiente']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 30.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("PAGADO",
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ))),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                FutureBuilder(
                    future: _loadData("0"),
                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, index) =>
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w,
                                            top: 10.h,
                                            right: 20.w,
                                            bottom: 10.h),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Text(
                                                      "Pago " +
                                                          (index + 1)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.w),
                                                      child: Text(
                                                        snapshot.data![index]
                                                                ['fecha']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30.w),
                                                child: Text(
                                                  "\$ " +
                                                      snapshot.data![index]
                                                              ['cantidad']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                FutureBuilder(
                    future: _loadTotal(),
                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, index) =>
                                    Padding(
                                  padding: EdgeInsets.only(
                                      left: 50.w,
                                      top: 10.h,
                                      right: 50.w,
                                      bottom: 30.h),
                                  child:
                                      (snapshot.data![index]['saldoPendiente']
                                                  .toString() !=
                                              "0.0")
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 20.h, top: 10.h),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Container(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Ingrese Cantidad:",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                TextInput(
                                                                    "Cantidad",
                                                                    cantidad,
                                                                    false),
                                                                ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    fixedSize: MaterialStateProperty
                                                                        .all(Size(
                                                                            140.w,
                                                                            40.h)),
                                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(50.sp))),
                                                                    foregroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.black),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.amber),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    bool res = await registerUser(
                                                                        widget
                                                                            .idColaborador,
                                                                        widget
                                                                            .numBoleto,
                                                                        cantidad
                                                                            .text);

                                                                    if (res ==
                                                                        true) {
                                                                      print(
                                                                          "cuenta valida");

                                                                      setState(
                                                                          () {});
                                                                      showAlertDialog(
                                                                          context);
                                                                    } else if (res ==
                                                                        false) {
                                                                      showNegativeAlertDialog(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Abonar",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18.sp),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [],
                                                        );
                                                      });
                                                },
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          Size(140.w, 40.h)),
                                                  shape: MaterialStateProperty
                                                      .all(RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.sp))),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.amber),
                                                ),
                                                child: Text(
                                                  "Abonar",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
              ],
            ),
          ),
        ),
      ),
    ), );
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

registerUser(String idColaborador, String numBoleto, String cantidad) async {
  final url = Uri.parse("http://192.168.1.133:3000/agregarAbono");
  bool response = false;
  final data = {
    "idColaborador": idColaborador,
    "numBoleto": numBoleto,
    "cantidad": cantidad,
  };
  final res = await http.post(url, body: data);
  if (res.body == "true") {
    response = true;
  }
  print(response);

  return response;
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Se ha registrado el abono"),
    actions: [],
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
    title: Text("No se pudo completar el abono"),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
