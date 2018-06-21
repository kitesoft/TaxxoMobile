import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: const Color.fromARGB(0xFF,0x30,0x30,0x30),  
        body: new Center(
          child: new Center(
            child: new Image.asset("images/icons/splashscreen.png"),
          ),
        )
    );
  }
}