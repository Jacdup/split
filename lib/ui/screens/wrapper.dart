import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/push_notifications.dart';
import 'package:twofortwo/ui/screens/home/home_view.dart';
import 'authenticate/authenticate.dart';
import 'package:twofortwo/services/user_service.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
//    var localStorageService = locator<LocalStorageService>();

    final FUser user = Provider.of<FUser>(context); // Firestore user (contains uid, email)
    bool _initialized = false;
//    print(user.uid);
//    Future<SplitUser> userAll = getUser(user.uid);
//    userAll.then((User result){
//      SplitUser userAll = result;
//      print(userAll);
//    });

//    Future<SplitUser> userAll  = getUser(user.uid); // Database user with the rest of the info
//    var alreadyLoggedIn = localStorageService.stayLoggedIn;

    // First check whether there exists a local copy of user, if not go to firebase
    // Dont have to
//    if (alreadyLoggedIn){
//      print("Stay logged in true");
//      SplitUser user = localStorageService.user;
//      if (user == null) {
//        print("Could not retrieve user from localstorage");
//      }else{
//        return HomeView(user: user,);
//      }
//    }else
      if (user == null){
      return Authenticate();
//      return AuthRoute;
    }else{ // We have a user, so initialize tokens
        if (!_initialized) {
          PushNotificationsManager().init(
              user.uid); //TODO: is this the right place to do this?
          _initialized = true;
        }
      return HomeView(user: user,);
    }


//    initialRoute: _getStartupScreen(),

//    return Authenticate();



  }

//  Future<User> getUser(String uid)async {
//   return await DatabaseService(uid: uid).user;
////        .then((User result){
////      print(result);
////      return result;
//
////    });
//  }

//  String _getStartupScreen() {
//    // TODO: this is for handling cases where user selected to stay logged in
//    var localStorageService = locator<LocalStorageService>();
//
////    print(localStorageService.hasSignedUp);
////    print('test');
////    locator<LocalStorageService>().hasLoggedIn = false; // Every time the app is opened the user is logged out
////    locator<LocalStorageService>().hasSignedUp = false;
//    var alreadyLoggedIn = localStorageService.stayLoggedIn;
//    User thisUser = localStorageService.user; // Get user from storage, not firestore
//
//
//    if (alreadyLoggedIn) {
//      return HomeViewRoute; //TODO: pass thisUser to HomeViewRoute constructor
//    } else {
//      return AuthRoute;
//    }
//  }

}