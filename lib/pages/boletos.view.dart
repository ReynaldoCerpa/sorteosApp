import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteos_app/pages/home.view.dart';

class Boletos extends StatefulWidget {
  const Boletos({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Boletos();
  }
}

class _Boletos extends State<Boletos> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      const API = 'http://192.168.1.133:3000/boletos';

      final http.Response response = await http.get(Uri.parse(API));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }
    return posts;
  }

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
                      "Boletos",
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
                                          builder: (context) => Home()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Boleto #' +
                                              snapshot.data![index]['numBoleto']
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                      SizedBox(width: 170.w),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
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
