
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:twofortwo/ui/screens/home/splash_screen.dart';
import 'package:twofortwo/ui/screens/authenticate/signup_view.dart';
import 'package:twofortwo/ui/screens/undefined_view.dart';
import '../ui/screens/home/category_view.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/authenticate/login.dart';
import 'routing_constants.dart';
import '../ui/screens/home/new_item_view.dart';

Route<dynamic> generateRoute(RouteSettings settings){
switch(settings.name){
  case AuthRoute:
    return MaterialPageRoute(builder: (context) => Splash()); // TODO: change this to screen showing login or signup
  case SplashRoute:
    return MaterialPageRoute(builder: (context) => Splash());
  case HomeViewRoute:
    var chosenCategories = settings.arguments;
    return MaterialPageRoute(builder: (context) => HomeView(chosenCategories: chosenCategories));
  case CategoryRoute:
    return MaterialPageRoute(builder: (context) => ChooseCategory());
  case BorrowListRoute:
    var chosenCategories = settings.arguments;
    return MaterialPageRoute(builder: (context) => HomeView(chosenCategories: chosenCategories,));
  case LoginRoute:
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => Login());
  case SignupRoute:
    return MaterialPageRoute(builder: (context) => SignupView());
  case NewItemRoute:
    return MaterialPageRoute(builder: (context) => NewItem());
  default:
    return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
}
}