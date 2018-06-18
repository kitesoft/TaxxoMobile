import 'package:flutter/material.dart';

class LoadingScreenPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new LoadingScreenPageState();    

} 

class LoadingScreenPageState extends State<LoadingScreenPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.black,
      child:Image.asset("images/icons/splashscreen.png")
    );
  }

}
