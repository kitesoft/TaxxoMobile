import 'package:flutter/material.dart';
import '../entities/document.dart';
import 'package:intl/intl.dart';
import '../themes/mainTheme.dart';
import '../services/remoteService.dart';
import '../widgets/formControls/accPeriodField.dart';

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
          new SizedBox(height: 33.0),
          _buildDocumentTypeRow(),    
          _buildAccPeriodRow()      
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


  Widget _buildFormField(Widget editor, String title, [IconData leadingIcon]){

    var tile = new ListTile(      
      leading: new Opacity(
        child: Icon(leadingIcon, color: new Color(0xFF828282)),
        opacity: leadingIcon != null ? 1.0 : 0.0,
      ), 
      title: editor
    );    

    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Padding(
          child: new Text(title, style: new TextStyle(fontSize: 14.0, color: secondaryTextColor)),
          padding: new EdgeInsets.only(left: 72.0),
        ),
        tile
      ],
    );


    return new Padding(
      child: column,
      padding: new EdgeInsets.only(right: 30.0)
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
    
    return _buildFormField(dropDown, "Typ",Icons.insert_drive_file);
  }

  Widget _buildAccPeriodRow(){    
    var field = new AccPeriodField(document.accPeriod);
    return _buildFormField(field, "Okres",);
  }
}