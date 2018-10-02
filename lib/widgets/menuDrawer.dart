import 'package:flutter/material.dart';
import '../themes//mainTheme.dart';
import '../entities/contextInfo.dart';

class MenuDrawer extends StatelessWidget{
  ContextInfo contextInfo;
  
  MenuDrawer(this.contextInfo);

  @override
  Widget build(BuildContext context) {
    var content = new ListView(      
      children: <Widget>[
          _buildHeader(),
          _buildDivider(),
          _buildMenuItem("Wyloguj się"),
          _buildDivider(),
          _buildMenuItem("Zgłoś problem / sugestię"),
          _buildDivider(),
          _buildMenuItem("Polityka prywatności"),
          _buildDivider(),         
      ],      
    );      
    var column = new Column(      
      children: <Widget>[
        new Container(height:  MediaQuery.of(context).size.height - 60.0, child: content),
        _buildLogoWithVersion() 
      ],
    );

    return new Container(child: column, color: lightBackgroundColor);
  }

  Widget _buildHeader(){    
    return new Container(
      padding: new EdgeInsets.fromLTRB(24.0,31.0,0.0,11.0),      
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Welcome", textAlign: TextAlign.left),
          new Text(contextInfo.userName, 
            textAlign: TextAlign.left,             
            style: new TextStyle(
                fontSize: 22.0,
            )
          ),
        ],
      )
    );
  }

  Widget _buildLogoWithVersion(){

    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text("0.0.0.1 Dev"),
        new Image.asset("images/icons/upper_logo.png", height: 32.0, width: 126.0,)
      ],
    );

    return new Container(
      color: lightBackgroundColor,
      child: row,
      padding: new EdgeInsets.fromLTRB(24.0, 0.0, 20.0, 24.0),
    );
  }

  Widget _buildDivider(){
    return new Divider(color: new Color(0x19FFFFFF));
  }

  Widget _buildMenuItem(String text){
    return new Container(
      padding: new EdgeInsets.fromLTRB(24.0,19.0,0.0,19.0),
      child:  new Text(text,  textAlign: TextAlign.left),
    );
  }

}