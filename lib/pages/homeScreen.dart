import 'package:flutter/material.dart';
import '../widgets/featureButtonGrid.dart';
import '../widgets/contextSelectionFooter.dart';

import '../entities/featureButtonConfiguration.dart';
import '../pages/newDocumentCameraScreen.dart';
import '../pages/loadingScreen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new HomeScreenState();

} 

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new Padding(
               padding: new EdgeInsets.all(13.0),
               child: Image.asset("images/icons/upper_logo.png")
            )
          ],
        ),
        drawer: new Drawer(),        
        backgroundColor: const Color.fromARGB(0xFF,0x30,0x30,0x30),  
        body: new Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FeatureButtonGrid(getConfig(context)),
            new ContextSelectionFooter()
          ]
        )
    );
  }
}

List<FeatureButtonConfiguration> getConfig(BuildContext context){
  var list = new List<FeatureButtonConfiguration>();

  list.add(
    new FeatureButtonConfiguration(
      const Color.fromARGB(0xFF,0x00,0xbb,0xa1),
      Icon(Icons.add, color: Colors.white,), 
      "Dodaj skan", 
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NewDocumentCameraScreen() ))
  ));
  list.add(
    new FeatureButtonConfiguration(
      Color.fromARGB(0xFF,0xf0,0xc9,0x4a),
      Icon(Icons.insert_drive_file, color: Colors.white,), 
      "Ostatnie skany", 
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NewDocumentCameraScreen() ))
  ));
  list.add(
    new FeatureButtonConfiguration(
      Color.fromARGB(0xFF,0xbc,0xc5,0x3d),
      Icon(Icons.credit_card, color: Colors.white,), 
      "Wizytówka", 
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NewDocumentCameraScreen() ))
  ));
  list.add(
    new FeatureButtonConfiguration(
      Color.fromARGB(0xFF,0xc5,0x7e,0x3d),
      Icon(Icons.settings, color: Colors.white,), 
      "Ustawienia", 
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NewDocumentCameraScreen() ))
  ));
  list.add(
    new FeatureButtonConfiguration(
      Color.fromARGB(0xFF,0xc5,0x7e,0x3d),
      Icon(Icons.extension, color: Colors.white,), 
      "Loading page", 
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => new LoadingScreen() ))
  ));
  return list;
} 


