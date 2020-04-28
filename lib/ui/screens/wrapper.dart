import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/ui/screens/home/home_view.dart';
import 'authenticate/authenticate.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/utils/router.dart' as router;
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/database.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var localStorageService = locator<LocalStorageService>();

    final User user = Provider.of<User>(context); // Firestore user (contains uid, email)
//    print(user.uid);
//    Future<User> userAll = getUser(user.uid);
//    userAll.then((User result){
//      User userAll = result;
//      print(userAll);
//    });

//    Future<User> userAll  = getUser(user.uid); // Database user with the rest of the info
    var alreadyLoggedIn = localStorageService.stayLoggedIn;

    // First check whether there exists a local copy of user, if not go to firebase
    // Dont have to
//    if (alreadyLoggedIn){
//      print("Stay logged in true");
//      User user = localStorageService.user;
//      if (user == null) {
//        print("Could not retrieve user from localstorage");
//      }else{
//        return HomeView(user: user,);
//      }
//    }else
      if (user == null){
      return Authenticate();
//      return AuthRoute;
    }else{
      return HomeView(user: user,);
    }


//    initialRoute: _getStartupScreen(),

    return Authenticate();



  }

//  Future<User> getUser(String uid)async {
//   return await DatabaseService(uid: uid).user;
////        .then((User result){
////      print(result);
////      return result;
//
////    });
//  }

  String _getStartupScreen() {
    // TODO: this is for handling cases where user selected to stay logged in
    var localStorageService = locator<LocalStorageService>();

//    print(localStorageService.hasSignedUp);
//    print('test');
//    locator<LocalStorageService>().hasLoggedIn = false; // Every time the app is opened the user is logged out
//    locator<LocalStorageService>().hasSignedUp = false;
    var alreadyLoggedIn = localStorageService.stayLoggedIn;
    User thisUser = localStorageService.user; // Get user from storage, not firestore


    if (alreadyLoggedIn) {
      return HomeViewRoute; //TODO: pass thisUser to HomeViewRoute constructor
    } else {
      return AuthRoute;
    }
  }

}