import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../widgets/bottomContextSelectionBar.dart';
import '../services/remoteService.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../widgets/themedWidgets.dart';
import '../themes/mainTheme.dart';
import '../pages/documentPreviewScreen.dart';


class DocumentListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new DocumentListScreenState();
} 



class DocumentListScreenState extends State<DocumentListScreen>{
  List<RemoteDocument> documents;
  bool isLoading;
  RemoteService remoteService;

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: appBarColor,
          title: new Text("Ostatnie skany"),
        ),
        floatingActionButton: _buildAddButton(),
        backgroundColor: lightBackgroundColor,
        bottomNavigationBar: new BottomContextSelectionBar(),
        body: _buildBody()
      );
  }

  Widget _buildAddButton(){
    return new FloatingActionButton(
      backgroundColor: yellowAccentColor,
      onPressed: () => {},
      foregroundColor: Colors.white,
      child: new Icon(Icons.add),
      heroTag: "addDocumentButton",
    );
  }

  _goToDocumentPreviewScreen(RemoteDocument document){
    Navigator.push(context, MaterialPageRoute(builder: (context) => new DocumentPreviewScreen(document) ));
  }

  Widget _buildBody(){
    if(isLoading) return new Center(
      child: new Container(
        width: 40.0,
        height:40.0,
        child: new ThemedCircularProgressIndicator()
      )
    );

    return new RefreshIndicator(
      child:_buildGrid(),
      onRefresh: _fetchData,
      color: accentColor,
    );

  }


  Future<Null> _fetchData() async {
      var fetchedDocuments = await remoteService.fetchDocuments();
      setState(() {
        documents = fetchedDocuments;
        isLoading = false;
      });
      
      return null;
  }  
  
  @override
  void initState() {      
      super.initState();
      isLoading = true;      
      remoteService = new RemoteService();
      _fetchData();
    }

  Widget _buildGrid(){
    if(documents == null) return new Container();

    final orientation = MediaQuery.of(context).orientation;
    var grid = new GridView.count(        
        crossAxisCount: (orientation == Orientation.portrait) ? 1: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (orientation == Orientation.portrait) ? 2.2 : 2.2,
        padding: const EdgeInsets.all(25.0),
        children: documents.map( (doc) => _buildGridItem(doc)).toList(),
      );

    return grid;
  }

  Widget _buildGridItem(RemoteDocument document){    

    var row = new Row(
      children: <Widget>[
        new Expanded(
          child: new GestureDetector(
            child: _buildLeftSide(document),
            onTap: ()=> _goToDocumentPreviewScreen(document),
          )
        ),        
        new Expanded(child: _buildRightSide(document))
      ],
    );    
    return new Container(
      child: row,
      color:  Colors.black,
    );

 
  }

  Widget _buildLeftSide(RemoteDocument document){
    var uniqueId = document.hashCode;
    var stack = new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Center(
          child: new ThemedCircularProgressIndicator()
        ),
        new Image.network(document.thumbnailURL, fit: BoxFit.fitWidth),  
        new Positioned(
          bottom: 10.0,
          right: 10.0,
          child: new FloatingActionButton(
            onPressed: () => _goToDocumentPreviewScreen(document), 
            mini: true,
            heroTag: 'previewButton_$uniqueId',
            backgroundColor: new Color(0xFF6b6b6b),
            child: new Icon(Icons.search, color: Colors.white),
          ),
        )
      ],
    );
    return new Container(
      child: stack,
      height: 150.0 ,
      color: new Color(0xFF5b5b5b),
    );   
  }

  Widget _buildRightSide(RemoteDocument document){
      return new Container(
           height: 150.0,
           width: 160.0,
           child: _buildDetailsBox(document),
           color: Colors.black
      );
  }
  Widget _buildDetailsBox(RemoteDocument document){

    var uniqueId = document.hashCode;


    var accPeriodFormatter = new DateFormat('MMM yyyy');  
    var accPeriodFormatted = accPeriodFormatter.format(document.accPeriod);
    
    var creationDateFormatter = new DateFormat('dd.MM.yyyy');
    var creationDateFormatted = creationDateFormatter.format(document.creationDate);

    var detailsRow = new Row(
        children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,              
              children: <Widget>[
                new Text(document.documentNumber, style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text(accPeriodFormatted, style: new TextStyle(inherit: false),textAlign: TextAlign.left),                
                new Text(creationDateFormatted, style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text(document.createdBy, style: new TextStyle(inherit: false),textAlign: TextAlign.left),
              ],
            )
        ]
    );

    var documentStatusIcons = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,      
      mainAxisSize: MainAxisSize.min,      
      children: <Widget>[
        new Icon(Icons.monetization_on, color: (document.isPaid ? yellowAccentColor : greyIconColor), size: 15.0,),
        new Icon(Icons.check_circle, color: (document.isAccepted ? yellowAccentColor : greyIconColor), size: 15.0),
        new Icon(Icons.local_offer, color: (document.tags.length > 0 ? yellowAccentColor : greyIconColor), size: 15.0)        
      ],
    );

    var editButton = new FloatingActionButton(
           heroTag: "editDocumentButton_$uniqueId",
           mini: true,
           backgroundColor: new Color(0x19000000),
           child: new Icon(Icons.create, color: Colors.white),
    );

    var bottomRow = new Row(      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
         new Container(child: documentStatusIcons, width: 60.0,),
         editButton             
      ],
    );


    var innerContainer = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          detailsRow,
          bottomRow
        ]
      )
    );          

    return new Container(
      color: new Color(0xFF5b5b5b),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(17.0,12.0,11.0,11.0),
        child: innerContainer,
      ),
    );
  }

}