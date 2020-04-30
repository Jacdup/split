import 'package:flutter/material.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/shared/loading.dart';

class SignupView extends StatefulWidget {
  final Function toggleView;

  SignupView({this.toggleView});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  List<String> _locations = [
    'Stellenbosch',
    'Rustenburg',
    'buenos aires'
  ]; // Option 2
  String _selectedLocation; // Option 2
  User userDetails;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String userName = '';
  String userLastName = '';
  String userEmail = '';
  String userPhone = '';
  String userPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final _space = screenHeight(context, dividedBy: 40);

    return loading ? Loading() : Scaffold(
        backgroundColor: customBlue5,
        appBar: AppBar(
            backgroundColor: customBlue5,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person, size: 35),
                  label: Text(
                    'Login',
                    style: textFont,
                  )),
            ]),
        body: Center(
          child: Container(
            width: screenWidth(context, dividedBy: 1.5),
            child: Form(
              key: _formKey, // Keep track of form
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _space / 2),
                    Text(
                      'Register',
                      style: itemFont,
                    ),
                    SizedBox(height: _space * 2),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter your first name' : null,
                      onChanged: (val) {
                        setState(() {
                          userName = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Name'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) =>
                      val.isEmpty ? 'Enter your surname' : null,
                      onChanged: (val) {
                        setState(() {
                          userLastName = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Surname'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter an email address' : null,
                      onChanged: (val) {
                        setState(() {
                          userEmail = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email Address'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length != 10
                          ? 'Enter a valid 10 digit phone number'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          userPhone = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Phone Number'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? 'Password must be 6 or more characters'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          userPassword = val;
                        });
                      },
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                    ),
                    SizedBox(height: _space),
                    DropdownButton(
                      hint: Text(
                        'Please choose a location',
                        style: textFont,
                      ), // Not necessary for Option 1
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(
                            location,
                            style: textFont,
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: _space/2),
                    ButtonWidget(
                        icon: Icons.arrow_forward, onPressed: onPressedBtn),
                    SizedBox(height: _space),
                    Text(error, style: errorFont),
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
      setState(() {
        loading = true;
      });



      dynamic result = await _auth.registerWithEmailAndPassword( // TODO: move to category screen first
          userName, userLastName, userEmail, userPhone, userPassword, _selectedLocation);

//      Navigator.pushNamed(context, CategoryRoute);

      if (result == null) {
        setState(() {
          error = 'Email invalid, or already in use!';
          loading = false;
        });
      } else {
        print(result);
      }
    }
  }
}
