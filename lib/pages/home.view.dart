import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sorteosApp/pages/carteras.view.dart';
import 'package:sorteosApp/pages/venderBolero.view.dart';
import 'package:sorteosApp/widget/HomeButton.widget.dart';
import 'package:sorteosApp/pages/register.view.dart';
import 'package:sorteosApp/pages/login.view.dart';

class Home extends StatefulWidget {
  final idColaborador;
  const Home({Key? key, required this.idColaborador})
      : super(key: key);

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
              width: 75.w,
              child: Image.asset("assets/main-logo.png"),
            ),
            actions: [
              Row(
                children: [
                  Text(
                    "Nombre de usuario",
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 30.h),
            child: Column(
              children: [
                HomeButton("assets/ticket.png", "Vender boletos", VenderBoleto(idColaborador: widget.idColaborador,)),
                SizedBox(height: 25.h),
                HomeButton("assets/coin.png", "Agregar abono", Login()),
                SizedBox(height: 25.h),
                HomeButton("assets/wallet.png", "Carteras", Carteras(id: widget.idColaborador)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
