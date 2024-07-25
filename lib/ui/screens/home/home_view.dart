import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import '../../../utils/service_locator.dart';
import 'package:flutter/services.dart';
import 'package:twofortwo/ui/responsive/screen_type_layout.dart';
import 'package:twofortwo/ui/responsive/orientation_layout.dart';
import 'home_view_mobile.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/auth.dart';



class HomeView extends StatefulWidget {
//  final List<dynamic> chosenCategories;
  final FUser user; // Firebase user

  const HomeView({required Key key, required this.user}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{

//AnimationController _animationController;
//static const double maxSlide = 200.0 ;//TODO, responsive
//static const Duration toggleDuration = Duration(milliseconds: 250);

//static const double minDragStartEdge = 20;
//static const double maxDragStartEdge = maxSlide - 16;
//bool _canBeDragged = false;

//@override
//void initState(){
//  super.initState();
////  _animationController = AnimationController(
////    vsync: this,
////    duration: _HomeViewState.toggleDuration,
////  );
//}

//void close() => _animationController.reverse();
//
//void open() => _animationController.forward();
//
//void toggleAnimation() => _animationController.isCompleted ? close() : open();

//@override
//void dispose() {
//  _animationController.dispose();
//  super.dispose();
//}


@override
  Widget build(BuildContext context) {


    FUser thisUser = widget.user;


    return StreamProvider<User?>.value(
      value: DatabaseService(uid: thisUser.uid).userData, //TODO: really don't need this as a stream. Only need it once for the userData.
      initialData: User(uid: "1", name: ""),
      child: WillPopScope(
        /* This function ensures the user cannot route back to categories with the back button */
        onWillPop: () async {
            return _confirmLogout(context);
        }, // The page will not respond to back press
        child: ScreenTypeLayout(
          desktop: OrientationLayout(
                    portrait:
                            BorrowListPortrait(),
                    landscape: BorrowListPortrait() ,),
          tablet: OrientationLayout(
                    portrait:
                            BorrowListPortrait(),
                    landscape: BorrowListPortrait() ,),
          mobile: OrientationLayout(
                    portrait:
                            BorrowListPortrait(),
                    landscape: BorrowListPortrait() ,)
            //landscape: //TODO,
          ),
        ),

      );
//    );
  }
//
//
//void _onDragStart(DragStartDetails details) {
//  bool isDragOpenFromLeft = _animationController.isDismissed;
//  bool isDragCloseFromRight = _animationController.isCompleted;
//  _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
//}
//
//void _onDragUpdate(DragUpdateDetails details) {
//  if (_canBeDragged) {
//    double delta = details.primaryDelta / maxSlide;
//    _animationController.value += delta;
//  }
//}
//
//void _onDragEnd(DragEndDetails details) {
//  //I have no idea what it means, copied from Drawer
//  double _kMinFlingVelocity = 365.0;
//
//  if (_animationController.isDismissed || _animationController.isCompleted) {
//    return;
//  }
//  if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
//    double visualVelocity = details.velocity.pixelsPerSecond.dx /
//        MediaQuery.of(context).size.width;
//
//    _animationController.fling(velocity: visualVelocity);
//  } else if (_animationController.value < 0.5) {
//    _animationController.reverse();
//  } else {
//    _animationController.forward();
//  }
//}


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
          new TextButton(
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
          new TextButton(
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
