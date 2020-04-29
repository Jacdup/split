import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/shared/loading.dart';
import '../../../utils/service_locator.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/services/database.dart';


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
   bool loading = false;

  Item newItem;

  String itemName;
  String description;
  String date;
  final category = TextEditingController();
  String error = '';

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


    return loading ? Loading() : Scaffold(
      backgroundColor: colorCustom,
      body: Center(
        child: Container(
          width: screenWidth(context, dividedBy: 1.2),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Add item',
                  style: titleFont,
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
                  keyboardType: TextInputType.multiline,
                  onChanged: (val){
                    setState(() {
                      description = val;});
                  },
                  decoration: textInputDecoration.copyWith(labelText: 'Description'),
                  maxLines: null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.datetime,
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
                    style: textFont,), // Not necessary for Option 1
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      child: new Text(category,style: textFontDropDown),
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

    // TODO: validation

    setState(() {
      loading = true;
    });
    newItem =  new Item(_selectedCategory, itemName, date, description);
    var storageService = locator<LocalStorageService>();

    dynamic result = await DatabaseService().updateItemData(itemName, description, date, _selectedCategory);
    if (result == null) {
      setState(() {
        error = 'Could not add item, please check details';
        loading = false;
      });
    } else {
      Navigator.pop(context);
      print(result);
    }
    Navigator.pop(context);

//    storageService.item = newItem; // Setter
//    Item item1 = storageService.item; //  Getter

//    if (item1 == null) {
//      setState(() {
//      loading = false;
//        });
//      error = 'Error adding item, please check details';
//
//    }
//    print("new iteM:");
//    print(item1);

  }

}
