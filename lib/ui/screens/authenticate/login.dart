import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/utils/colours.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/service_locator.dart';
import '../../../services/localstorage_service.dart';

import '../../../services/user_service.dart';

//var mySavedUser = storageService.user;
//var userService = locator<UserService>();

class Login extends StatefulWidget {

  final Function toggleView;

  Login({this.toggleView});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  // final String argument;
  //const LoginView({Key key}) : super(key: key);
  //final String title;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  final _itemFont =
      const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
  final _textFont = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);
  final _errorFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);
//  final _itemFont = const TextStyle(fontSize: 18, color: Colors.black);
  final _borderColour = Colors.black87;
  final _borderWidth = 1.2;
  String email = '';
  String password = '';
  String error = '';
//  final userName = TextEditingController();

//  @override
//  void dispose() {
//    // Clean up the controller when the widget is disposed.
//    userName.dispose();
//    super.dispose();
//  }

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
    final _space = screenHeight(context, dividedBy: 30);

    return Scaffold(
        backgroundColor: colorCustom,
        appBar: AppBar(
          backgroundColor: colorCustom,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: (){
             widget.toggleView();
             },
                icon: Icon(Icons.person,size:35), label: Text('Register', style: _textFont,)),
          ]
        ),
        body: Center(
          child: Container(
//            padding: EdgeInsets.only(top: screenHeight(context, dividedBy: 8)),
            //height: screenHeight(context, dividedBy: 1, reducedBy: 200) ,
            width: screenWidth(context, dividedBy: 1.5),
            child: Form(
              key: _formKey, // Keep track of form
              child: SingleChildScrollView(
                child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
//            this.runtimeType.toString(),
                      'login',
                      style: _itemFont,
                    ),
                    SizedBox(height: _space*2),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email address' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
//            controller: userName,
                      decoration: textInputDecoration.copyWith(labelText: 'Email'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length < 6 ? 'Password must be 6 or more characters' : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(labelText: 'Password'),
                    ),
                    SizedBox(height: _space/2),
                    Container(
//              margin: const EdgeInsets.all(5.0),
                        height: screenHeight(context, dividedBy: 14),
                        width: screenWidth(context, dividedBy: 1.6),
//              alignment: Alignment(screenWidth(context, dividedBy: 2),screenWidth(context, dividedBy: 3)),
                        child: Row(
                          children: <Widget>[
                            Text('Keep me logged in'),
                            Checkbox(
                              value: rememberMe,
                              onChanged: _onRememberMeChanged,
                            ),
                          ],
                        )),
                    SizedBox(height: _space,),
//                    _buildButton(),
                    ButtonWidget(icon: Icons.arrow_forward, onPressed:onPressedBtn),
                    SizedBox(height: _space,),
                    Text(error, style: _errorFont ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  //_ChooseCategoryState createState() => _ChooseCategoryState();
onPressedBtn() async {
    //TODO: validation, get user
//              var storageService = locator<LocalStorageService>();
//              storageService.hasLoggedIn = true;
//              var savedCategories = storageService.category; // Getter
    //storageService.user = userName.text;
    // Validation
    if (_formKey.currentState.validate()) {
      // Is correct
      dynamic result = await _auth.signIn(email, password);
      if (result == null) {
        setState(() {
          error = 'Could not sign in, please check details';
        });
      } else {
        print(result);
        if (rememberMe) {
          // Save the current FireStore user to local storage
          locator<LocalStorageService>().user = result;
        }
      }
    }

//              Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: savedCategories);// Not to return to this function
}


//  Widget _buildButton() {
//    return Container(
//      margin: const EdgeInsets.all(50.0),
//      height: screenHeight(context, dividedBy: 14),
//      width: screenWidth(context, dividedBy: 2.5),
////            decoration: InputDecoration(borderRadius: BorderRadius.circular(32.0)),
//
//      child: RaisedButton(
//          shape:
//              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
//          color: Colors.amberAccent,
//          onPressed: () async {
//            //TODO: validation, get user
////              var storageService = locator<LocalStorageService>();
////              storageService.hasLoggedIn = true;
////              var savedCategories = storageService.category; // Getter
//            //storageService.user = userName.text;
//            // Validation
//            if (_formKey.currentState.validate()){
//              // Is correct
//              dynamic result = await _auth.signIn(email, password);
//              if (result == null){
//                setState(() {
//                  error = 'Could not sign in, please check details';
//                });
//              }else {
//                print(result);
//                if (rememberMe) {
//                  // Save the current FireStore user to local storage
//                  locator<LocalStorageService>().user = result;
//                }
//              }
//            }
//
////              Navigator.pushReplacementNamed(context, BorrowListRoute, arguments: savedCategories);// Not to return to this function
//          },
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
////                    Container(
////                      padding: EdgeInsets.fromLTRB(10, 4, 4, 4)
////                    ),
//              Center(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Align(
//                      alignment: Alignment.bottomRight,
//                      child: Icon(
//                        Icons.arrow_forward,
//                        color: Colors.black87,
//                        size: screenWidth(context, dividedBy: 11), // TODO: responsive this
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          )),
//    );
//  }
}
