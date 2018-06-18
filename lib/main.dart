import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'themes/mainTheme.dart';

void main() => runApp(new TaxxoMobile());

class TaxxoMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(      
      home: new HomePage(),
      theme: mainTheme
    );
  }
}







