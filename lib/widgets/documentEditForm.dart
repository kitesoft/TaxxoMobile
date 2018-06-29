import 'package:flutter/material.dart';
import '../entities/document.dart';
import 'package:intl/intl.dart';
import '../themes/mainTheme.dart';
import '../services/remoteService.dart';

class DocumentEditForm extends StatefulWidget {
  final RemoteDocument document;
  final Function(RemoteDocument) onSubmit;
  DocumentEditForm(this.document,this.onSubmit);

  State<StatefulWidget> createState() => new DocumentEditFormState(document,onSubmit);

}


class DocumentEditFormState extends State<DocumentEditForm>{
  final RemoteDocument document;
  final Function(RemoteDocument) onSubmit;
  
  Map<int,String> documentTypes;
  final _formKey = GlobalKey<FormState>();

  DocumentEditFormState(this.document,this.onSubmit){
    documentTypes = new RemoteService().getDocumentTypes();
  }

  @override
  Widget build(BuildContext context) {
    var form = new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[          
          _buildTopInfoRow(),
          _buildDocumentTypeTitle(),
          _buildDocumentTypeRow()
        ],
      ),
    );
    var padding = new Padding(
      child: form,
      padding: new EdgeInsets.only(top: 10.0, bottom: 30.0),
    );

    return new Container(
      height: MediaQuery.of(context).size.height,
      child: new ListView(
        children: <Widget>[
          padding
        ],
      ),
    );
 
   
  }

  Widget _buildTopInfoRow(){
    var dateFormatter = new DateFormat("dd.MM.yyyy");
    
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new SizedBox(width: 70.0),
        new Text(dateFormatter.format(document.creationDate), style: new TextStyle(color: secondaryTextColor ) ),
        new Padding(child: new Text("|", style: new TextStyle(color: secondaryTextColor ) ) ,padding: new EdgeInsets.symmetric(horizontal: 2.0) ),
        new Text(document.createdBy, style: new TextStyle(color: secondaryTextColor ))
      ],
    );
  }

  Widget _buildDocumentTypeTitle(){
    var text = new Text("Typ", textAlign: TextAlign.left, style: new TextStyle(fontSize: 14.0, color: darkGreyTextColor));
    return new Padding(
      child: new Align(
        child: new Container(color: Colors.green,child: text), 
        alignment: Alignment.centerLeft
      ),    
      padding: new EdgeInsets.only(left: 70.0),
    );

    
  }
  Widget _buildDocumentTypeRow(){
    var dropDown = new DropdownButton<int>(        
        hint: new Text("Document type"),      
        value: document.documentType,      
        style: new TextStyle(color: lightGreyTextColor),
        items: documentTypes.keys.toList().map ((int key) {
          return new DropdownMenuItem<int>( 
            value: key,
            child: new Text(documentTypes[key]),
          );
        }).toList(),
        onChanged: (_) { this.setState(()=> document.documentType = _);},
    );
    
    return new ListTile(
      leading: new Icon(Icons.insert_drive_file, color: new Color(0xFF828282)),
      title: dropDown
    );    
  }
}