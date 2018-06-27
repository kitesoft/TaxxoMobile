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
        _buildLoginArea(),
        _buildPasswordArea()
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

  Widget _buildLoginArea(){
    return new Flexible(
      child: new Padding(
        child: TextField(
          decoration: new InputDecoration(            
            labelText: "Login",            
            icon: new Icon(Icons.person, color: new Color(0xFF828282))
          )
        ),
        padding: new EdgeInsets.only(left: 25.0, right: 30.0),     
      )
    );
  }

    Widget _buildPasswordArea(){
    return new Flexible(
      child: new Padding(
        child: new TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            icon: new Opacity(opacity: 0.0, child: Icon(Icons.person, color: new Color(0xFF828282)))
          ),     
        ),
        padding: new EdgeInsets.only(left: 25.0,right: 30.0), 
      )
    );
  }
 
}