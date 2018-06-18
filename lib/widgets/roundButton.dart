import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{
  RoundButton({@required Icon icon}) { _icon = icon; }  
  Icon _icon;
  @override
  Widget build(BuildContext context) {
    return new Center (
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(0x19, 0x00, 0x00, 0x00)
        ),
        child: new Center(
          child: _icon
        ),
      ) 
    );
  }
}