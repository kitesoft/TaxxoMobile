import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../widgets/documentEditForm.dart';
import '../themes/mainTheme.dart';

class DocumentEditScreen extends StatefulWidget{
  final RemoteDocument document;

  DocumentEditScreen(this.document);

  @override
  State<StatefulWidget> createState() => new DocumentEditScreenState(document);
}

class DocumentEditScreenState extends State<DocumentEditScreen>{
  RemoteDocument document;

  DocumentEditScreenState(this.document);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(      
      appBar:  new AppBar(
        title:  new Text(document.documentNumber),
      ),
      body:new Container(
        color: lightBackgroundColor,
        child: new DocumentEditForm(document, (RemoteDocument doc)=> debugPrint(doc.toString())),
      ) 
    );
  }
}