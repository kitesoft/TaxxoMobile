import 'dart:typed_data';

abstract class Document {
  int id;
  String documentNumber;
  String createdBy;
  DateTime creationDate = new DateTime.now(); 
  bool isAccepted = false;
  bool isPaid = false;
  List<String> tags = new List<String>();
}

class LocalDocumentPage {
  LocalDocumentPage(this.data);
  List<int> data;
}

class LocalDocument extends Document {
  int get pageCount => this.pages.length;
  List<LocalDocumentPage> pages = new List<LocalDocumentPage>();
  int currentIndex = 0;
}

class RemoteDocument extends Document {
  RemoteDocument();

  RemoteDocument.cloned(RemoteDocument source){
    this.thumbnailURL = source.thumbnailURL;
    this.documentNumber = source.documentNumber;
    this.pagesURLs = source.pagesURLs;
    this.accPeriod = source.accPeriod; 
    this.documentType = source.documentType;
    this.id = source.id;
    this.documentNumber = source.documentNumber;
    this.createdBy = source.createdBy;
    this.creationDate = source.creationDate;
    this.isAccepted = source.isAccepted;
    this.isPaid = source.isPaid;
    this.tags = source.tags;
  }

  String thumbnailURL;
  String documentNumber;
  List<String> pagesURLs = new List<String>();
  DateTime accPeriod = new DateTime.now(); 
  int documentType;
}
