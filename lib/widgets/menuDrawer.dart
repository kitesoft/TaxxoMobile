import 'package:flutter/material.dart';
import '../themes//mainTheme.dart';


class MenuDrawer extends StatelessWidget{
  String username;
  
  MenuDrawer(this.username);

  @override
  Widget build(BuildContext context) {        
    var column = new Column(      
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
          _buildHeader(),
          _buildDivider(),
          _buildMenuItem("Wyloguj się"),
          _buildDivider(),
          _buildMenuItem("Zgłoś problem / sugestię"),
          _buildDivider(),
          _buildMenuItem("Polityka prywatności"),
          _buildDivider()
      ],
    );

    return new Container(child: column, color: lightBackgroundColor);
  }

  Widget _buildHeader(){    
    return new Container(
      padding: new EdgeInsets.fromLTRB(24.0,65.0,0.0,11.0),
      child: new Column(
        children: <Widget>[
          new Text("Welcome"),
          new Text(username),
        ],
      )
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