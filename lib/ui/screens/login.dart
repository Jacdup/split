import 'package:flutter/material.dart';
import '../../utils/screen_size.dart';
import '../../utils/routing_constants.dart';
import '../../utils/service_locator.dart';
import '../../services/localstorage_service.dart';
import '../../services/user_service.dart';


//var mySavedUser = storageService.user;
//var userService = locator<UserService>();



class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>{
 // final String argument;
  //const LoginView({Key key}) : super(key: key);
  //final String title;
  final userName = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userName.dispose();

    super.dispose();
  }

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
            controller: userName,
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
              //TODO: validation, get user
              var storageService = locator<LocalStorageService>();
              storageService.hasLoggedIn = true;
              var savedCategories = storageService.category; // Getter
              //storageService.user = userName.text; // TODO: this should query FireBase

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
