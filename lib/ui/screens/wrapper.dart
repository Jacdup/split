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

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
//    print(user);

    if (user == null){
      return Authenticate();
    }else{
      return HomeView();
    }

//    onGenerateRoute: (settings){
//      return router.generateRoute(settings);//TODO: how to pass arguments here
//    },
//    initialRoute: _getStartupScreen(),

    return Authenticate();



  }

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