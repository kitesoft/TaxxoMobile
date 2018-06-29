import 'package:flutter/material.dart';
import 'themes/mainTheme.dart';
import 'pages/loadingScreen.dart';
import 'pages/loginScreen.dart';


void main() => runApp(new TaxxoMobile());

class TaxxoMobile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TaxxoMobileState();
}


class TaxxoMobileState extends State<TaxxoMobile>{
  bool isInitialized;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(      
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: isInitialized ? _renderLoginScreen() : _renderLoadingScreen(),
      ),
      theme: mainTheme
    );
  }

  @override
  void initState() {      
      super.initState();
      setState(() { 
        isInitialized = false;
      });
  }

  void onInitialized(){
    setState(()=> isInitialized = true);
  }

  Widget _renderLoadingScreen(){
    return new LoadingScreen(onInitialized);
  }

  Widget _renderLoginScreen(){
    return new LoginScreen();
  }
}







