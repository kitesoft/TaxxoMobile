import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../widgets/themedWidgets.dart';
import '../themes/mainTheme.dart';
import 'package:photo_view/photo_view.dart';

class NewDocumentUploadScreen extends StatefulWidget{
  final LocalDocument document;
  NewDocumentUploadScreen(this.document);
  @override
  State<StatefulWidget> createState() => new NewDocumentUploadScreenState();
}



class NewDocumentUploadScreenState extends State<NewDocumentUploadScreen>{
  LocalDocument currentDocument;
  bool isSending;
  int sendingStatus; //Not sure about usage 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: appBarColor,
      ),
      body: new Stack(
        children: <Widget>[
          new Container(color: new Color(0xFF303030)), // background
          _buildBackgroundImage(),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child:Align(alignment: Alignment.topCenter , child:_buildProgressBar())
          ),
          new Positioned(
            child: _buildDetailsBox(),
            left: 10.0,
            bottom: 10.0,
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(){
    return new PhotoView(
      imageProvider: new MemoryImage(currentDocument.pages.first.data),
      minScale: PhotoViewComputedScale.contained * 1.0
    );  
  }

  Widget _buildProgressBar(){
    var content = new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[       
          new Text("Wysyłanie"),
          new Padding(
            child: new Container(
              height: 12.0,
              width: 12.0, 
              child: new ThemedCircularProgressIndicator(strokeWidth: 1.0),
            ),
            padding: new EdgeInsets.only(left:8.0),
          )                        
        ],
    );
    
    return new Container(      
      decoration: new BoxDecoration(
        color: darkBackgroundColor,
        borderRadius: new BorderRadius.all( const Radius.circular(40.0))
      ),
      child: new Padding(child: content, padding: new EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),) 
    );
  }  

  Widget _buildDetailsBox(){
    var pageCount = currentDocument.pages.length;

    var detailsRow = new Row(
        children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,              
              children: <Widget>[
                new Text("Faktura", style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text("Strony: $pageCount", style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text("przesłano:", style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text("21.12.2018", style: new TextStyle(inherit: false),textAlign: TextAlign.left),
                new Text("Użytkownik Janusz", style: new TextStyle(inherit: false),textAlign: TextAlign.left),
              ],
            )
        ]
    );

    var documentStatusIcons = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,      
      children: <Widget>[
        new Icon(Icons.monetization_on, color: currentDocument.isPaid ? yellowAccentColor : greyIconColor ),
        new Icon(Icons.check_circle, color: currentDocument.isAccepted ? yellowAccentColor : greyIconColor ),
        new Icon(Icons.local_offer, color: currentDocument.tags.length > 0 ? yellowAccentColor : greyIconColor )        
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
         new Container(width: 90.0,child: documentStatusIcons),
         editButton             
      ],
    );


    var innerContainer = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          detailsRow,
          bottomRow
        ]
      )
    );          

    return new Container(
      height: 153.0,
      width: 226.0,
      color: new Color(0xFF5b5b5b),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(17.0,12.0,11.0,11.0),
        child: innerContainer,
      ),
    );
  }

  @override
  void initState() {      
      super.initState();
      currentDocument = widget.document;
    }
}