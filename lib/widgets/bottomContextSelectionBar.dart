import 'package:flutter/material.dart';
import '../themes/mainTheme.dart';
import '../pages/contextSelectionScreen.dart';
import '../services/authService.dart';
import '../entities/contextInfo.dart';

class BottomContextSelectionBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new BottomContextSelectionBarState();

}

class BottomContextSelectionBarState extends State<BottomContextSelectionBar>{
  ContextInfo contextInfo;

  @override void initState(){
    super.initState();    
    this.setState(()=> contextInfo = AuthService.instance.currentContext);
  }

  @override
  Widget build(BuildContext context) {
    var container =  new Container(
      height: 56.0,
      color: bottomNavigationBarColor,
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(16.0,19.0,16.0,16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[          
            new Text(this.contextInfo.customerName ?? ""),
            new Icon(Icons.arrow_drop_down, color: Colors.white)
          ],
        )
      )
    );
  
    return new GestureDetector(
      child: container,
      onTap: () async => _openContextSelection(context),
    );
  }
  _openContextSelection(BuildContext context) async{
      var result = await Navigator.push<ContextInfo>(context, MaterialPageRoute(builder: (context) => new ContextSelectionScreen() ));
      if(result != null){
        this.setState( ()=> contextInfo = result);
      }
  }  
}