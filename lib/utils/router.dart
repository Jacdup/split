
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:twofortwo/ui/screens/home/contact_item.dart';
import 'package:twofortwo/ui/screens/home/splash_screen.dart';
import 'package:twofortwo/ui/screens/authenticate/signup_view.dart';
import 'package:twofortwo/ui/screens/user/messages.dart';
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
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => ChooseCategory(itemDetails: argument,));
  case BorrowListRoute:
//    var chosenCategories = settings.arguments;
    return MaterialPageRoute(builder: (context) { return HomeView(); });
  case LoginRoute:
//    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => Login());
  case SignupRoute:
    return MaterialPageRoute(builder: (context) => SignupView());
  case NewItemRoute:
    var argument = settings.arguments;
    return MaterialPageRoute(builder: (context) => NewItem(uidTabItem: argument,));
    case contactItemOwnerRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __){
            return ContactItemOwner(userItemDetails: argument,);
          },
          transitionsBuilder: (context, animation, sA, child){// https://flutter.dev/docs/cookbook/animation/page-route-animation
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return ScaleTransition(
              scale: curvedAnimation,
                alignment: Alignment.bottomRight,
                child: child);
      }
      );//);
    case MessagesRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __){
            return UserMessages(userData: argument,);
          },
          transitionsBuilder: (context, animation, sA, child){// https://flutter.dev/docs/cookbook/animation/page-route-animation
            var begin = Offset(0.6, 0);
            var end = Offset.zero;
            var curve = Curves.decelerate;
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
//              reverseCurve: Curves.fastOutSlowIn,
            );
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);
            return ScaleTransition(
              scale: curvedAnimation,
              alignment: Alignment.centerLeft,
//              alignment: Ali,
//              position: offsetAnimation,
//                scale: curvedAnimation,
                child: child);
          }
      );//);
      return MaterialPageRoute(builder: (context) => UserMessages(userData: argument,));
    case ProfileRoute:
      var argument = settings.arguments;
      return MaterialPageRoute(builder: (context) => UserDetails(userData: argument,));
    case UpdateItemRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __){
            return UserItemDetails(userData:  argument,);
          },
          transitionsBuilder: (context, animation, sA, child){
            var begin = Offset(0.6, 0);
            var end = Offset.zero;
            var curve = Curves.decelerate;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
                child: child);
          }
      );//);
//      return MaterialPageRoute(builder: (context) => UserItemDetails(userData:  argument,));
  default:
    return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name));
}
}