import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../widgets/contextSelectionFooter.dart';
import '../services/remoteService.dart';


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
        body: new Padding(
          child: _buildListView(),
          padding: new EdgeInsets.fromLTRB(25.0,25.0,25.0,0.0),
        ),
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

  Widget _buildListView(){   
    var listBuilder = new ListView.builder(
      itemBuilder: _buildListItem,
      itemCount: documents?.length ?? 0,            
    );

    return documents != null ? listBuilder : new Container();
  }

  Widget _buildListItem(BuildContext buildingContext, int index){
    var document = documents[index];
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(child:_buildLeftSide(document)),
        _buildRightSide(document)
      ],
    );    
    return new Container(
      child: row,
      padding: new EdgeInsets.only(bottom: 10.0),
    );
  }

  Widget _buildLeftSide(Document document){
    var stack = new Stack(
      children: <Widget>[
        new Image.memory(document.thumbnail.data, width: 400.0,height: 400.0,),
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
      color: new Color(0xFF5b5b5b),
    );   
  }

  Widget _buildRightSide(Document document){
    return new Expanded(
      child:
         new Container(
           child: bottomRow(),
           color: Colors.black,
         ),            
    );
  }

  documentStatusIcons() =>  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,      
      children: <Widget>[
        new Icon(Icons.monetization_on, color: Colors.white,),
        new Icon(Icons.check_circle, color:  Colors.white,),
        new Icon(Icons.local_offer, color:  Colors.white,)        
      ],
    );

  editButton() => new FloatingActionButton(
           heroTag: "editDocumentButton",
           mini: true,
           backgroundColor: new Color(0x19000000),
           child: new Icon(Icons.create, color: Colors.white),
    );

  bottomRow() => new Row(      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
         new Container(width: 90.0,child: documentStatusIcons()),
         editButton()             
      ],
    );

}