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

// To use service locator:
//var userService = locator<LocalStorageService>();


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await setupLocator();
    runApp(
      DevicePreview( // This is for testing UI
        builder: (context) => MyApp(),
      ),
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
        builder: DevicePreview.appBuilder, //  This is for testing UI
        title: '2For2 Demo',
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          primarySwatch: colorCustom,
        ),
        home: Wrapper(),


        //onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name)),
        //home: MyHomePage(title: '2For2 Demo'),
      ),
    );
  }


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



