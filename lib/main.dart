import 'dart:async';
import "package:flutter/material.dart";

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _App();
  }
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 180.0,
            decoration: const BoxDecoration(color: Colors.amber),
            child: Image.asset("assets/main-logo.png"),
          ),
          Column(
            children: <Widget>[
              Text("INICIA SESION"),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuario"),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contraseña"),
              ),
              ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  child: Text("Iniciar Sesión")),
              GestureDetector(
                child: Text("Registrate", 
                style: TextStyle(decoration: TextDecoration.underline)),
                onTap: (){},
              )
            ],
          ),
        ]),
      ),
    );
  }
}
