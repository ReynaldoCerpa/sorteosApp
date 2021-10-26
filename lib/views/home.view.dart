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
            backgroundColor: Colors.amber,
            leading: Image.asset("assets/main-logo.png",width: 60.w),
            actions: [
              Wrap(
                alignment: WrapAlignment.end,
                children: [
                  Text("Nombre de usuario",
                  style: TextStyle(
                    backgroundColor: Colors.black
                  ),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings),)
                ],
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                  homeButtons(context, "assets/main-logo.png", "Vender boletos"),
                  homeButtons(context, "assets/main-logo.png", "Agregar abono"),
                  homeButtons(context, "assets/main-logo.png", "Carteras"),
              ],
            ),
          )
          // body: SafeArea(
          //   child: ,
          // ),
        ),
      ),
    );
  }
}

Widget homeButtons(BuildContext context, String img, String text){
  return new Container(
    child: ElevatedButton(
      onPressed: () {  },
      child: Wrap(
        children: [
          Image.asset(img, width: 10.w,),
          Text(text)
        ]
      ),)
  );
}