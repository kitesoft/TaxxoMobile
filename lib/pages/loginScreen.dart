import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';
import '../widgets/themedWidgets.dart';
import 'dart:async';
import '../services/remoteService.dart';
import '../pages/homeScreen.dart';


class LoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new LoginScreenState(false);
}


class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool isLoggedIn;
  bool isLoginInProgress;
  RemoteService remoteService;

  LoginScreenState(this.isLoggedIn){
    isLoginInProgress = false;
    remoteService = new RemoteService();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var column = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildLogo(),
        new SizedBox(height: 17.0),
        _buildTextEntry(true,"Login",_loginController),
        new SizedBox(height: 17.0),
        _buildTextEntry(false,"Password",_passwordController),
        new SizedBox(height: 30.0),
        isLoginInProgress ? _buildLoginIndicator() :  _buildLoginButton(),
        new SizedBox(height:34.0),
        _buildActionsRow()
      ],
    );

    if(orientation == Orientation.landscape){
      return new Scaffold(
        body: new SafeArea(
          child: new ListView(
            children: <Widget>[
              new Container(height: 400.0, child: column, )
            ],
          ) 
        ), 
        backgroundColor: lightBackgroundColor,
      );  
    }

    return new Scaffold(
      body: new SafeArea(child: column,), 
      backgroundColor: lightBackgroundColor,
    );
  }

  Widget _buildLogo(){
    return new Image.asset("images/icons/upper_logo.png", height: 50.0, width: 200.0, );
  }

  Widget _buildLoginIndicator(){    
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          new Text("Trwa logowanie"),
          new SizedBox(width: 20.0),
          new ThemedCircularProgressIndicator(),          
      ],
    );
    return new Container(
      child: row,
      height: 65.0,
    );
  }

  Future<Null> _executeLogin() async{
    FocusScope.of(context).requestFocus(new FocusNode());
    Scaffold.of(context).removeCurrentSnackBar();
    this.setState(()=> isLoginInProgress = true);
    var result = await remoteService.logIn(_loginController.text, _passwordController.text);
    this.setState(()=> isLoginInProgress = false);
    if(result != null){
      var snackbar = new SnackBar(
        content: new Text(result),
        backgroundColor: darkBackgroundColor,
        duration: new Duration(seconds: 25),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } else{
       var homeScreenRoute = new MaterialPageRoute(builder: (context) => new HomeScreen());
       Navigator.pushAndRemoveUntil(context, homeScreenRoute,  (Route<dynamic> route) => false);
    }
  }

  Widget _buildLoginButton(){
    var button = new MaterialButton(
      color: accentColor,
      height: 65.0,   
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () async => _executeLogin(),
      textColor: Colors.white,      
      child: new Text("Login"),
    );

    var container = new Container(
      decoration: new BoxDecoration(
        color: accentColor,
        borderRadius: new BorderRadius.all( const Radius.circular(10.0))
      ),
      child: button,
    );

    var paddingContainer = new Padding(
      child:container,
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
    );
    

    return new GestureDetector(
      child: paddingContainer,
      onTap: ()=> debugPrint("Login clicked"),
    );  
  }
  
  Widget _buildActionsRow(){
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Zarejestruj się"),
        new Padding(
          child: new Text("|"),
          padding: new EdgeInsets.symmetric(horizontal: 20.0),
        )
        ,
        new Text("Resetuj hasło")
      ],
    );  
  }


  Widget _buildTextEntry(bool showIcon,String label, TextEditingController controller){
    return new Flexible(
      child: new Padding(
        child: TextField(
          controller: controller,
          style: new TextStyle(fontSize: 18.0, color: new Color(0xFFA0A0A0)),
          decoration: new InputDecoration(     
            border: UnderlineInputBorder(borderSide: BorderSide(color: hintColor)),       
            labelText: label != null ? label : null,
            labelStyle: label != null ? TextStyle(color: secondaryTextColor) : null, 
            isDense: false,                                                           
            icon: new Opacity(
               child: Padding(child: new Icon(Icons.person, color: new Color(0xFF828282)), padding: new EdgeInsets.only(top: 16.0) ),
               opacity: showIcon ? 1.0 : 0.0,
            )
          ),
          
        ),
        padding: new EdgeInsets.only(left: 25.0, right: 30.0),     
      )
    );
  }


}