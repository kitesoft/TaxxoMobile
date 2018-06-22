import '../entities/document.dart';
import '../entities/user.dart';

import 'dart:async';
import 'dart:math';

//Temp
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var random = new Random(new DateTime.now().millisecondsSinceEpoch);

  Future<List<Document>> fetchDocuments() async{
    var list = new List<Document>();
    for(var i=0; i <100; i++){

      var docNumber = "FV " + random.nextInt(300).toString() + "/" + random.nextInt(12).toString() + "/2018";       
      var randomImageId = random.nextInt(1000);
      var doc = new Document();      
      doc.thumbnailURL = "https://picsum.photos/300/300/?image=$randomImageId";
      doc.createdBy = "Random user $randomImageId";
      doc.documentNumber = "FV /01/2018";
      doc.isAccepted = random.nextBool();
      doc.isPaid = random.nextBool();
      if(random.nextBool()) doc.tags.add("tag");
      list.add(doc);      
    }
    return list;
  }
}