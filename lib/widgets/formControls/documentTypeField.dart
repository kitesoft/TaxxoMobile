import 'package:flutter/material.dart';
import '../../services/remoteService.dart';
import '../../themes/mainTheme.dart';

class DocumentTypeField extends StatelessWidget{
  final int documentType;
  Map<int,String> documentTypes;
  final Function(int) onDocumentTypeChanged;

  DocumentTypeField(this.documentType,this.onDocumentTypeChanged){
      documentTypes = new RemoteService().getDocumentTypes();      
  }

  @override
  Widget build(BuildContext context) {
    var dropdown = new DropdownButton<int>(        
        isDense: true,                   
        value: this.documentType,      
        style: new TextStyle(color: lightGreyTextColor, fontSize: 14.0),
        items: documentTypes.keys.toList().map ((int key) {
          return new DropdownMenuItem<int>( 
            value: key,
            child: new Text(documentTypes[key]),
          );
        }).toList(),
        onChanged: this.onDocumentTypeChanged
    );
    var expandedDropDown = new FractionallySizedBox (child: dropdown, widthFactor: 1.0 );

    return expandedDropDown;
  }

}