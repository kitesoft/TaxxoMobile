import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../widgets/contextSelectionFooter.dart';
import '../services/remoteService.dart';
import 'package:intl/intl.dart';


class DocumentListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new DocumentListScreenState();
} 



class DocumentListScreenState extends State<DocumentListScreen>{
  List<Document> documents;
  bool isLoading;
  RemoteService remoteService;

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Ostatnie skany"),
        ),
        backgroundColor: new Color(0xFF303030),
        bottomNavigationBar: new ContextSelectionFooter(),
        body: _buildGrid()
      );
  }
  
  @override
  void initState() {      
      super.initState();
      isLoading = true;      
      remoteService = new RemoteService();
      
      remoteService.fetchDocuments().then((docs){
        setState(() {
          documents = docs;
          isLoading = false;
        });
      });
    }

  Widget _buildGrid(){
    if(documents == null) return new Container();

    final orientation = MediaQuery.of(context).orientation;
    var grid = new GridView.count(        
        crossAxisCount: (orientation == Orientation.portrait) ? 1: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (orientation == Orientation.portrait) ? 2.1 : 2.2,
        padding: const EdgeInsets.all(25.0),
        children: documents.map( (doc) => _buildGridItem(doc)).toList(),
      );

    return grid;
  }

  Widget _buildGridItem(Document document){    

    var row = new Row(
      children: <Widget>[
        new Expanded(child: _buildLeftSide(document)),
        new Expanded(child: _buildRightSide(document))
      ],
    );    
    return new Container(
      child: row,
      color:  Colors.black,
    );
  }

  Widget _buildLeftSide(Document document){
    var stack = new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Center(
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(new Color(0xFF00bba1)),
          ),
        ),
        new Image.network(document.thumbnailURL, fit: BoxFit.fitWidth),  
        new Positioned(
          bottom: 10.0,
          right: 10.0,
          child: new FloatingActionButton(
            mini: true,
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

  Widget _buildRightSide(Document document){
      return new Container(
           height: 150.0,
           width: 160.0,
           child: _buildDetailsBox(document),
           color: Colors.black
      );
  }
  Widget _buildDetailsBox(Document document){
    Color activeStatusColor = new Color(0xFFF0C94A);
    Color inactiveStatusColor = new Color(0xFF979797);

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
        new Icon(Icons.monetization_on, color: document.isPaid ? activeStatusColor : inactiveStatusColor, size: 15.0,),
        new Icon(Icons.check_circle, color: document.isAccepted ? activeStatusColor : inactiveStatusColor,size: 15.0),
        new Icon(Icons.local_offer, color: document.tags.length > 0 ? activeStatusColor : inactiveStatusColor,size: 15.0)        
      ],
    );

    var editButton = new FloatingActionButton(
           heroTag: "editDocumentButton",
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