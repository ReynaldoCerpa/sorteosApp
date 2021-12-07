import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/abonar.view.dart';
import 'package:sorteosApp/pages/boleto_espec%C3%ADfico.view.dart';
import 'package:sorteosApp/pages/home.view.dart';

class BoletosVendidos extends StatefulWidget {
  final String idColaborador;
  const BoletosVendidos({Key? key, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoletosVendidos();
  }
}

class _BoletosVendidos extends State<BoletosVendidos> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      final idColaboador = widget.idColaborador;
      final body = {
        'idColaborador': idColaboador,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/boletosvendidos');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      posts = jsonDecode(response.body);
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
                      width: 100.w,
                    ),
                    Text(
                      "Boletos",
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
            body: SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                      child: FutureBuilder(
                          future: _loadData(),
                          builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder:
                                (BuildContext context, index) => Card(
                              margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 15,
                                  bottom: 10),
                              color: lightGrey,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Abonar(
                                                numBoleto: snapshot
                                                    .data![index]
                                                ['numBoleto']
                                                    .toString(),
                                                idColaborador: widget
                                                    .idColaborador
                                                    .toString(),
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(
                                              10.0),
                                          child: SizedBox(
                                            width: 150.w,
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: Text(
                                                    'Boleto #' +
                                                        snapshot.data![
                                                        index][
                                                        'numBoleto']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'Reboto',
                                                        fontWeight:
                                                        FontWeight
                                                            .w800,
                                                        fontSize:
                                                        20.sp),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: 700.w,
                                                        child: Text(
                                                          snapshot
                                                              .data![
                                                          index]
                                                          [
                                                          'nombre']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              fontSize:
                                                              11.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      Flexible(
                                        child: Container(
                                          child: Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          Abonar(
                                                            numBoleto: snapshot
                                                                .data![index]['numBoleto']
                                                                .toString(),
                                                            idColaborador: widget
                                                                .idColaborador
                                                                .toString(),
                                                          )),
                                                );
                                              },
                                              icon: Icon(Icons
                                                  .arrow_forward_ios),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                              : Center(
                            child: CircularProgressIndicator(),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPress(int id) {
    print('pressed $id');
  }
}

Widget homeButtons(BuildContext context, String img, String text) {
  const lightGrey = Color(0xFFD2D2D2);

  return SizedBox(
    height: 100.h,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.sp))),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        backgroundColor: MaterialStateProperty.all(lightGrey),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Image.asset(
            img,
            width: 70.w,
          ),
        ),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.sp),
        )
      ]),
    ),
  );
}
//Text(snapshot.data![index]['title']),
