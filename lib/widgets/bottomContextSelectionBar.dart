import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';

class BottomContextSelectionBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      color: bottomNavigationBarColor,
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(16.0,19.0,16.0,16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[          
            new Text("Nazwa klienta"),
            new Icon(Icons.arrow_drop_down, color: Colors.white)
          ],
        )
      )
    );
  }

}
