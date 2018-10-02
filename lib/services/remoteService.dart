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
      doc.documentType = random.nextInt(8);      
      doc.thumbnailURL = "https://picsum.photos/300/300/?image=$randomImageId";
      doc.createdBy = "Random user $randomImageId";
      doc.isAccepted = random.nextBool();
      doc.isPaid = random.nextBool();
      doc.accPeriod = new DateTime(2018, random.nextInt(12), 1);
      doc.creationDate = new DateTime(2018, random.nextInt(12), random.nextInt(30));      
      if(random.nextBool()){
        for(var i=0; i < random.nextInt(15); i++){
          doc.tags.add("Tag number $i");
        }
      }

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

  Future<String> updateDocument(RemoteDocument document) async {
    await new Future.delayed(new Duration(seconds: 4));
    return null;
  }

  Future<List<ContextInfo>> getContextList() async{
    var result = new List<ContextInfo>();

    for(var i=0; i <100; i++){
      var item = new ContextInfo();
      item.userId = i;
      item.customerName = "Company " + i.toString();
      result.add(item);
    }
    return result;
  }

  Map<int,String> getDocumentTypes()  {
    var map = {
      0 : "Unknown",
      1 : "Faktura",
      2 : "Paragon",
      3 : "Rachunek",
      4 : "Inne",
      5 : "Dokument",
      6 : "Faktura proforma",
      7 : "Ubezpieczenie",
      8 : "Brak",
    };
    return map;
  }

  List<String> getTags(){
    var result = new List<String>();
    result.add("Projekty");
    result.add("Zmiany");
    result.add("NP");
    result.add("Biuro");
    result.add("Leasing");
    result.add("Bardzo długi tak który powinien się nie mieścic");
    result.add("Bardzo_długi_tak_który_powinien_się_nie_mieścic_i_nie_posiada_spacji");
    result.add("Dosyc długi tag");
    result.add("Dosyc długi tag, a nawet dłuższy");
    result.add("Tag 10");
    result.add("Tag 11");
    result.add("Tag 12");
    result.add("Tag 13");
    result.add("Tag 14");
    return result;
  }
}