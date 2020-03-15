import 'package:flutter/material.dart';
import '../screen_size.dart';
import '../routing_constants.dart';
import '../service_locator.dart';
import '../services/localstorage_service.dart';
import '../services/user_service.dart';


//var mySavedUser = storageService.user;
//var userService = locator<UserService>();

class LoginView extends StatelessWidget {
  @override
 // final String argument;
  const LoginView({Key key}) : super(key: key);
  //final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.runtimeType.toString(),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'username',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'password',
            ),
          ),
          Container(
            margin: const EdgeInsets.all(50.0),
            height: screenHeight(context, dividedBy: 14) ,
            width: screenWidth(context,dividedBy: 3),
            child: RaisedButton(
            onPressed: () {
              var storageService = locator<LocalStorageService>();
              storageService.hasLoggedIn = true;
              var savedCategories = storageService.category; // Getter

              Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: savedCategories);},// Not to return to this function

            child: Text(
                'proceed',
                style: TextStyle(fontSize: 20)
            ),
          ),
          )
        ],
      ),
    ));
  }
  //_ChooseCategoryState createState() => _ChooseCategoryState();
}
