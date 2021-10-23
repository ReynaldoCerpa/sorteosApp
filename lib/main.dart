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
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: new BoxDecoration(color: Colors.amber),
            child: Image.asset("assets/main-logo.png"),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text("Add product"),
              onPressed: () {},
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(25.0),
                    child: Image.asset("assets/testimg.jpg")),
                Text("Boletos")
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

