import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sorteosApp/pages/boletos.view.dart';

class Carteras extends StatefulWidget {
  final String id;
  const Carteras({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Carteras();
  }
}

class _Carteras extends State<Carteras> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      final idColaboador = widget.id;
      final body = {
        'idColaborador': idColaboador,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/carteras');
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Boletos(idColaborador: widget.id, idCartera: snapshot.data![index]['idCartera'].toString())),
                          );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Boletos(idColaborador: widget.id, idCartera: snapshot.data![index]['idCartera'].toString())),
                                );
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

