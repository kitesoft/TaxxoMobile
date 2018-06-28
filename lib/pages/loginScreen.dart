import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';



class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    var column = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLogo(),
        _buildTextEntry(true,"Login"),
        _buildTextEntry(false,"Password")
      ],
    );

    return new Scaffold(
      body: new SafeArea(child: column,), 
      backgroundColor: lightBackgroundColor,
    );
  }

  Widget _buildLogo(){
    return new Image.asset("images/icons/upper_logo.png", height: 50.0, width: 200.0, );
  }


  

  Widget _buildTextEntry(bool showIcon,String label){
    return new Flexible(
      child: new Padding(
        child: TextField(
          style: new TextStyle(fontSize: 18.0, color: new Color(0xFFA0A0A0)),
          decoration: new InputDecoration(            
            labelText: label != null ? label : null,
            labelStyle: label != null ? TextStyle(color: new Color(0xFF757576)) : null, 
            isDense: false,                                   
            icon: new Opacity(
               child: Padding(child: new Icon(Icons.person, color: new Color(0xFF828282)), padding: new EdgeInsets.only(top: 13.0) ),
               opacity: showIcon ? 1.0 : 0.0,
            )
          ),
          
        ),
        padding: new EdgeInsets.only(left: 25.0, right: 30.0),     
      )
    );
  }


}