import '../entities/document.dart';
import '../entities/user.dart';
import '../entities/contextInfo.dart';

import 'dart:async';
import 'dart:math';
import 'dart:convert';

//Temp
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var random = new Random(new DateTime.now().millisecondsSinceEpoch);

  Future<List<RemoteDocument>> fetchDocuments() async{
    var list = new List<RemoteDocument>();
    for(var i=0; i <100; i++){

      var docNumber = "FV " + random.nextInt(300).toString() + "/" + random.nextInt(12).toString() + "/2018";       
      var randomImageId = random.nextInt(1000);
      var doc = new RemoteDocument();
      doc.id = randomImageId;
      doc.documentNumber = docNumber;      
      doc.thumbnailURL = "https://picsum.photos/300/300/?image=$randomImageId";
      doc.createdBy = "Random user $randomImageId";
      doc.documentNumber = "FV /01/2018";
      doc.isAccepted = random.nextBool();
      doc.isPaid = random.nextBool();
      if(random.nextBool()) doc.tags.add("tag");

      var numberOfPages = random.nextInt(15);
      doc.pagesURLs.add("https://picsum.photos/1500/2100/?image=$randomImageId");
      for(var pageNo = 0; pageNo < numberOfPages; pageNo++){
        var randomId = random.nextInt(1000);
        doc.pagesURLs.add("https://picsum.photos/1500/2100/?image=$randomId");
      }

      list.add(doc);      
    }
    return list;
  }

  Future<bool> isServerOnline() async {
    //TODO Implementation
    await new Future.delayed(new Duration(seconds: 2));    
    return true;
  }

  Future<bool> isNetworkEnabled() async {
    await new Future.delayed(new Duration(seconds: 2));    
    return true;
  }
  
  Future<String> logIn(String login, String password) async {
    await new Future.delayed(new Duration(seconds: 4));
    if(login != null && login.isNotEmpty && password != null && password.isNotEmpty) return null;
    else return "Login failed. Login and password cannot be empty";
  }

  Future<List<ContextInfo>> getContextList() async{
    var result = new List<ContextInfo>();

    for(var i=0; i <100; i++){
      var item = new ContextInfo();
      item.id = i;
      item.name = "Company " + i.toString();
      result.add(item);
    }
    return result;
  }
}