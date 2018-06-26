import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';


import 'dart:io';
import 'dart:async';
import '../entities/document.dart';
import '../themes//mainTheme.dart';

import 'newDocumentPreviewScreen.dart';

class NewDocumentCameraScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new NewDocumentCameraScreenState();

}



class NewDocumentCameraScreenState extends State<NewDocumentCameraScreen>{
  List<CameraDescription> cameras;
  CameraController controller;
  bool isFlashOn;
  LocalDocument currentDocument;
  String currentPageNotificationText;
  bool showCurrentPageNotification;

  @override
  Widget build(BuildContext context) {

     if ( cameras == null || !controller.value.isInitialized) {
      return new Container();
    }
    var cameraPreview = new Center(
      child: new AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: new CameraPreview(controller),
        )
    );



    var stack = new Stack(    
      children: <Widget>[
        cameraPreview,
        _buildAppBar(),
        _buildBottomButtons(),
        _buildPageNotification()
      ],
    );
    return stack;
  }

 @override
  void initState() {
    super.initState();
    showCurrentPageNotification = true;
    currentPageNotificationText = _createPageNotificationText(1); 
    availableCameras().then((resolvedCameras){
        cameras = resolvedCameras;
        controller = new CameraController(cameras[0], ResolutionPreset.medium);

        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
            setState(() {
              currentDocument = new LocalDocument();
              isFlashOn = false;
            });
          });
    });
  }

  String _createPageNotificationText(int pageNumber){
      return "Strona $pageNumber faktury";      
  }

  void takePicture() async{
    final String timestamp = new DateTime.now().millisecondsSinceEpoch.toString();
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp}.jpg';
    await controller.takePicture(filePath); 
    var file = File(filePath);
    var fileData = await file.readAsBytes();    
    createNewDocumentPage(fileData);
    file.delete();          

  }

  void createNewDocumentPage(List<int> data) {
    var page = new LocalDocumentPage(data);
    var createNewItem =  currentDocument.currentIndex == currentDocument.pages.length; 
    if(createNewItem) 
    {
      currentDocument.pages.add(page);
      currentDocument.currentIndex++;
    }
    else
    {
      currentDocument.pages[currentDocument.currentIndex] = page;
      currentDocument.currentIndex++;
    } 
    this.setState(()=> currentDocument = currentDocument);
    goToNewDocumentPreviewPage();
  }

  void selectPictureFromGallery() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(picture != null){
      var fileData = await picture.readAsBytes();
      createNewDocumentPage(fileData);
    }
  }

  void goToNewDocumentPreviewPage() async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => new NewDocumentPreviewScreen(currentDocument) ));
    if(result == null){
      //Back button pressed
      currentDocument.currentIndex++;
      result = currentDocument;
    }  

    int pageNumber = result.currentIndex+1;

    new Future.delayed(const Duration(seconds: 10)).then((_)=> setState(()=> showCurrentPageNotification = false));
    setState(() { 
      currentDocument = result;
      currentPageNotificationText = _createPageNotificationText(pageNumber); 
      showCurrentPageNotification = true; 
    });
          
  }

  Widget _buildPageNotification(){
    if(!showCurrentPageNotification) return new Container();

    return new Center(
      child: new Container(      
        decoration: new BoxDecoration(
            color: const Color.fromARGB(0x8c, 0x21, 0x21, 0x21),
            borderRadius: new BorderRadius.all( const Radius.circular(40.0))
          ),
        child: new Padding(
          child: new Text(currentPageNotificationText, style: new TextStyle(inherit: false),), 
          padding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 56.0),) 
      ),
    );
  }

  Widget _buildBottomButtons(){
    return new Align(
         alignment: const Alignment(0.0, 1.0),
         child: new Padding(
           padding: new EdgeInsets.fromLTRB(20.0, 0.0,20.0, 20.0),
           child: Row(           
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                _buildGalleryButton(),
                _buildTakePictureButton(),
                _buildMiniatureButton()  
            ],
          ),
         )
        );
  }

  Widget _buildGalleryButton(){
    return new FloatingActionButton(
      elevation: 5.0,
      highlightElevation: 5.0,
      mini: false,
      heroTag: "galleryButton",
      notchMargin: 11.0,
      backgroundColor: const Color.fromARGB(0xFF, 0xA7, 0xA7, 0xA7),
      child: new Icon(Icons.photo_library, color: Colors.white),
      onPressed: ()=> selectPictureFromGallery(),          
    );
  }

  Widget _buildTakePictureButton(){
    return new FloatingActionButton(
      elevation: 5.0,
      highlightElevation: 5.0,
      mini: false,
      heroTag: "takePictureButton",
      notchMargin: 11.0,
      backgroundColor: accentColor,
      child: new Icon(Icons.camera, color: Colors.white),
      onPressed: ()=> this.takePicture()
    );
  }

  Widget _buildMiniatureButton(){
    if(currentDocument.pages.length == 0) return new Container(height: 60.0, width: 60.0,);
    
    var miniature = new Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        border: new Border.all(color: accentColor,width: 1.0)
      ),
      child: new Image.memory(currentDocument.pages.last.data, fit:BoxFit.fill)      
    );

    var counter = new Container(
        width: 20.0,
        height: 20.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(0xFF, 0x00, 0xbb, 0xa1)
        ),
        child: new Center(
          child : new Text(
            currentDocument.pages.length.toString(),
            style: new TextStyle(inherit: false)
          ),
        ),
    );

    var stack = new Stack(
        children: <Widget>[
          new Container(width: 70.0, height: 70.0),
          new Positioned(
            child: miniature,
            bottom: 0.0,
            right: 0.0,           
          ),
          new Positioned(
            child: counter,
            top:0.0,
            left: 0.0,
          )
        ],
    );
    return new GestureDetector(
      child: stack,
      onTap: ()=> goToNewDocumentPreviewPage(),
    );
  }

  Widget _buildAppBar(){
    return new Container(
      color: const Color.fromARGB(0x55, 0x55, 0x55,0x55),
      child: new AppBar( 
        backgroundColor: Colors.transparent, 
        elevation: 0.0,
        actions: <Widget>[
          new GestureDetector(
              child: new Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white
              ),
             onTap: ()=> setState(() => isFlashOn = !isFlashOn ),
          )

 
        ])
    );

  }
}