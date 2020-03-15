//import 'main.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import '../routing_constants.dart';
import '../service_locator.dart';



class ToBorrow extends StatelessWidget{
  final List<String> chosenCategories;
  //final Category chosenCategories1;

  const ToBorrow({Key key, this.chosenCategories}) : super(key: key);


  final _itemFont = const TextStyle(fontSize: 15.0);

  /*var borrowItem1 = {
    'category' : 'Household',
    'itemName' : 'Example Name',
    'date' : '03/2020 - 04/2020',
    'Description' : 'Generic description',
  };*/

  static const item1 = BorrowList('Household', 'Example name', '03/2020 - 04/2020', 'Generic description');
 // final Data _categories;
 // SecondPage({this._categories});

  Widget build(BuildContext context) {
    return WillPopScope(
      /* This function ensures the user cannot route back to categories with the back button */
      onWillPop: () async {
        _confirmLogout(context);
        return false;
      }, // The page will not respond to back press
    child: Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Edit Categories'),
              onTap: () {

                Navigator.pop(context); // This one for the drawer
                Navigator.pushReplacementNamed(context, CategoryRoute);
                //Navigator.pop(context); // This one for the BorrowList
               // Navigator.pushReplacementNamed(context, CategoryRoute);
                //Navigator.popAndPushNamed(context, CategoryRoute);
                //Navigator.pop(context, CategoryRoute)
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Add request'),
          icon: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),

      appBar: AppBar(
        title: Text('List of items'),
      ),
      body: _buildBorrowList(),
    ),
    );
  }

  Widget _buildBorrowList() {
    //final chosenCategories = chosenCategories1.categories;
    //return ListView.builder(
    return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index){
      //  children: <Widget>[
       // for (var items in borrowItem1.keys)
        //itemBuilder: /*1*/ (context, i) {
          //if (i.isOdd) return Divider();

          if (chosenCategories.contains(item1.category)){//TODO: iterate over items in borrowList here
            return _buildRow(chosenCategories.first, item1.itemName, item1.date, item1.description);}
          else{
            return Text("No items in chosen category");
          }
        },
//],
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    //    }
        );
  }

  Widget _buildRow(String category, String itemName, String date, String description) {
    // final bool alreadySaved = _saved.contains(pair);
    return Card(
     child: ListTile(
      title: Text(
        itemName,
        //pair.asPascalCase,
        style: _itemFont,
      ),
      subtitle: Text(
        description,
      ),
      trailing: Text(
        date,
      ),
      onTap: () {},//TODO: create expandable thing here
      ),
    );}
}

class BorrowList {

  final String date ;
  final String description;
  final String itemName;
  final String category;

  const BorrowList(this.category, this.itemName, this.date, this.description);
}

void _confirmLogout(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Confirm Logout"),
        content: new Text("Are you sure you want to log out?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () {
              locator<LocalStorageService>().hasLoggedIn = false;
              Navigator.pop(context); // Pop the AlertDialog
              Navigator.pushReplacementNamed(context, LoginRoute);
            },
          ),
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}