import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import '../../../utils/routing_constants.dart';
import '../../../utils/service_locator.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';


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

  String itemName;
  String description;
  String date;
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
    final _textFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);

    return Scaffold(
      backgroundColor: colorCustom,
      body: Center(
        child: Container(
          width: screenWidth(context, dividedBy: 1.2),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Add item',
                  style: _titleFont,
                ),
                SizedBox(height: 60.0),
                TextFormField(
                onChanged: (val){
                setState(() {
                itemName = val;});
                },
                  decoration: textInputDecoration.copyWith(labelText: 'Item name'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      description = val;});
                  },
                  decoration: textInputDecoration.copyWith(labelText: 'Description'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      date = val;});
                  },
                  decoration: textInputDecoration.copyWith(labelText: 'Requested usage date'),
                ),
                SizedBox(height: 20),
                //createDropDown(context),
                DropdownButton(
                  hint: Text(
                      'Please choose a category',
                    style: _textFont,), // Not necessary for Option 1
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      child: new Text(category,style: _textFont),
                      value: category,
                    );
                  }).toList(),
                ),
                ButtonWidget(icon: Icons.add, onPressed: onPressedBtn),
              ], // Children
            ),
          ),
        ),
      ),
    );
  }

  onPressedBtn() async {
    newItem =
    new Item(_selectedCategory, itemName, date, description);
    var storageService = locator<LocalStorageService>();
    //TODO: save JSON to firebase here
    storageService.item = newItem; // Setter
    Item item1 = storageService.item; //  Getter
    print("new iteM:");
    print(item1);
    Navigator.pop(context);
  }

}
