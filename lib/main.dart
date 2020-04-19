//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'utils/router.dart' as router;
import 'utils/service_locator.dart';
import './services/localstorage_service.dart';
import 'utils/colours.dart';
import 'package:device_preview/device_preview.dart';
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
    var localStorageService = locator<LocalStorageService>();
    var userCategories = localStorageService.category;
    return MaterialApp(
      builder: DevicePreview.appBuilder, //  This is for testing UI
      title: '2For2 Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primarySwatch: colorCustom,
      ),


      onGenerateRoute: (settings){
        return router.generateRoute(settings);//TODO: how to pass arguments here
      },
      initialRoute: _getStartupScreen(),
      //onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name)),
      //home: MyHomePage(title: '2For2 Demo'),
    );
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

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  *//*final leftColumn = Container(
    //padding: EdgeInsets.fromLTRB(20, 30, 80, 80),
    child: Card(
      child: Column(
        children: [
          Text('category'),
        ],
        //crossAxisAlignment: CrossAxisAlignment.start,
      ),
    ),
  );*//*

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _categories = [
    'Sport',
    'Camp',
    'Household',
    'Automobile',
    'Books',
    'Boardgames'
  ];
  final _selectedCategories = Set();
  final _biggerFont = const TextStyle(fontSize: 25.0);

  @override
  Widget build(BuildContext context) {
    final btnNxt = SizedBox(
        height: screenHeightExcludingToolbar(context, dividedBy: 10) ,
        width: screenWidth(context, dividedBy: 3,reducedBy: 0),
        child: Center(child: Text('Next', style: TextStyle(fontSize: 30), textAlign: TextAlign.center),),
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        height: screenHeight(context, dividedBy: 1) ,
        width: screenWidth(context,dividedBy: 1),
        child: Column(
          children: [
            //for (var item in _categories) _buildRow(item)
            _buildRow(_categories.sublist(0, 2)),
            _buildRow(_categories.sublist(2, 4)),
            _buildRow(_categories.sublist(4)),

           SizedBox(height: screenHeight(context, dividedBy: 16)),
            RaisedButton(
            child: btnNxt,
             onPressed: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => ToBorrow()),
               );
             },
            ),
          //  _buildNext(),
          ],
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildRow(List categories) {
    return Row(
      children: [for (var item in categories) _buildCard(item)],
    );
  }

  Widget _buildCard(String category) {
    final bool alreadySaved = _selectedCategories.contains(category);

    return Container(
      //color: Colors.cyan,
      //padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
      width: screenWidth(context, dividedBy: 2,reducedBy: 1),
      height: screenHeightExcludingToolbar(context, dividedBy: 4),
      // color: Colors.cyan,

      child: Card(
        color: Colors.cyan,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: alreadySaved ? Colors.red : Colors.transparent ,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),

            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _selectedCategories.remove(category);
                } else {
                  _selectedCategories.add(category);
                }
              });
            },
            child: Center(
              child: Container(
                child: Text(category, style: _biggerFont),
              ),
            ),
          ),
        ),
      ),
    );
  } // _buildCard

}*/


