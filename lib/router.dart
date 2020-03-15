
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:twofortwo/screens/home_view.dart';
import 'package:twofortwo/screens/signup_view.dart';
import 'package:twofortwo/screens/undefined_view.dart';
import 'screens/category_view.dart';
import 'screens/BorrowList.dart';
import 'screens/login.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
switch(settings.name){
  case HomeViewRoute:
    return MaterialPageRoute(builder: (context) => HomeView());
  case CategoryRoute:
    return MaterialPageRoute(builder: (context) => ChooseCategory());
  case BorrowListRoute:
    var chosenCategories = settings.arguments;
    return MaterialPageRoute(builder: (context) => ToBorrow(chosenCategories: chosenCategories,));
  case LoginRoute:
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => LoginView());
  case SignupRoute:
    return MaterialPageRoute(builder: (context) => SignupView());
  default:
    return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
}
}