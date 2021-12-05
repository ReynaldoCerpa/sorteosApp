import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sorteosApp/pages/boletos.view.dart';
import 'package:sorteosApp/pages/comprador_existente.view.dart';

class BoletosNoVendidos extends StatefulWidget {
  final String idColaborador;

  const BoletosNoVendidos({Key? key, required this.idColaborador}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoletosNoVendidos();
  }
}

class _BoletosNoVendidos extends State<BoletosNoVendidos> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      final String idColaborador = widget.idColaborador;
      final body = {
        'idColaborador': idColaborador,
      };
      final jsonString = json.encode(body);
      final uri = Uri.http('192.168.1.133:3000', '/boletosNoVendidos');
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
              title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                    ),
                    Row(
                      children: [

                        Container(
                          width: 90.w,
                          child: Image.asset("assets/main-logo.png"),
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          "Boletos no Vendidos",
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ]
              ),
            ),
            body: FutureBuilder(
                future: _loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder:
                      (BuildContext context, index) =>
                      Card(
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
                                MaterialPageRoute(builder: (context) => CompradorExistente(numBoleto: snapshot
                                    .data![
                                index]
                                [
                                'numBoleto']
                                    .toString(), idColaborador: widget.idColaborador,)),
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    child: SizedBox(
                                      width: 250
                                          .w,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment
                                                .centerLeft,
                                            child: Text(
                                              "Boleto #"+snapshot
                                                  .data![
                                              index]
                                              [
                                              'numBoleto']
                                                  .toString() ,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Reboto',
                                                  fontWeight:
                                                  FontWeight
                                                      .w800,
                                                  fontSize:
                                                  15.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Flexible(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment
                                          .centerRight,
                                      child: IconButton(
                                        onPressed: () {

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
                ))),
      ),
    );
  }

  void onPress(int id) {
    print('pressed $id');
  }
}
//Text(snapshot.data![index]['title']),