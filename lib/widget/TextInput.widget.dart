import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:sorteosApp/widget/TextInput.widget.dart';

class TextInput extends StatelessWidget {
  final String placeholder;
  var controller = TextEditingController();
  bool obscureText = false;

  TextInput(this.placeholder, this.controller, this.obscureText);

  Widget build(BuildContext context) {
    return 
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: placeholder),
        ),
      );
    }
}

