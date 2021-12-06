import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:sorteosApp/pages/home.view.dart';
import 'package:sorteosApp/pages/recuperarContrasena.view.dart';
import 'package:sorteosApp/pages/register.view.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;


class Album {
  final String idColaborador;
  final String nombre;

  Album({required this.idColaborador, required this.nombre});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      idColaborador: json['idColaborador'],
      nombre: json['nombre'],
    );
  }
}



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}


class _Login extends State<Login> {

  Future<Album> createAlbum() async {
    final response = await http.post(
      Uri.parse('https://192.168.1.133:3000/logininfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username.text,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<Album>? _futureAlbum;


  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombre);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        globals.id = snapshot.data!.idColaborador.toString();
        return const CircularProgressIndicator();
      },
    );
  }



  final username = TextEditingController();
  final password = TextEditingController();
  final log = TextEditingController();
  late String idColaborador  = "";

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
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
                    child: Text(
                      "INICIA SESION",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5),
                      child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Usuario"),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contraseña"),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10.0),
                      child: SizedBox(
                        width: 200.w,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () async {

                            var hola = buildFutureBuilder();
                            createAlbum();
                          
                            var res = await sendLogin(username.text, password.text);
                            print("Print res ->");
                            print(res.body);
                            if(res.body == "true"){
                              print("cuenta valida");
                              print(idColaborador);
                              data(context, username.text);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Verificar Datos'),
                                      content: setupAlertDialoadContainer(username.text),
                                    );
                                  });
                            } else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context){
                                return AlertDialog(
                                  title: Container(
                                    child: Text("Datos incorrectos",
                                    textAlign: TextAlign.center,),
                                    ),
                                  actions: [],
                                  );
                                });
                              print("incorrect account");
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.sp)
                              )
                            ),
                            foregroundColor: MaterialStateProperty.all(Colors.black),
                            backgroundColor: MaterialStateProperty.all(Colors.amber),
                          ),
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),  
                  GestureDetector(
                    child: Text(
                      "Regístrate",
                      style: TextStyle(
                          fontSize: 20, decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterColaborador()),
                                );
                    },
                  ),
                ],
              ),
              Expanded(child: Container(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  child: Text(
                    "Recuperar contraseña",
                    style: TextStyle(
                        fontSize: 20, decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecuperarContrasena()),
                    );
                  },
                ),))
            ]),
          ),
        ),
      ),
    );
  }
}

sendLogin(String username, String password) async {
  final url = Uri.parse("http://192.168.1.133:3000/login");
  final data = {"username": username, "password": password};
  final res = await post(url, body: data);

  print("log to the console from post request");
  print(res.body);
  return res;
}


Future<List> _loadData(String usuario) async {
  List posts = [];
  try {
    final body = {
      'username': usuario,
    };
    final jsonString = json.encode(body);
    final uri = Uri.http('192.168.1.133:3000', '/logininfo');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonString);
    posts = jsonDecode(response.body);
    print(posts);
  } catch (err) {
    print(err);
  }
  return posts;
}

Widget data(BuildContext context, String usuario) {
  print("hola");
  return FutureBuilder(
      future: _loadData(usuario),
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
      snapshot.hasData
          ? ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, index) =>
            SizedBox(
              child: Text(snapshot.data![index]
            ['idColaborador']
                .toString()),
            ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ));
}



Widget setupAlertDialoadContainer(String username) {
  return Container(
    height: 200.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: FutureBuilder(
        future: _loadData(username),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
        snapshot.hasData
            ? ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, index) =>
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tu Id de colaborador es:"
                        .toString(),
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight:
                            FontWeight
                                .w700,
                            color: Colors
                                .black)),
                    Text("#"+snapshot.data![index]
                    ['idColaborador']
                        .toString(),
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight:
                            FontWeight
                                .w700,
                            color: Colors
                                .black)),
                    SizedBox( height: 10.h,),
                    Text("El nombre registrado es:"
                        .toString(),
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight:
                            FontWeight
                                .w700,
                            color: Colors
                                .black)),
                    Text(snapshot.data![index]
                    ['nombre']
                        .toString(),
                        style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight:
                        FontWeight
                            .w700,
                        color: Colors
                            .black)),
                    Padding(padding: EdgeInsets.only(top: 10.h),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home(idColaborador: snapshot.data![index]
                          ['idColaborador']
                              .toString())),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.sp))),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          "Entrar",
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.sp),
                        )
                      ]),
                    ),),
                  ],
                ),
              ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ))
  );
}
