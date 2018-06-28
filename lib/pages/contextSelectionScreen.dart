import 'package:flutter/material.dart';
import '../widgets/themedWidgets.dart';
import '../entities/contextInfo.dart';
import '../services/remoteService.dart';
import '../themes/mainTheme.dart';

class ContextSelectionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new ContextSelectionScreenState();
 
}

class ContextSelectionScreenState extends State<ContextSelectionScreen> {
  RemoteService remoteService;
  List<ContextInfo> contextList;

  ContextSelectionScreenState(){
    remoteService = new RemoteService();
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

  _fetchData() async{
    var list = await remoteService.getContextList();

    this.setState(()=> contextList = list);
  }


  _buildListview(){
    
    var builder = new ListView.builder(
      itemCount: contextList.length,
      itemBuilder: (BuildContext context, int index) => _buildListViewItem(contextList[index]) ,      
    );
    return new Container(
      color: lightBackgroundColor,
      child: builder,
    );
  }
  _buildListViewItem(ContextInfo item){
    var isCurrentSelection = item.id == 10;

    var row = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(item.name),
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
    return new Column(
      children: <Widget>[
        container,
        new Divider(color: new Color(0x19FFFFFF), height: 1.0,)
      ],
    );
  }

  _buildLoadingIndicator(){
    return Center(
      child: new ThemedCircularProgressIndicator() 
    );
  }
}