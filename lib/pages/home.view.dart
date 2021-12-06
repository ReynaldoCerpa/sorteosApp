import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sorteosApp/pages/boletosNoVendidos.view.dart';
import 'package:sorteosApp/pages/boletosVendidos.view.dart';
import 'package:sorteosApp/pages/cambiarContrasena.view.dart';
import 'package:sorteosApp/pages/carteras.view.dart';
import 'package:sorteosApp/pages/venderBolero.view.dart';
import 'package:sorteosApp/widget/HomeButton.widget.dart';
import 'package:sorteosApp/pages/register.view.dart';
import 'package:sorteosApp/pages/login.view.dart';

class Home extends StatefulWidget {
  final String idColaborador;
  const Home({Key? key, required this.idColaborador}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 60.h,
            backgroundColor: Colors.amber,
            title: Container(
                height: 40.h,
                child: Row(
                  children: [
                    Image.asset("assets/main-logo.png"),
                  ],
                )),
            actions: [
              PopupMenuButton(
                  offset: Offset(0, 50),
                  icon: Icon(Icons.settings),
                  itemBuilder: (context) => [
                        PopupMenuItem(

                            value: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CambiarContrasena(idColaborador: widget.idColaborador)),
                                );
                              },
                              child: Container(
                                child: Text(
                                "Cambiar Contraseña",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),),
                            )),
                    PopupMenuItem(
                        value: 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );

                          },
                          child: Text(
                            "Cerrar Sesión",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                      ])
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 30.h),
            child: Column(
              children: [
                HomeButton(
                    "assets/ticket.png",
                    "Vender boletos",
                    BoletosNoVendidos(
                      idColaborador: widget.idColaborador,
                    )),
                SizedBox(height: 25.h),
                HomeButton(
                    "assets/coin.png",
                    "Agregar abono",
                    BoletosVendidos(
                      idColaborador: widget.idColaborador,
                    )),
                SizedBox(height: 25.h),
                HomeButton("assets/wallet.png", "Carteras",
                    Carteras(id: widget.idColaborador)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
