import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sorteosApp/pages/boleto_espec%C3%ADfico.view.dart';
import 'package:sorteosApp/pages/compradores.view.dart';
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/registrarComprador.view.dart';

class CompradorExistente extends StatefulWidget {
  final String numBoleto;
  final String idColaborador;

  const CompradorExistente({Key? key, required this.numBoleto, required this.idColaborador})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompradorExistente();
  }
}

class _CompradorExistente extends State<CompradorExistente> {
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
                  Text(
                    "Registro de venta de boleto",
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
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                    "¿Comprador ya registrado?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                SizedBox(
                  height: 30.h,
                ),
                 Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterComprador(numBoleto: widget.numBoleto.toString())),
                          );

                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(150.w, 50.h)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.sp))),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.black),
                          backgroundColor: MaterialStateProperty.all(lightGrey),
                        ),
                        child: Text(
                          "NO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Compradores(numBoleto: widget.numBoleto.toString(), idColaborador: widget.idColaborador.toString())),
                          );
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(150.w, 50.h)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.sp))),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.black),
                          backgroundColor: MaterialStateProperty.all(Colors.amber),
                        ),
                        child: Text(
                          "SI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.sp),
                        ),
                      ), ],
                ),
              ],
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
