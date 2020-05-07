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

  final String uid;

  NewItem({this.uid});

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
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

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




    return loading
        ? Loading()
        : DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
                backgroundColor: customBlue5,
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(screenHeight(context, dividedBy: 4)),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.all(10.0),
                      centerTitle: true,
                      title: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Add item',
                              style: titleFont,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: customYellow2,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4.0,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.black38,
                      tabs: [
                        new Tab(text: "Post an item"),
                        new Tab(text: "Request an item"),
                      ],
                    ),
                  ),
                ),
                body: new TabBarView(
                  children: <Widget>[
                    _createFields('Dates available', _formKey2),
                    _createFields('Requested usage date', _formKey1),
                  ],
                )),
          );
  }

  Widget _createFields(String dateDescription, GlobalKey type) {
    return Form(
      key: type, // Keep track of form
      child: SingleChildScrollView(
        child: Container(
          width: screenWidth(context, dividedBy: 4),
          margin: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
//              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) {
                  setState(() {
                    itemName = val;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Item name'),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please provide a description' : null,
                keyboardType: TextInputType.multiline,
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Description'),
                maxLines: null,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter a date. Dates can be formatted dd/mm/yy or dd/mm/yyyy or some other variation. We are really not picky!' : null,
                keyboardType: TextInputType.datetime,
                onChanged: (val) {
                  setState(() {
                    date = val;
                  });
                },
                decoration: textInputDecoration.copyWith(
                    hintText: dateDescription),
              ),
              SizedBox(height: 20),
              //createDropDown(context),
              DropdownButtonFormField(
                decoration: textInputDecoration,
//                InputDecoration(
//                border:
//                OutlineInputBorder(
////                  isOutline: false,
////                  gapPadding: 100.0,
//                    borderRadius: borderRadius,
//                    borderSide: BorderSide(color: Colors.white, width: 2.0)),
//                    filled: true,
//                  fillColor: Colors.white,
////                  hintText: 'Please choose a category'
//                ),
                isDense: true,
                hint: Text(
                  'Please choose a category',
                  style: textFont,
                ), // Not necessary for Option 1
                value: _selectedCategory,
                onChanged: (newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    child: new Text(category, style: textFontDropDown),
                    value: category,
                  );
                }).toList(),
              ),

              (type == _formKey1) ? ButtonWidget(icon: Icons.add, onPressed: onPressedBtn1) : ButtonWidget(icon: Icons.add, onPressed: onPressedBtn2),



            ], // Children
          ),
        ),
      ),
    );
  }


  onPressedBtn1() async {

    if (_formKey1.currentState.validate()) {
      // Is correct
      setState(() {
        loading = true;
      });
//      newItem = new Item(_selectedCategory, itemName, date, description);
      dynamic result = await DatabaseService(uid: widget.uid).addItemRequestedData(itemName, description, date, _selectedCategory);

      if (result == null) {
        setState(() {
          error = 'Could not add item, please check details';
          loading = false;
        });
      } else {
        Navigator.pop(context);
      }
      Navigator.pop(context);
    }

  }


  onPressedBtn2() async {

    if (_formKey2.currentState.validate()) {
      // Is correct
      setState(() {
        loading = true;
      });
//      newItem = new Item(_selectedCategory, itemName, date, description);
      dynamic result = await DatabaseService(uid: widget.uid).addItemAvailableData(itemName, description, date, _selectedCategory);

      if (result == null) {
        setState(() {
          error = 'Could not add item, please check details';
          loading = false;
        });
      } else {
        Navigator.pop(context);
      }
      Navigator.pop(context);
    }

  }





}
