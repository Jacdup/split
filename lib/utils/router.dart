
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
import 'package:twofortwo/ui/screens/home/splash_screen.dart';
import 'package:twofortwo/ui/screens/authenticate/signup_view.dart';
import 'package:twofortwo/ui/screens/home/update_user_details_view.dart';
import 'package:twofortwo/ui/screens/undefined_view.dart';
import '../ui/screens/home/category_view.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/authenticate/login.dart';
import 'routing_constants.dart';
import '../ui/screens/home/new_item_view.dart';
import 'package:twofortwo/ui/screens/wrapper.dart';

Route<dynamic> generateRoute(RouteSettings settings){
switch(settings.name){
  case AuthRoute:
    return MaterialPageRoute(builder: (context) => Splash()); // TODO: change this to screen showing login or signup
  case SplashRoute:
    return MaterialPageRoute(builder: (context) => Splash());
  case HomeViewRoute:
    return MaterialPageRoute(builder: (context) => Wrapper());
//    var chosenCategories = settings.arguments;
//    return MaterialPageRoute(builder: (context) => HomeView(chosenCategories: chosenCategories));
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
    case getItemInfoRoute:
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => ItemInfo(num: argument));

    case UpdateUserRoute:
      return MaterialPageRoute(builder: (context) => UpdateUserDetails());
  default:
    return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
}
}