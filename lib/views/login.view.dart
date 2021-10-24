import 'package:flutter/material.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 180.0,
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
                    fontSize: 25
                  ),),
                ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuario"),
                )
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
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
    );
  }
}
