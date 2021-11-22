import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sorteos_app/pages/boletos.view.dart';

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
      final id = widget.id;

      final body = {
        'idColaborador': id,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/carteras');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      posts = jsonDecode(response.body);

    } catch (err) {
      print(err);
      print('PS HOLA');
    }
    return posts;
  }

  /*
 final queryParameters = {
        'idColaborador': int.parse(widget.id),
      };
      final url = Uri.parse("http://192.168.1.133:3000/carteras");

      final newURI = url.replace(queryParameters: queryParameters);
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final http.Response res = await http.get(newURI, headers: headers);
      print(res.body);
      print(widget.id);
      posts = json.decode(res.body);






    try {
      // This is an open REST API endpoint for testing purposes
      const API = 'http://192.168.0.8:3000/boletos';

      final http.Response response = await http.get(Uri.parse(API));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }
    return posts;
  }
}*/

  @override
  Widget build(BuildContext context) {
    const lightGrey = Color(0xFFD2D2D2);
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: 60.h,
              backgroundColor: Colors.amber,
              title: Container(
                width: 75.w,
                child: Image.asset("assets/main-logo.png"),
              ),
              actions: [
                Row(
                  children: [
                    Text(
                      "Carteras",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                    )
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
                                          builder: (context) => Boletos()),
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
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Boletos()),
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
}
//Text(snapshot.data![index]['title']),
