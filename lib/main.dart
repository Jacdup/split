//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/auth.dart';
import 'utils/service_locator.dart';
import './services/localstorage_service.dart';
import 'utils/colours.dart';
import 'package:device_preview/device_preview.dart';
import 'ui/screens/wrapper.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/utils/router.dart' as router;
import 'package:twofortwo/utils/routing_constants.dart';

// To use service locator:
//var userService = locator<LocalStorageService>();


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await setupLocator();
    runApp( MyApp()
//      DevicePreview( // This is for testing UI
//        builder: (context) => MyApp(),
//      ),
    );
  } catch (error){
    print('Locator setup has failed');
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    var localStorageService = locator<LocalStorageService>();
//    var userCategories = localStorageService.category;

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: (settings){
          return router.generateRoute(settings);
        },

//        builder: DevicePreview.appBuilder, //  This is for testing UI
        title: '2For2 Demo',
        theme: ThemeData(
//          primarySwatch: colorCustom,
          primarySwatch: customBlue5,
        ),
//        home: Wrapper(), // becomes the route named '/'
          initialRoute: HomeViewRoute, // Temporary name for wrapper
//        onGenerateRoute: router.generateRoute,//TODO: how to pass arguments here
//        initialRoute: _getStartupScreen(context),

        //onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name)),
        //home: MyHomePage(title: '2For2 Demo'),
      ),
    );
  }


  String _getStartupScreen(context) {
    // TODO: this is for handling cases where user selected to stay logged in
    var localStorageService = locator<LocalStorageService>();
    var thisUser = Provider.of<User>(context); // Provide does not work without build method

//    print(localStorageService.hasSignedUp);
//    print('test');
//    locator<LocalStorageService>().hasLoggedIn = false; // Every time the app is opened the user is logged out
//    locator<LocalStorageService>().hasSignedUp = false;
    var alreadyLoggedIn = localStorageService.stayLoggedIn;
    if (alreadyLoggedIn) {
      User thisUser = localStorageService.user; // Get user from storage, not firestore
    }else {
      final thisUser = Provider.of<User>(context);
    }
    if (thisUser == null){
      return AuthRoute;
    }else{
      return HomeViewRoute;
//      return HomeView();
    }
    }

//    if (alreadyLoggedIn) {
//      return HomeViewRoute; //TODO: pass thisUser to HomeViewRoute constructor
//    } else {
//      return AuthRoute;
//    }
//  }


//    if(!localStorageService.hasSignedUp) {
//
////       return SignupRoute;
//    return LoginRoute;
////       return HomeViewRoute;
////    return SplashRoute;
//    }
//
////    if(!localStorageService.hasLoggedIn) {
//////      return LoginRoute;
//////    }
//
//    return HomeViewRoute;
//  }
}



