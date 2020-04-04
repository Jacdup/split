import 'package:flutter/material.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import '../../utils/screen_size.dart';
import '../../utils/service_locator.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/colours.dart';
//TODO: this should save categories specific to the user on the hard disk

class ChooseCategory extends StatefulWidget {
  ChooseCategory({Key key}) : super(key: key);
 // final String title;

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}


class _ChooseCategoryState extends State<ChooseCategory> {
  //int _counter = 0;
  final List<String> _categories = [
    'Sport',
    'Camp',
    'Household',
    'Automobile',
    'Books',
    'Boardgames'
  ];
  var storageService = locator<LocalStorageService>();
  final List<String> _selectedCategories = [];
  final _biggerFont = const TextStyle(fontSize: 25.0);

  @override
  Widget build(BuildContext context) {
    final btnNxt = SizedBox(
      height: screenHeightExcludingToolbar(context, dividedBy: 10) ,
      width: screenWidth(context, dividedBy: 3,reducedBy: 0),
      child: Center(child: Text('Next', style: TextStyle(fontSize: 30), textAlign: TextAlign.center),),
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
        title: Text('Choose Category'),
      ),
      body: Container(
        padding: EdgeInsets.only(top:40),
        height: screenHeight(context, dividedBy: 1) ,
        width: screenWidth(context,dividedBy: 1),
        child: Column(
          children: [
            //for (var item in _categories) _buildRow(item)
            //SizedBox(height: screenHeight(context, dividedBy: 3)),
            _buildRow(_categories.sublist(0, 2)),
            _buildRow(_categories.sublist(2, 4)),
            _buildRow(_categories.sublist(4)),

            SizedBox(height: screenHeight(context, dividedBy: 16)),
            RaisedButton(
              child: btnNxt,
              onPressed: () {
                // Save a value
                print("Has signed up value before:");
                print(storageService.hasSignedUp);
                storageService.category = _selectedCategories; // Setter
                storageService.hasSignedUp = true;
                print("Has signed up value after:");
                print(storageService.hasSignedUp);
                //set category(Category categoriesToSave)
                //var mySavedUser = storageService.user;


                Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: _selectedCategories);// Not to return to this function
                //Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: savedCategory);// Not to return to this function
               /* if (borrowListBack == 'fromBorrowList'){
                  showDialog(context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure?')
                  ));
                }*/
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToBorrow()),
                );*/
              },
            ),
            //  _buildNext(),
          ],
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildRow(List categories) {
    return Row(
      children: [for (var item in categories) _buildCard(item)],
    );
  }

  Widget _buildCard(String category) {

   // bool alreadySaved = false;
    //if (_selectedCategories.categories != null){
      final bool alreadySaved = _selectedCategories.contains(category);
   // }//else{
     // final bool
  //  }


    return Container(
      //padding: EdgeInsets.only(top:40),
      //color: Colors.cyan,
      //padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
      width: screenWidth(context, dividedBy: 2,reducedBy: 0),
      height: screenHeight(context, dividedBy: 6),
      //height: screenHeightExcludingToolbar(context, dividedBy: 5), //TODO: this causes pixel overflowing error
      // color: Colors.cyan,

      child: Card(
        color: colorCustom,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: alreadySaved ? Colors.red : Colors.transparent ,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),

            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _selectedCategories.remove(category);
                } else {
                  _selectedCategories.add(category);
                }
              });
            },
            child: Center(
              child: Container(
                child: Text(category, style: _biggerFont),
              ),
            ),
          ),
        ),
      ),
    );
  } // _buildCard

}


