import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeButton extends StatelessWidget {
  final String img;
  final String text;
  final Widget page; 

  HomeButton(this.img, this.text, this.page);

  Widget build(BuildContext context) {
    const lightGrey = Color(0xFFD2D2D2);
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.sp))),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(lightGrey),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Image.asset(
              img,
              width: 70.w,
            ),
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.sp),
          )
        ]),
      ),
    );
  }
}
