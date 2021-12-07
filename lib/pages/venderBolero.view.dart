import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/comprador_existente.view.dart';

class VenderBoleto extends StatefulWidget {
  final String idColaborador;

  const VenderBoleto({Key? key, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VenderBoleto();
  }
}

class _VenderBoleto extends State<VenderBoleto> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      final idColaboador = widget.idColaborador;
      final body = {
        'idColaborador': idColaboador,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.77:3000', '/carteras');
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
    const lighterGray = Color(0xFFD2D2D2);
    return ScreenUtilInit(
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
                    SizedBox(width: 10.w,),
                    Container(
                      width: 90.w,
                      child: Image.asset("assets/main-logo.png"),
                    ),
                    SizedBox(width: 140.w,),
                    Text(
                      "Carteras",
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
                future: _loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    color: lightGrey,
                    child: InkWell(
                        onTap: () {

                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Cartera #' +
                                    snapshot.data![index]['idCartera']
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.sp),
                              ),
                            ),
                            SizedBox(width: 160.w),
                            IconButton(
                              onPressed: (){
                                print(snapshot.data![index]['idCartera']);
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        )),
                  ),
                )
                    : Center(
                  child: CircularProgressIndicator(),
                ))),
      ),
    );
  }

  void onPress(int id) {
    print('pressed $id');
  }
}
//Text(snapshot.data![index]['title']),
