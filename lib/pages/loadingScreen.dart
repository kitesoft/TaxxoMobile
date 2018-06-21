import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new LoadingScreenState();    

} 

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.black,
      child:Image.asset("images/icons/splashscreen.png")
    );
  }

}
