
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
import 'package:twofortwo/ui/screens/home/splash_screen.dart';
import 'package:twofortwo/ui/screens/authenticate/signup_view.dart';
import 'package:twofortwo/ui/screens/user/user_details_view.dart';
import 'package:twofortwo/ui/screens/undefined_view.dart';
import '../ui/screens/home/category_view.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/authenticate/login.dart';
import 'routing_constants.dart';
import '../ui/screens/home/new_item_view.dart';
import 'package:twofortwo/ui/screens/wrapper.dart';
import 'package:twofortwo/ui/screens/user/user_item_view.dart';

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
//    var chosenCategories = settings.arguments;
    return MaterialPageRoute(builder: (context) { return HomeView(); });
  case LoginRoute:
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => Login());
  case SignupRoute:
    return MaterialPageRoute(builder: (context) => SignupView());
  case NewItemRoute:
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => NewItem(uid: argument,));
    case getItemInfoRoute:
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => ItemInfo(numType: argument));
//num: argument, type: argument,
    case ProfileRoute:
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => UserDetails(userData: argument,));
    case UpdateItemRoute:
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => UserItemDetails(userData:  argument,));
  default:
    return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
}
}