import 'package:flutter/material.dart';

TextStyle myTextStyle18()
{
  return TextStyle(
    fontSize: 18,
    fontFamily: "serif",
    color: Colors.blueAccent
  );
  
}
TextStyle myTextStyle1()
{
  return TextStyle(
    fontSize: 22,
    fontFamily: "Roboto"
  );
  
}
CardTheme mycard(){
  return const CardTheme(
    color: Colors.white,
    elevation: 5,
    margin: EdgeInsets.all(10),

  );
}