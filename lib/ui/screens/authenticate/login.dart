import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/service_locator.dart';
import '../../../services/localstorage_service.dart';

import '../../../services/user_service.dart';


//var mySavedUser = storageService.user;
//var userService = locator<UserService>();



class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login>{
 // final String argument;
  //const LoginView({Key key}) : super(key: key);
  //final String title;
  final AuthService _auth = AuthService();
  bool rememberMe = false;
  final userName = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userName.dispose();
    super.dispose();
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;
    if (rememberMe) {
      // Functionality that remembers the user.
      locator<LocalStorageService>().stayLoggedIn = true;
    } else {
      // Forget the user
      locator<LocalStorageService>().stayLoggedIn = false;
    }
  });

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
          Text('Stay logged in?'),
          Checkbox(
            value: rememberMe,
            onChanged: _onRememberMeChanged,
          ),

          Container(
            margin: const EdgeInsets.all(50.0),
            height: screenHeight(context, dividedBy: 14) ,
            width: screenWidth(context,dividedBy: 3),
            child: RaisedButton(
            onPressed: () async {
              //TODO: validation, get user
//              var storageService = locator<LocalStorageService>();
//              storageService.hasLoggedIn = true;
//              var savedCategories = storageService.category; // Getter
              //storageService.user = userName.text;
              dynamic result = await _auth.signInAnon();


              if (result == null){
                print("Error signing in"); // TODO: show message to user
              }else {
                print("signed in");
                if (rememberMe){
                  // Save the current FireStore user to local storage
                  locator<LocalStorageService>().user = result;
                }
                //TODO: get categories of user
                print(result);
                print(locator<LocalStorageService>().stayLoggedIn);
              }
//              Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: savedCategories);// Not to return to this function
              },

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
