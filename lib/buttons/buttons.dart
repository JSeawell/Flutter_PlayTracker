import 'package:flutter/material.dart';

Widget RoundedButton(BuildContext context, String label, double width, double height, double font_size, double radius, Widget screen){
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: RaisedButton(
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: font_size),
          textAlign: TextAlign.center,
          ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        splashColor: Colors.green,
      ),
    ),
  );
}