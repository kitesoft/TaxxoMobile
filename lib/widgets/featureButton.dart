import 'package:flutter/material.dart';
import '../entities/featureButtonConfiguration.dart';
import 'roundButton.dart';

class FeatureButton extends StatelessWidget {
  FeatureButton({@required FeatureButtonConfiguration config}) { _config = config; }  
  FeatureButtonConfiguration _config;  
  @override
  Widget build(BuildContext context) {
   var featureButton = new Container(         
      color: _config.color,
      child: new Column(
        children: <Widget>[ 
          new Expanded( 
            child :Container(            
              child: new Center(
                child: new RoundButton(icon: _config.icon)
              )
            )
          ),
          description(_config.text)
        ],
      )
    );

    return new GestureDetector(
      child: featureButton,
      onTap: _config.onClick,
    );
  }

  Widget description(String text){
    return new Container(
      width: double.infinity,
      height: 45.0,
      color: Color.fromARGB(0x19, 0x00, 0x00, 0x00),
      child: new Padding(            
        padding: new EdgeInsets.fromLTRB(10.0,12.0,10.0,14.0),
        child: new Text(_config.text),
      ) 
    );
  }

}

