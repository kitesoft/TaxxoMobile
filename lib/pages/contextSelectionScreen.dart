import 'package:flutter/material.dart';
import '../widgets/themedWidgets.dart';
import '../entities/contextInfo.dart';
import '../services/remoteService.dart';
import '../themes/mainTheme.dart';
import '../services/authService.dart';
import 'dart:async';

class ContextSelectionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new ContextSelectionScreenState();
 
}

class ContextSelectionScreenState extends State<ContextSelectionScreen> {
  RemoteService remoteService;
  List<ContextInfo> contextList;
  ContextInfo contextInfo; 


  ContextSelectionScreenState(){
    remoteService = new RemoteService();
    contextInfo = AuthService.instance.currentContext;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Wybierz firmę"),
      ),
      body: contextList == null ? _buildLoadingIndicator() : _buildListview(),
    );
  }

  @override
  void initState() {      

      super.initState();
      _fetchData();      
  }

   Future<Null> _fetchData() async{
    var list = await remoteService.getContextList();    
    this.setState(()=> contextList = list);
  }


  _buildListview(){
    
    var builder = new ListView.builder(
      itemCount: contextList.length,
      itemBuilder: (BuildContext context, int index) => _buildListViewItem(contextList[index]) ,      
    );
    var container = new Container(
      color: lightBackgroundColor,
      child: builder,
    );
  
    return new RefreshIndicator(
      child: container,
      onRefresh: _fetchData,
      color: accentColor,
    );
  }
  _buildListViewItem(ContextInfo item){
    var isCurrentSelection = item.customerName == this.contextInfo.customerName; // TODO Change to ID 

    var row = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(item.customerName),
        new Opacity(
          child: new Icon(Icons.check,color: Colors.white),
          opacity: isCurrentSelection ? 1.0 : 0.0,
        )
      ],
    );

    var container = new Container(
      height: 56.0,
      color: isCurrentSelection ? accentColor : null,
      child: new Padding(
        child: row,
        padding: new EdgeInsets.fromLTRB(24.0, 19.0, 24.0, 17.0),
      ),
    );
    var column = new Column(
      children: <Widget>[
        container,
        new Divider(color: new Color(0x19FFFFFF), height: 1.0,)
      ],
    );

    return new GestureDetector(
      child:  new Container(child: column, color: Colors.transparent),
      onTap: (){
        item.userName = AuthService.instance.currentContext.userName;
        AuthService.instance.currentContext = item;
        this.setState( ()=> contextInfo = item);
        Navigator.pop(context, item);
      },
    );

  }

  _buildLoadingIndicator(){
    return Center(
      child: new ThemedCircularProgressIndicator() 
    );
  }
}