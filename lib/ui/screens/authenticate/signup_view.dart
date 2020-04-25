import 'package:flutter/material.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';

class SignupView extends StatefulWidget {

  final Function toggleView;

  SignupView({this.toggleView});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  List<String> _locations = ['Stellenbosch', 'Rustenburg', 'buenos aires']; // Option 2
  String _selectedLocation; // Option 2
  User userDetails;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPhone = '';
  String userPassword = '';

  String error = '';

  final _textFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);
  final _itemFont = const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
  final _errorFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);
  final _borderColour = Colors.black87;
  final _borderWidth = 1.2;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
//    userName.dispose();
//    userSurname.dispose();
//    userEmail.dispose();
//    userPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _space = screenHeight(context, dividedBy: 40);

    return Scaffold(
        backgroundColor: colorCustom,
        appBar: AppBar(
            backgroundColor: colorCustom,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(onPressed: (){
                widget.toggleView();
              },
                  icon: Icon(Icons.person,size:35), label: Text('Login', style: _textFont,)),
            ]
        ),
        body: Center(
          child: Container(
//            padding: EdgeInsets.only(top: screenHeight(context, dividedBy: 12)),
            //height: screenHeight(context, dividedBy: 1, reducedBy: 200) ,
            width: screenWidth(context,dividedBy: 1.5),
            child: Form(
              key: _formKey, // Keep track of form
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget> [
                    SizedBox(height: _space/2),
                    Text(
//            this.runtimeType.toString(),
                      'Register',
                      style: _itemFont,
                    ),
                    SizedBox(height: _space*2),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter your name & surname' : null,
                      onChanged: (val){
                        setState(() {
                          userName = val;
                        });
                      },
//            controller: userName,
                      decoration: textInputDecoration.copyWith(labelText: 'Name & surname'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email address' : null,
                      onChanged: (val){
                        setState(() {
                          userEmail = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(labelText: 'Email Address'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length!= 10 ? 'Enter a valid 10 digit phone number' : null,
                      onChanged: (val){
                        setState(() {
                          userPhone = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(labelText: 'Phone Number'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length < 6 ? 'Password must be 6 or more characters' : null,
                      onChanged: (val){
                        setState(() {
                          userPassword = val;
                        });
                      },
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(labelText: 'Password'),
                    ),
                    SizedBox(height: _space),
                    //createDropDown(context),
                    DropdownButton(
                      hint: Text('Please choose a location', style: _textFont,), // Not necessary for Option 1
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location, style: _textFont,),
                          value: location,
                        );
                      }).toList(),
                    ) ,
                    SizedBox(height: _space/2,),
                    ButtonWidget(icon: Icons.arrow_forward, onPressed:onPressedBtn),
                    SizedBox(height: _space,),
                    Text(error, style: _errorFont ),
                  ], // Children

                ),

              ),
            ),
          ),
        ));
  }
onPressedBtn() async {
  // Validation
  if (_formKey.currentState.validate()) {
    // Is correct
    dynamic result = await _auth.registerWithEmailAndPassword(
        userName, userEmail, userPhone, userPassword, _selectedLocation);
    if (result == null) {
      setState(() {
        error = 'Email invalid, or already in use!';
      });
    } else {
      print(result);
    }
  }
}


}

