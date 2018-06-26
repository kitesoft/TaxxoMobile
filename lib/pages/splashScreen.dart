import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: lightBackgroundColor,  
        body: new Center(
          child: new Center(
            child: new Image.asset("images/icons/splashscreen.png"),
          ),
        )
    );
  }
}