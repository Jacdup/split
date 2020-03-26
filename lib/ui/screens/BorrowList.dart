//import 'main.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import '../../utils/routing_constants.dart';
import '../../utils/service_locator.dart';

import 'package:twofortwo/ui/responsive/screen_type_layout.dart';
import 'package:twofortwo/ui/responsive/orientation_layout.dart';
import 'home/home_view_mobile.dart';
import 'package:twofortwo/services/item_service.dart';


class ToBorrow extends StatelessWidget {


  final List<String> chosenCategories;
//  final String userName;
  //final Category chosenCategories1;

  const ToBorrow({Key key, this.chosenCategories}) : super(key: key);



  /*var borrowItem1 = {
    'category' : 'Household',
    'itemName' : 'Example Name',
    'date' : '03/2020 - 04/2020',
    'Description' : 'Generic description',
  };*/

  static const item1 = BorrowList(
      'Household', 'Example name', '03/2020 - 04/2020', 'Generic description');
  // final Data _categories;
  // SecondPage({this._categories});

  Widget build(BuildContext context) {
    // TODO: this should only be called after signup has been run
    var storageService = locator<LocalStorageService>();
    User thisUser = storageService.user; // Getter
    String userName = thisUser.name;

//    Hero(
//      tag: "New Request",
//      child: Image.asset('split.png'),
//    );
    return WillPopScope(
      /* This function ensures the user cannot route back to categories with the back button */
      onWillPop: () async {
        _confirmLogout(context);
        return false;
      }, // The page will not respond to back press
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: HomeMobilePortrait(chosenCategories: chosenCategories, borrowList: item1),
          //landscape: //TODO,
        ),
      ),


    );
  }
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
