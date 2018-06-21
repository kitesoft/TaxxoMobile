import 'package:flutter/material.dart';
import '../entities/featureButtonConfiguration.dart';
import '../pages/newDocumentCameraScreen.dart';
import 'featureButton.dart';


class FeatureButtonGrid extends StatefulWidget  {  
  List<FeatureButtonConfiguration> configurations;  
  FeatureButtonGrid(@required List<FeatureButtonConfiguration> this.configurations);  

  @override
  State<StatefulWidget> createState() => new FeatureButtonGridState();
}

class FeatureButtonGridState extends State<FeatureButtonGrid>{
  
  @override
  Widget build(BuildContext context) {
      final orientation = MediaQuery.of(context).orientation;
      var configurations = widget.configurations;
      var grid = new GridView.count(        
        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(25.0),
        childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
        children: configurations.map( (config) => new FeatureButton(config: config)).toList(),
      );

      return new Expanded(
        child: grid,
      );
  }

}