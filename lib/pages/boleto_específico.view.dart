import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/home.view.dart';

class Boleto_especifico extends StatefulWidget {

  final String numBoleto;
  const Boleto_especifico(
      {Key? key, required this.numBoleto})
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
      final uri = Uri.http('10.20.137.13:3000', '/boletoespecifico');
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
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 60.h,
            backgroundColor: Colors.amber,
            title:  IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
            actions: [
              Row(
                children: [
                  SizedBox(width: 10.w,),
                  SizedBox(
                    width: 90.w,
                    child: Image.asset("assets/main-logo.png"),
                  ),
                  SizedBox(
                    width: 90.w,
                  ),
                  Text(
                    "Boletos #"+widget.numBoleto,
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
          body:
               FutureBuilder(
                        future: _loadData("0"),
                        builder: (BuildContext ctx,
                            AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder:
                              (BuildContext context, index) => SizedBox(
                                child: Column(
                                  children : [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        Text(
                                          "Fecha de venta "+snapshot.data![
                                          index][
                                          'fecha']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Fecha de venta "+snapshot.data![
                                          index][
                                          'fecha']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ]
                                    ),
                              ),
                        )
                            : Center(
                          child: CircularProgressIndicator(),
                        ))
           ,
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
