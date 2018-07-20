import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../themes/mainTheme.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AccPeriodField extends StatelessWidget{
  Map<String,int> months;
  Map<String,int> years;
  final int yearsLength = 50;
  final int startYear = 2000;
  final DateTime date;
  FixedExtentScrollController yearController;
  FixedExtentScrollController monthController;
  final DateFormat monthFormat = new DateFormat().add_MMM();
  final DateFormat dateFormat = new DateFormat("MM.y");
  final TextEditingController textController = new TextEditingController();
  AccPeriodField(this.date){
    initializeDateFormatting();
    months = _getMonths();
    years = _getYears();

    var selectedYear = years[date.year.toString()];
    var selectedMonth = months[monthFormat.format(date)];
    yearController = new FixedExtentScrollController(initialItem: selectedYear);
    monthController = new FixedExtentScrollController(initialItem: selectedMonth);
  }

  @override
  Widget build(BuildContext context) {    
    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(dateFormat.format(date), textAlign: TextAlign.left, style: new TextStyle(color: lightGreyTextColor),),
        new Divider(height: 7.5, color: lightGreyTextColor)
      ],
    );              

    var expandedRow = new Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(child: new Container(child: column, color: Colors.transparent))
      ]
    );

    return new GestureDetector(
      child: expandedRow,
      onTap: ()=> showPicker(context),
    );
  }

  void showPicker(BuildContext context){
   showDialog<DateTime>(context: context, builder: _buildPicker);
  }

  Map<String,int> _getMonths(){
    Map<String,int> result = new Map<String,int>();
    
    for(var i=0; i < DateTime.monthsPerYear;i++){
      var date = new DateTime(2000,i + 1);
      var formattedMonth = monthFormat.format(date);
      result.putIfAbsent(formattedMonth, ()=> i);
    }
    return result;
  }

  Map<String,int> _getYears(){
    Map<String,int> result = new Map<String,int>();
    
    for(var i=0; i < yearsLength;i++){
      result.putIfAbsent((startYear + i).toString(), ()=> i );
    }
    return result;
  }

  List<Widget> _buildMonthList(){
    var result = new List<Widget>();
    months.forEach((idx,val)=> result.add(new Text(idx, style: new TextStyle(color: Colors.black))));
    return result;
  }

  List<Widget> _buildYearList(){    
      var result = new List<Widget>();
      years.forEach((idx,val)=> result.add(new Text(idx, style: new TextStyle(color: Colors.black))));
      return result;
  }
 
  Widget _buildPicker(BuildContext context){
    var yearPicker = new CupertinoPicker(      
      children: _buildYearList(),
      itemExtent: 25.0,      
      scrollController: yearController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (x)=> {},
    );
    
    var monthPicker = new CupertinoPicker(
      children: _buildMonthList(),
      itemExtent: 25.0,
      scrollController: monthController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (x)=> {},
    );
    var row = new Row(        
        children: <Widget>[
          new Expanded( child: monthPicker),
          new Expanded( child: yearPicker),
        ],
    );

    var container = new Container(
      child: row,
      height: 230.0,
    );


    return new AlertDialog(
      content: container,
      title:  new Text("Okres", style: new TextStyle(color: Colors.black),),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CANCEL'),
          onPressed: () { Navigator.pop(context, null ); }
        ),
        new FlatButton(
          child: const Text('OK'),
          onPressed: () { Navigator.pop(context, null ); }
        )
      ],
    );
  }
}
