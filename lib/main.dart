import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/services/category_service.dart';
import 'utils/service_locator.dart';
import 'utils/colours.dart';
import 'package:twofortwo/utils/router.dart' as router;
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:firebase_core/firebase_core.dart';

// To use service locator:
//var userService = locator<LocalStorageService>();
ValueNotifier<bool> loading =
    ValueNotifier(false); // Global variable, to whole application

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await setupLocator();
    FirebaseOptions fOpts = FirebaseOptions(apiKey: "AIzaSyB4XUqmAX8iW3WNiggQpmEB8D8AltuHO2s", appId: "1:989534986832:android:088db125b51917e591a755", messagingSenderId: '989534986832', projectId: 'for2-9b41d');
    await Firebase.initializeApp();
    runApp(MyApp());
  } catch (error) {
    print('Locator setup has failed ');
    print(error);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    var localStorageService = locator<LocalStorageService>();
//    var userCategories = localStorageService.category;

    return MultiProvider(
      providers: [
        StreamProvider<FUser>.value(value: AuthService().user, initialData: FUser(uid: '1')), // Firebase user
        StreamProvider<List<Item>>.value(value: DatabaseService(uid: '').itemsRequested, initialData: [],),
        StreamProvider<List<ItemAvailable>>.value(value: DatabaseService(uid: '').itemsAvailable, initialData: [],),
        ChangeNotifierProvider<CategoryService>(create: (context) => CategoryService()),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
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

//  String _getStartupScreen(context) {
//    // TODO: this is for handling cases where user selected to stay logged in
//    var localStorageService = locator<LocalStorageService>();
//    var thisUser = Provider.of<User>(
//        context); // Provide does not work without build method
//
////    print(localStorageService.hasSignedUp);
////    print('test');
////    locator<LocalStorageService>().hasLoggedIn = false; // Every time the app is opened the user is logged out
////    locator<LocalStorageService>().hasSignedUp = false;
//    var alreadyLoggedIn = localStorageService.stayLoggedIn;
//    if (alreadyLoggedIn) {
//      User thisUser =
//          localStorageService.user; // Get user from storage, not firestore
//    } else {
//      final thisUser = Provider.of<User>(context);
//    }
//    if (thisUser == null) {
//      return AuthRoute;
//    } else {
//      return HomeViewRoute;
////      return HomeView();
//    }
//  }

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
