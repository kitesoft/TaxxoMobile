import '../entities/document.dart';
import '../entities/user.dart';
import 'dart:async';

//Temp
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class RemoteService {
  Future<List<Document>> fetchDocuments() async{
    var list = new List<Document>();
    for(var i=0; i <20; i++){
      var doc = new Document();
      var imageData = await rootBundle.load("images/icons/splashscreen.png");      
      doc.thumbnail = new DocumentPage(imageData.buffer.asUint8List());
      doc.createdBy = "Test User";
      doc.documentNumber = "FV 000001/01/2018";
      doc.isAccepted = true;
      doc.isPaid = true;
      list.add(doc);      
    }
    return list;
  }
}