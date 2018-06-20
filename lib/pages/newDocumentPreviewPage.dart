import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../entities/document.dart';


class NewDocumentPreviewPage extends StatefulWidget{
  final Document document;
  NewDocumentPreviewPage(this.document);
  
  @override
  State<StatefulWidget> createState() => new NewDocumentPreviewPageState();
}



class NewDocumentPreviewPageState extends State<NewDocumentPreviewPage>{
  Document currentDocument;
  int currentPageIndex;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    if(currentDocument == null) return new Container( color: Colors.black);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nowa faktura"),        
      ),
      backgroundColor: Colors.black,
      body: _buildBody(),
      floatingActionButton: new FloatingActionButton(
        heroTag: "NextPageButton",
        backgroundColor: new Color(0xFF00BBA1),
        child: new Icon(Icons.check, color: Colors.white),
        tooltip: "Dalej",
      ),
    );
  }


  _buildActionButtons(){
    

    var actionColumn =  new Column(      
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton("Usuń stronę", Icons.delete,"RemoveImageButton", ()=> _removeImage() ),
        _buildButton("Potwórz zdjęcie", Icons.camera_alt,"RepeatImageButton", ()=> _repeatImage()),
        _buildButton("Dodaj stronę", Icons.add_to_photos,"AddImageButton", ()=> _addNextImage())
      ],
    );

    var container =  new Container(
      child: actionColumn,
      height: 150.0,      
      margin: new EdgeInsets.fromLTRB(16.0, 0.0 ,0.0, 22.0),
    );

    return new Align(
      alignment: Alignment.bottomLeft,
      child: container,
    );
  }

  _buildButton(String text,IconData icon,String tagName,VoidCallback callback){    
    var stack = new Stack(                  
      children: <Widget>[
        new Positioned(
          left: 20.0,
          child: new Container(
            width: 146.0, 
            padding: new EdgeInsets.only(left:30.0),
            color: new Color(0x54000000), 
            height: 40.0,
            child: new Align(
              child: Text(text),
              alignment: Alignment.centerLeft,
            )
          ),
        ),        
        new FloatingActionButton(
            mini: true,
            heroTag: tagName,
            backgroundColor: new Color(0xFFA7A7A7),
            child: new Icon(icon,color: Colors.white),
            onPressed: callback,          
        ),
      ],
    );

    return new Container(width: 166.0, height: 40.0, child: stack);
  }


  @override
  initState(){
    super.initState();
    currentDocument = widget.document;
    currentPageIndex = widget.document.currentIndex;
    pageController = new PageController(
      initialPage: currentPageIndex,
      keepPage: false,
      viewportFraction: 1.0,          
    );
  }

  _buildBody(){
    return new Stack(
      children: <Widget>[
        _buildCarouselView(),
         new Padding(
           padding: new EdgeInsets.only(top: 20.0),
           child:Align(alignment: Alignment.topCenter , child:_buildSwitcher())
         ),
         _buildActionButtons()
      ],
    );
  }


  _buildCarouselView(){
   return new PageView.builder(
      onPageChanged: (val){
        currentDocument.currentIndex = val;
        setState(()=> currentPageIndex = val);
      },
      itemCount: currentDocument.pages.length,
      controller: pageController,
      itemBuilder: (context,index) =>_buildCarouselItem(index) ,
    );
  }

  _buildCarouselItem(int index){
      var loadingContainer = new Align(
         child : Container(
           width: 40.0,
           height: 40.0,
           child: new CircularProgressIndicator(
             valueColor: new AlwaysStoppedAnimation<Color>(new Color(0xFF00bba1)),
           ) ,
         )
      );
      return new PhotoView(imageProvider: new MemoryImage(currentDocument.pages[index].data), loadingChild: loadingContainer );
  }

  _buildSwitcher(){
    var content = new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new GestureDetector(
          child: new Icon(Icons.arrow_left, color: Colors.white),
          onTap: () => pageController.previousPage(curve: Curves.ease, duration: new Duration(milliseconds: 300)),
        ),        
        new Text(_getSwitcherText()),
        new GestureDetector(
          child: new Icon(Icons.arrow_right, color: Colors.white),
          onTap: () => pageController.nextPage(curve: Curves.ease, duration: new Duration(milliseconds: 300)),
        ),    
      ],
    );       


    return new Container(      
      decoration: new BoxDecoration(
        color: const Color.fromARGB(0xFF, 0x21, 0x21, 0x21),
        borderRadius: new BorderRadius.all( const Radius.circular(40.0))
      ),
      child: new Padding(child: content, padding: new EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),) 
    );
  }

  _getSwitcherText(){
    var currentPage = currentPageIndex+1;
    var pageCount = currentDocument.pages.length;
    return "Strona $currentPage z $pageCount";
  }

  _removeImage(){
    currentDocument.pages.removeAt(this.currentPageIndex);
    currentDocument.currentIndex = currentDocument.pages.length;
    Navigator.pop(context, currentDocument);
  }

  _repeatImage(){
    Navigator.pop(context, currentDocument);
  }
  
  _addNextImage(){
    currentDocument.currentIndex = currentDocument.pages.length;
    Navigator.pop(context, currentDocument);
  }
}