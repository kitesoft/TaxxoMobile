import 'package:flutter/material.dart';
import '../entities/document.dart';
import '../themes/mainTheme.dart';
import 'package:photo_view/photo_view.dart';
import '../widgets/themedWidgets.dart';

class DocumentPreviewScreen extends StatefulWidget {
  RemoteDocument document;
  DocumentPreviewScreen(this.document);
  
 @override
 State<StatefulWidget> createState() => new DocumentPreviewScreenState();

}

class DocumentPreviewScreenState extends State<DocumentPreviewScreen>{
  RemoteDocument document;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: appBarColor,
        title: new Text(document.documentNumber),
      ),
      body: _buildBody(),
      floatingActionButton: _buildEditButton(),      
    );
  }

  Widget _buildEditButton(){
    return new FloatingActionButton(
        backgroundColor: yellowAccentColor,
        foregroundColor: Colors.white,
        child: new Icon(Icons.edit),
        onPressed: ()=> {},
    );
  }

  @override
    void initState() {      
      pageController = new PageController(
        initialPage: 0
      );
      super.initState();
      setState(()=> document = widget.document);
    }


  Widget _buildBody(){
    return new Stack(
      children: <Widget>[
        _buildCarouselView(),
      ],
    );
  }


  _buildCarouselView(){
   return new PageView.builder(
      itemCount: document.pagesURLs.length,
      controller: pageController,
      itemBuilder: (context,index) =>_buildCarouselItem(index) ,
    );
  }

  _buildCarouselItem(int index){
      var orientation = MediaQuery.of(context).orientation;
      var loadingContainer = new Align(
         child : Container(
           width: 40.0,
           height: 40.0,
           child: new ThemedCircularProgressIndicator()
         )
      );
      return new Container(
        child: new PhotoView(imageProvider: new NetworkImage(document.pagesURLs[index],scale: 2.0), loadingChild: loadingContainer )
      );
  }
}