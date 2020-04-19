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

  final itemName = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();
  final category = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    itemName.dispose();
    description.dispose();
    date.dispose();
    category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    Hero(
//      tag: "New Request",
//      child: Image.asset('split.png'),
//    );

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 100),
          //height: screenHeight(context, dividedBy: 1, reducedBy: 200) ,
          width: screenWidth(context, dividedBy: 1.5),
          child: Column(
            children: [
              TextField(
                controller: itemName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item name',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: date,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Requested usage date',
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
              RaisedButton(
                onPressed: () {
//                  print("new item cat: ");
//                  print(_selectedCategory);
                  newItem = new Item(_selectedCategory, itemName.text, date.text, description.text);
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
                child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ], // Children
          ),
        ),
      ),
    );
  }
}
