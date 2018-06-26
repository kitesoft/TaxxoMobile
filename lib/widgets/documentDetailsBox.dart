import 'package:flutter/material.dart';
import '../entities//document.dart';
import '../themes/mainTheme.dart';

class DocumentDetailBox extends StatelessWidget {
  final RemoteDocument document;
  final VoidCallback onButtonPressed;

  DocumentDetailBox(this.document,this.onButtonPressed);

  @override
  Widget build(BuildContext context) { 
    return new Stack(
      children: <Widget>[
        _buildBackground(),
        _buildContent(),
        _buildToggleButton()
      ],
    );
  }

  Widget _buildToggleButton(){
    return new Positioned(
      right: 5.0,
      top: 5.0,
      child: new GestureDetector(
        onTap: onButtonPressed,
        child: new Icon(Icons.close, color: Colors.white)
      )
    );
  }

  Widget _buildBackground(){
    return new Container(color: lightBackgroundColor,width: 226.0, height: 112.0,);
  }

  Widget _buildContent(){ 
    var content = new Container(

    );       
    
    return new Padding(
      padding: new EdgeInsets.fromLTRB(17.0,11.0,11.0,11.0),      
      child: content,
    );
  }
}