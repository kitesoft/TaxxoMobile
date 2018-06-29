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
  String thumbnailURL;
  String documentNumber;
  List<String> pagesURLs = new List<String>();
  DateTime accPeriod = new DateTime.now(); 
  int documentType;
}
