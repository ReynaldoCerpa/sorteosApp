import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home>{
  Widget build(BuildContext context){
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
                  Text("Nombre de usuario",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings),)
                ],
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
              vertical: 30.h),
            child: Column(
              children: [
                  homeButtons(context, "assets/ticket.png", "Vender boletos"),
                  SizedBox(height: 25.h),
                  homeButtons(context, "assets/coin.png", "Agregar abono"),
                  SizedBox(height: 25.h),
                  homeButtons(context, "assets/wallet.png", "Carteras"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget homeButtons(BuildContext context, String img, String text){
  const lightGrey = Color(0xFFD2D2D2);

  return SizedBox(
    height: 100.h,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {  },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.sp)
          )
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        backgroundColor: MaterialStateProperty.all(lightGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Image.asset(img, width: 70.w,),
          ),
          Text(text,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.sp 
            ),
          )
        ]
      ),),
  ); 
}