import 'dart:typed_data';

class Document {
  DocumentPage thumbnail;
  List<DocumentPage> pages = new List<DocumentPage>();
  String documentNumber;
  DateTime accPeriod = new DateTime.now();
  String createdBy;
  DateTime creationDate = new DateTime.now(); 
  int currentIndex = 0;
  List<String> tags = new List<String>();
  bool isAccepted = false;
  bool isPaid = false;
}

class DocumentPage {
  DocumentPage(this.data);
  List<int> data;
}