import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import '../../../utils/routing_constants.dart';
import '../../../utils/service_locator.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';


class NewItem extends StatefulWidget {
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
//  List<String> _locations = [
//    'Stellenbosch',
//    'Rustenburg',
//    'buenos aires'
//  ]; // Option 2
//  String _selectedLocation; // Option 2
  List<String> _categories = [
    'Sport',
    'Camp',
    'Household',
    'Automobile',
    'Books',
    'Boardgames'
  ];

   String _selectedCategory;

  Item newItem;

//  final itemName = TextEditingController();
  String itemName;
  String description;
//  final description = TextEditingController();
  String date;
//  final date = TextEditingController();
  final category = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
//    itemName.dispose();
//    description.dispose();
//    date.dispose();
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    Hero(
//      tag: "New Request",
//      child: Image.asset('split.png'),
//    );
    final _titleFont = const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold );
    final _itemFont = const TextStyle(fontSize: 18, color: Colors.black);
  final _borderColour = Colors.black87;
  final _borderWidth = 1.2;

    return Scaffold(
      backgroundColor: colorCustom,
      body: Center(
        child: Container(
//          padding: EdgeInsets.only(top: screenHeight(context, dividedBy: 15)),
          //height: screenHeight(context, dividedBy: 1, reducedBy: 200) ,
          width: screenWidth(context, dividedBy: 1.2),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
//            this.runtimeType.toString(),
                  'Add item',
                  style: _titleFont,
                ),
                SizedBox(height: 60.0),
                TextFormField(
//                controller: itemName,
                onChanged: (val){
                setState(() {
                itemName = val;});
                },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color:_borderColour, width:_borderWidth)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    labelText: 'Item name',
                    labelStyle: _itemFont,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      description = val;});
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color:_borderColour, width:_borderWidth)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    labelText: 'Description',
                    labelStyle: _itemFont,

                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      date = val;});
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color:_borderColour, width:_borderWidth)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    labelText: 'Requested usage date',
                    labelStyle: _itemFont,
                  ),
                ),
                SizedBox(height: 20),
                //createDropDown(context),
                DropdownButton(
                  hint: Text(
                      'Please choose a category'), // Not necessary for Option 1
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      child: new Text(category),
                      value: category,
                    );
                  }).toList(),
                ),
                _buildButton()
//                RaisedButton(
//                  onPressed: () {
////                  print("new item cat: ");
////                  print(_selectedCategory);
//                    newItem = new Item(_selectedCategory, itemName, date, description);
////                  print("new iteM:");
////                      print(newItem.category);
//                    //newItem = new Item(itemName: itemName.text, description: description.text, category: , date: date);
//                    var storageService = locator<LocalStorageService>();
//                    //TODO: save JSON to firebase here
//                    storageService.item = newItem; // Setter
//                    Item item1 = storageService.item; //  Getter
//                    print("new iteM:");
//                    print(item1);
//                    Navigator.pop(context);
//
//                  },
//                  child: const Text(
//                      'Add',
//                      style: TextStyle(fontSize: 20)
//                  ),
//                ),
              ], // Children
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(){
    return
      Container(
        margin: const EdgeInsets.all(50.0),
        height: screenHeight(context, dividedBy: 14) ,
        width: screenWidth(context,dividedBy: 2.5),
//            decoration: InputDecoration(borderRadius: BorderRadius.circular(32.0)),

        child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            color: Colors.amberAccent,
//                child: Text('',
//                  style: TextStyle(fontSize: 20)
//                ),
//                icon: Icon( Icons.arrow_forward),

            onPressed: () async {
//                  print("new item cat: ");
//                  print(_selectedCategory);
              newItem =
              new Item(_selectedCategory, itemName, date, description);
//                  print("new iteM:");
//                      print(newItem.category);
              //newItem = new Item(itemName: itemName.text, description: description.text, category: , date: date);
              var storageService = locator<LocalStorageService>();
              //TODO: save JSON to firebase here
              storageService.item = newItem; // Setter
              Item item1 = storageService.item; //  Getter
              print("new iteM:");
              print(item1);
              Navigator.pop(context);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.fromLTRB(10, 4, 4, 4)
//                    ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth(context, dividedBy: 9), 0, 0, 0),
                  child: Icon(
                    Icons.add,
                    color:Colors.black87,
                    size: screenWidth(context,dividedBy: 11),
                  ),
                ),
              ],
            ),



        ),
      );
  }
}
