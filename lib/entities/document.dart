import 'dart:typed_data';

class Document {
  List<DocumentPage> pages = new List<DocumentPage>();
  String documentName;
  int currentIndex = 0;

}

class DocumentPage {

  DocumentPage(this.data);

  List<int> data;
}