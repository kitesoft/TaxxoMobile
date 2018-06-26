import 'package:flutter/material.dart';


final accentColor = new Color(0xFF00BBA1);
final darkBackgroundColor = new Color(0xFF212121);
final lightBackgroundColor = new Color(0xFF303030);
final yellowAccentColor = new Color(0xFFF0C94A);
final textColor = Colors.white;
final textStyle = new TextStyle(color: Colors.white);
final bottomNavigationBarColor = const Color.fromARGB(0xFF, 0x20, 0x20, 0x20);
final greyIconColor = new Color(0xFF828282);
final appBarColor = new Color(0xFF212121);
final mainTheme = new ThemeData(
  primaryColor: lightBackgroundColor, // light black color 
  accentColor: accentColor, //light green
  textTheme: new TextTheme(
    title: textStyle,
    headline: textStyle,
    subhead: textStyle,
    caption: textStyle,
    body1: textStyle,
    body2: textStyle,
  )
);
