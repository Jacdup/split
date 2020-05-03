import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/ui/screens/home/drawer.dart';
import '../../../utils/service_locator.dart';
import 'package:flutter/services.dart';
import 'package:twofortwo/ui/responsive/screen_type_layout.dart';
import 'package:twofortwo/ui/responsive/orientation_layout.dart';
import 'home_view_mobile.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/auth.dart';


class HomeView extends StatefulWidget {
//  final List<dynamic> chosenCategories;
  final User user;

  const HomeView({Key key, this.user}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{

AnimationController _animationController;
final double maxSlide = 225.0 ;//TODO, responsive

@override
void initState(){
  super.initState();
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 250)
  );
}

void toggleAnimation() => _animationController.isDismissed ? _animationController.forward() : _animationController.reverse();

@override
void dispose() {
  _animationController.dispose();
  super.dispose();
}


@override
  Widget build(BuildContext context) {

    var localStorageService = locator<LocalStorageService>();
//    final Item item1 = localStorageService.item; //  Getter

    //TODO: get all from database here
    List<String> chosenCategories;

    chosenCategories = localStorageService.category;


//    chosenCategories == null ? chosenCategories = DatabaseService().
//    widget.chosenCategories == null ? chosenCategories = localStorageService.category : chosenCategories = widget.chosenCategories;
    User thisUser = widget.user;
//    print(widget.chosenCategories);
   // var appInfo = Provider.of<AppInfo>(context);
//    var storageService = locator<LocalStorageService>();
//    User thisUser = storageService.user; // Getter
//    String userName = thisUser.name;

//    Hero(
//      tag: "New Request",
//      child: Image.asset('split.png'),
//    );
    return MultiProvider(
      providers: [
        StreamProvider<List<Item>>.value(value: DatabaseService().itemsRequested),
        StreamProvider<List<ItemAvailable>>.value(value: DatabaseService().itemsAvailable)
      ],
      child: WillPopScope(
        /* This function ensures the user cannot route back to categories with the back button */
        onWillPop: () async {
          return _confirmLogout(context);
          //return false;
        }, // The page will not respond to back press
        child: ScreenTypeLayout(
          mobile: OrientationLayout(
            portrait: GestureDetector(
              onTap: toggleAnimation,

              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context,_) {
                  double slide = maxSlide * _animationController.value;
                  double scale = 1 - (_animationController.value * 0.3);
                  return Stack(
                    children: <Widget>[
                      MenuDrawer(userData: thisUser,),
                      Transform(
                          transform: Matrix4.identity()
                            ..translate(slide)
                            ..
                            scale(scale),
                          alignment: Alignment.centerLeft,
                          child: BorrowListPortrait(user: thisUser,)),
                    ],
                  );
                }
              ),
            ),
            //landscape: //TODO,
          ),
        ),

      ),
    );
  }
}


 _confirmLogout(context) {

   final AuthService _auth = AuthService();
   final bool staySignedIn = locator<LocalStorageService>().stayLoggedIn; // Getter TODO: it might be better to pass this variable through the constructor, then we don't have to query the local storage every time

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Confirm Exit"),
        content: new Text("Are you sure you want to exit?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () async {

              if (!staySignedIn){
                await _auth.logOut();
//                locator<LocalStorageService>().hasLoggedIn = false;
              }
              //Navigator.pop(context); // Pop the AlertDialog
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
             // exit(0);
            },
          ),
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
 // return false;
  //return true;
}
