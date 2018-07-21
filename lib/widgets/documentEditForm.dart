import 'package:flutter/material.dart';
import '../entities/document.dart';
import 'package:intl/intl.dart';
import '../themes/mainTheme.dart';
import '../services/remoteService.dart';
import '../widgets/formControls/accPeriodField.dart';
import '../widgets/formControls/documentTypeField.dart';
import '../widgets/formControls/tagsField.dart';
import '../widgets/themedWidgets.dart';


import 'dart:convert';

class DocumentEditForm extends StatefulWidget {
  final RemoteDocument document;
  final Function(RemoteDocument) onSubmit;
  DocumentEditForm(this.document,this.onSubmit);

  State<StatefulWidget> createState() => new DocumentEditFormState(document,onSubmit);

}


class DocumentEditFormState extends State<DocumentEditForm>{
  RemoteDocument document;
  final Function(RemoteDocument) onSubmit;
  bool isSaving;
  final _formKey = GlobalKey<FormState>();

  DocumentEditFormState(this.document,this.onSubmit){
    this.document = new RemoteDocument.cloned(this.document);
    this.isSaving = false;
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
          _buildAccPeriodRow(),
          _buildTagsRow(),
          new SizedBox(height: 28.0),
          new Divider(color:lightGreyTextColor),
          _buildMarkAsPaidRow(),
          new Divider(color: lightGreyTextColor),
          _buildMarkAsAcceptedRow(),
          new SizedBox(height: 30.0),
          this.isSaving ? _buildSavingIndicator() :  _buildSaveButton()      
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

  Widget _buildRow(Widget editor, String title, [IconData leadingIcon]){
    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(title, style: new TextStyle(fontSize: 14.0, color: secondaryTextColor)),
        editor
      ],
    );

    var row = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(width: 75.0,
          child: leadingIcon != null ? Icon(leadingIcon, color: new Color(0xFF828282)) : null 
        ),
        new Expanded(child: column)
      ],             
    );

    return new Padding(
      child: new ConstrainedBox(child: row,
        constraints: new BoxConstraints(minHeight: 60.0),
      ),
      padding: new EdgeInsets.only(right: 30.0 ),
    );   
  }


  Widget _buildDocumentTypeRow(){    
    var dropDown = new DocumentTypeField(this.document.documentType, (type)=> this.setState( ()=> document.documentType = type  ) );     
    return _buildRow(dropDown, "Typ",Icons.insert_drive_file);
  }

  Widget _buildAccPeriodRow(){    
    var field = new AccPeriodField(document.accPeriod, (date) => this.setState( ()=> document.accPeriod = date ) );
    return _buildRow(field, "Okres",);
  }

  Widget _buildTagsRow(){
    var field = new TagsField(document.tags, (tags) => this.setState( ()=> document.tags = tags ));
    return _buildRow(field, "Tagi");
  }


  Widget _buildMarkAsPaidRow(){
    return _buildBottomRow("Oznacz jako opłacone", Icons.monetization_on, this.document.isPaid, (val)=> this.setState( ()=> document.isPaid = val ) );
  }
  Widget _buildMarkAsAcceptedRow(){
    return _buildBottomRow("Akceptuj", Icons.check_circle, this.document.isAccepted, (val)=> this.setState( ()=> document.isAccepted = val ) );
  }

  Widget _buildBottomRow(String title, IconData icon, bool value,Function(bool) onChange){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(width: 60.0, child: new Icon(icon, color: new Color(0xFF828282))),
        new Expanded(
          child: new Text(title, style: new TextStyle(fontSize: 14.0, color: lightGreyTextColor), textAlign: TextAlign.left),
        ),
        new Switch(value: value, onChanged: onChange, activeColor: yellowAccentColor)
      ],
    );
  }

  Widget _buildSaveButton(){
    var button = new MaterialButton(
      color: yellowAccentColor,
      height: 65.0,   
      minWidth: MediaQuery.of(context).size.width,
      onPressed: ()=> saveDocument(),
      textColor: Colors.white,      
      child: new Text("Zapisz"),
    );

    var container = new Container(
      decoration: new BoxDecoration(
        color: accentColor,
        borderRadius: new BorderRadius.all( const Radius.circular(20.0))
      ),
      child: button,
    );

    var paddingContainer = new Padding(
      child:container,
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
    );

    return paddingContainer;
  }  

  Widget _buildSavingIndicator(){    
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          new Text("Trwa zapisywanie"),
          new SizedBox(width: 20.0),
          new ThemedCircularProgressIndicator(),          
      ],
    );
    return new Container(
      child: row,
      height: 65.0,
    );
  }

  void saveDocument() async{
    this.setState( ()=> isSaving = true);
    var result = await new RemoteService().updateDocument(this.document);

    if(result != null){
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(result),
      ));
      this.setState( ()=> isSaving = false );
    } else {
      Navigator.pop(context, document);
    }

  }
}