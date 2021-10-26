import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login();
  }
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => MaterialApp(
        home: Scaffold(
          body: SafeArea(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 150.0,
              decoration: const BoxDecoration(color: Colors.amber),
              child: Image.asset("assets/main-logo.png"),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: Text("INICIA SESION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp
                    ),),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5),
                  child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuario"),
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10.0),
                  child: ElevatedButton(
                         onPressed: (){},
                         style: ElevatedButton.styleFrom(
                           primary: Colors.amber[400],
                           padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                           textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                         ),
                         child: Text("Iniciar Sesión",
                          style: TextStyle(
                            color: Colors.black
                          ),),
                        )
                  ),
                GestureDetector(
                  child: Text("Registrate",
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline),),
                  onTap: (){},
                )
              ],
            ),
          ]),
        ),
        ),
      ),
    );
  }
}
