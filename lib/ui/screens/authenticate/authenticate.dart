import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/ui/screens/authenticate/signup_view.dart';
import 'login.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{

  bool showLogIn = true;
  void toggleView(){
    setState(() => showLogIn = !showLogIn); // Sets to the opposite value of current val
  }

  @override
  Widget build(BuildContext context) {

    if (showLogIn){
      return Login(toggleView: toggleView);
    }else{
      return SignupView(toggleView: toggleView);
    }

  }
}