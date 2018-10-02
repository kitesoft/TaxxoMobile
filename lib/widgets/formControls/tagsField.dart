import 'package:flutter/material.dart';
import '../../themes/mainTheme.dart';
import '../../services/remoteService.dart';

class TagsField extends StatefulWidget{
  final List<String> tags;
  final Function(List<String>) onTagsChanged;

  TagsField(this.tags, this.onTagsChanged);

  @override
  State<StatefulWidget> createState() => new TagsFieldState(tags,onTagsChanged);

}

class TagsFieldState extends State<TagsField> {
  List<String> tags;
  GlobalKey<TagsPickerState> tagsPickerKey = GlobalKey();  
  Function(List<String>) onTagsChanged;
  TagsFieldState(this.tags, this.onTagsChanged);
  String newTagValue;

  @override
  Widget build(BuildContext context) {
    var tagElements = tags.map((tag)=> _buildTagElement(tag) ).toList();
    var wrapper =  new Wrap(
      children: tagElements,
      spacing: 3.0,      
      runSpacing: 3.0,
      direction: Axis.horizontal,
    );

    var column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new SizedBox(height: 6.0),
        tagElements.length > 0 ? wrapper : _buildNoTagsIndicator(),
        new Divider(height: 7.5, color: lightGreyTextColor)
      ],
    );

    return new GestureDetector(
      child: new Container(child: column, color: Colors.transparent ),
      onTap: ()=> showTagsPicker(),
    );
  }

  showTagsPicker(){
    showDialog<List<String>>(context: context, builder: (ctx)=> buildTagPicker() ).then((val){
        if(val != null) this.setState(()=> tags = val );
    });    
  }

  Widget buildTagPicker(){
    return new AlertDialog(
      content: new Container(height: 230.0,child: new TagsPicker(tags, this.tagsPickerKey)),
      actions: <Widget>[
        new FlatButton(
          child: new Row(children: <Widget>[Icon(Icons.add_circle),new SizedBox(width: 5.0), new Text("ADD")]),
          onPressed: () => showAddNewTagDialog(),
        ),
        new FlatButton(
          child: const Text('CANCEL'),
          onPressed: () { Navigator.pop(context, null ); }
        ),
        new FlatButton(
          child: new Text('OK', style: new TextStyle(color: yellowAccentColor ) ),
          onPressed: ()=> updateTags()
        ),        
      ],
    );    
  }

  void updateTags(){
    var selectedTags = tagsPickerKey.currentState.tags.entries.where((x)=> x.value).map((x)=> x.key).toList();       
                     
    onTagsChanged(selectedTags);
    Navigator.pop(context, selectedTags);
  }

  Widget _buildNoTagsIndicator(){
    return new Text("Brak tagów" , textAlign: TextAlign.left, style: new TextStyle(color: lightGreyTextColor));
  }

  Widget _buildTagElement(String tag){
    return new Container(
      decoration: new BoxDecoration(
        color: yellowAccentColor,
        borderRadius: new BorderRadius.all( const Radius.circular(20.0))
      ),
      child: new Padding(
        child: new Text(tag, style: new TextStyle(color: Colors.white, fontSize: 12.0)),
        padding: new EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      )
    );
  }

  void showAddNewTagDialog(){
    showDialog<String>(context: context,builder: buildAddNewTagDialog ).then((newTag){      
      if(newTag != null){
        this.tagsPickerKey.currentState.tags.putIfAbsent(newTag, ()=> true );        
        this.tagsPickerKey.currentState.setState( ()=> this.tagsPickerKey.currentState.tags);
      }
    });
  }

  Widget buildAddNewTagDialog(BuildContext context){
    var dialog = new AlertDialog(
      content: buildAddNewTagDialogContent(),
      title:  new Text("Dodaj nowy tag", style: new TextStyle(color: Colors.black)),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CANCEL'),
          onPressed: () { 
            Navigator.pop(context, null );
            this.setState( ()=> newTagValue = null); 
          }
        ),
        new FlatButton(
          child: new Text('ADD', style: new TextStyle(color: yellowAccentColor ) ),
          onPressed: () {
            Navigator.pop(context, this.newTagValue);
            this.setState( ()=> newTagValue = null);
          }
        ), 
      ]
    );

    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape ? new SingleChildScrollView(child:dialog) : dialog;
  }

  Widget buildAddNewTagDialogContent(){
    return new TextField(      
        style: new TextStyle(color: Colors.black),
        onChanged: (val)=> this.setState( ()=> newTagValue = val ),
    );
  }
  
}


class TagsPicker extends StatefulWidget{
  final List<String> tags;
  final Key key;
  TagsPicker(this.tags, this.key);
  @override
  State<StatefulWidget> createState() => new TagsPickerState(tags);
  static TagsPickerState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<TagsPickerState>());

}

class TagsPickerState extends State<TagsPicker> {
  List<String> providedTags;
  Map<String,bool> tags = new Map<String,bool>();


  TagsPickerState(this.providedTags){    
    var availableTags = new List.from(new RemoteService().getTags());

    for(var i = 0;i< availableTags.length;i++){
      bool selected = false;
      if(providedTags.contains(availableTags[i])) selected = true;
      tags.putIfAbsent(availableTags[i], ()=> selected);
    }

    for(var i=0; i < providedTags.length; i++){
      if(!availableTags.contains(providedTags[i])){
        tags.putIfAbsent(providedTags[i], ()=> true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {        
    var elements = new List<Widget>();

    tags.forEach((tag,selected){
      elements.add(_buildTagItem(tag, selected));
    });

    return new SingleChildScrollView(
      child: new Column(
        children: elements,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildTagItem(String tag, bool selected){
    var row = new Row(
      children: <Widget>[
        new Checkbox(value: selected, onChanged: (val)=> this.setState( ()=> tags[tag] = val) ),
        new Flexible( child: Text(tag, style: new TextStyle(color: Colors.black) ))
      ]
    );

    return new GestureDetector(
      child: new Container(child: row, color: Colors.transparent),
      onTap:  () => this.setState( ()=> tags[tag] = !tags[tag] ),
    );

  }

}