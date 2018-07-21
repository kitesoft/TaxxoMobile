import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../themes/mainTheme.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AccPeriodField extends StatefulWidget{
  final DateTime date;
  final Function(DateTime) onAccPeriodChanged;

  AccPeriodField(this.date,this.onAccPeriodChanged);

  @override
  State<StatefulWidget> createState() => new AccPeriodFieldState(date, onAccPeriodChanged);
}

class AccPeriodFieldState extends State<AccPeriodField> {
  Map<int, DateTime> months;
  Map<int, DateTime> years;
  final int yearsLength = 50;
  final int startYear = 2000;
  DateTime date;
  FixedExtentScrollController yearController;
  FixedExtentScrollController monthController;
  final DateFormat monthFormat = new DateFormat().add_MMM();
  final DateFormat dateFormat = new DateFormat("MM.y");
  final TextEditingController textController = new TextEditingController();
  final Function(DateTime) onAccPeriodChanged;
  int selectedYear;
  int selectedMonth;

  AccPeriodFieldState(this.date,this.onAccPeriodChanged){
    initializeDateFormatting();
    months = _getMonths();
    years = _getYears();
    selectedYear = years.entries.firstWhere( (x)=> x.value.year == date.year, orElse: ()=> years.entries.first ).key;
    selectedMonth = months.entries.firstWhere( (x)=> x.value.month == date.month, orElse: ()=> months.entries.first ).key;
  }

  @override
  Widget build(BuildContext context) {    
    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new SizedBox(height: 6.0),
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

  showPicker(BuildContext context){
   showDialog<DateTime>(context: context, builder: _buildPicker);
  }

  Map<int,DateTime> _getMonths(){
    var result = new Map<int,DateTime>();
    
    for(var i=0; i < DateTime.monthsPerYear;i++){
      var date = new DateTime(2000,i + 1);
      result.putIfAbsent(i, ()=> date);
    }
    return result;
  }

  Map<int,DateTime> _getYears(){
    var result = new Map<int,DateTime>();  
    for(var i=0; i < yearsLength;i++){
      result.putIfAbsent( i, ()=> new DateTime(startYear + i) );
    }
    return result;
  }

  List<Widget> _buildMonthList(){
    var result = new List<Widget>();
    months.forEach((idx,val)=> result.add(new Text(monthFormat.format(val), style: new TextStyle(color: Colors.black))));
    return result;
  }

  List<Widget> _buildYearList(){    
      var result = new List<Widget>();
      years.forEach((idx,val)=> result.add(new Text(val.year.toString(), style: new TextStyle(color: Colors.black))));
      return result;
  }
 
  Widget _buildPicker(BuildContext context){
    yearController = new FixedExtentScrollController(initialItem: selectedYear);
    monthController = new FixedExtentScrollController(initialItem: selectedMonth);

    var yearPicker = new CupertinoPicker(      
      children: _buildYearList(),
      itemExtent: 25.0,      
      scrollController: yearController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (idx)=> this.setState( ()=> selectedYear = idx ),
    );
    
    var monthPicker = new CupertinoPicker(
      children: _buildMonthList(),
      itemExtent: 25.0,
      scrollController: monthController,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (idx)=> this.setState( ()=> selectedMonth = idx ),
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
          child: new Text('OK', style: new TextStyle(color: yellowAccentColor),),
          onPressed: () { 
            Navigator.pop(context, null );
            var newDate = new DateTime(years[selectedYear].year, months[selectedMonth].month);
            this.setState(()=> this.date = newDate);            
            onAccPeriodChanged(newDate);
          }
        )
      ],
    );
  }


}