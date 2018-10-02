import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';
import '../widgets/themedWidgets.dart';
import '../services/remoteService.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget{
  VoidCallback onInitialized;

  LoadingScreen(this.onInitialized);

  @override
  State<StatefulWidget> createState() => new LoadingScreenState(onInitialized);    

} 

class LoadingScreenState extends State<LoadingScreen> {

  LoadingScreenState(this.onInitialized){
    isWorking = true;
  }
  bool isWorking;
  String notificationText;
  VoidCallback onInitialized;

  @override
  void initState() {
      super.initState();
      this.setState((){
        isWorking = true;
        notificationText = "Loading";
      });
      _initialize();
  }

  @override
  Widget build(BuildContext context) {
    var column =  new Column(      
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildUpperLogo(),
        _visibilityWrapper(_buildLoadingIndicator(), isWorking == true),
        _buildNotificationBox(),
        _visibilityWrapper(_buildRefreshButton(), isWorking == false)
      ],
    );

    var container = new Container(
      child: new SafeArea(child:column),
      color: lightBackgroundColor,
    );

    return container;
  }

  Widget _buildUpperLogo(){
    return new Padding(
      padding: new EdgeInsets.only(top: 0.0),      
      child: new Center(
        child: Image.asset("images/icons/splashscreen.png", width: 133.0, height: 133.0,)
      ) 
    );
  }

  Widget _buildLoadingIndicator(){    
    return new ThemedCircularProgressIndicator();
  }    

  Widget _buildNotificationBox(){
    return new Center(
      child: new Container(      
        decoration: new BoxDecoration(
            color: const Color.fromARGB(0x8c, 0x21, 0x21, 0x21),
            borderRadius: new BorderRadius.all( const Radius.circular(40.0))
          ),
        child: new Padding(
          child: new Text(notificationText, style: new TextStyle(inherit: false, fontSize: 18.0)), 
          padding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 56.0),) 
      ),
    );
  }

  Widget _buildRefreshButton(){
    var button = new Icon(Icons.cached, color: accentColor);
    var label = new Text("Odśwież", style: new TextStyle(color: accentColor, fontSize: 14.0, inherit: false ));
    var column = new Column(
      children: <Widget>[
        new RotatedBox(child: button, quarterTurns: 1,),
        new SizedBox(height: 10.0,),
        label
      ],
    );
    return new GestureDetector(
      child: column,
      onTap: () async => await _initialize(),
    );   
  }

  Widget _visibilityWrapper(Widget widget, bool condition){
    return new Opacity(
      opacity: condition ?  1.0 : 0.0,
      child: widget,
    );
  }

  _initialize() async {
    this.setState((){
        isWorking = true;
        notificationText = "Loading";
    });
    
    var service = new RemoteService();
    
    this.setState(()=> notificationText = "Sprawdzanie połączenia z internetem...");

    var hasInternet = await service.isNetworkEnabled();
    if(!hasInternet){
      this.setState((){
        notificationText = "Brak połaczenia z internetem";
        isWorking = false;
      });
      return;
    } 

    this.setState(()=> notificationText = "Sprawdzanie stanu serwerów...");

    var isServerOnline = await service.isServerOnline();
    if(!isServerOnline){
      this.setState((){
        notificationText = "Brak połaczenia z internetem";
        isWorking = false;
      });
      return;
    }

    onInitialized();

  }
}
