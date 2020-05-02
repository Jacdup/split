import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/utils/colours.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/service_locator.dart';
import '../../../services/localstorage_service.dart';


class Login extends StatefulWidget {
  final Function toggleView;

  Login({this.toggleView});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _obscureText = true;

  bool rememberMe = false;


  String email = '';
  String password = '';
  String error = '';


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
                    'Register',
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
                    SizedBox(height: 10.0),
                    Text(
                      'Login',
                      style: itemFont,
                    ),
                    SizedBox(height: _space * 2),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter an email address' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(height: _space),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? 'Password must be 6 or more characters'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: _obscureText,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password',suffixIcon: _passwordIcon()),
                    ),
                    SizedBox(height: _space / 2),
                    Container(
                        height: screenHeight(context, dividedBy: 14),
                        width: screenWidth(context, dividedBy: 1.6),
                        child: Row(
                          children: <Widget>[
                            Text('Keep me logged in'),
                            Checkbox(
                              value: rememberMe,
                              onChanged: _onRememberMeChanged,
                            ),
                          ],
                        )),
                    SizedBox(height: _space),
                    ButtonWidget(
                        icon: Icons.arrow_forward, onPressed: onPressedBtn),
                    SizedBox(height: _space),
                    Text(error, style: errorFont),
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
      setState(() {
        loading = true;
      });

      dynamic result = await _auth.signIn(email, password);
      if (result == null) {
        setState(() {
          error = 'Could not sign in, please check details';
          loading = false;
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

  _passwordIcon() {
    return IconButton(
      icon: Icon(
        // Based on passwordVisible state choose the icon
        _obscureText
            ? Icons.visibility
            : Icons.visibility_off,
        color: Theme
            .of(context)
            .primaryColorDark,
      ),
      onPressed: () {
        // Update the state i.e. toggle the state of passwordVisible variable
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

}
