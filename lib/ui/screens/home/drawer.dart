import 'package:flutter/material.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/auth.dart';


//class MenuDrawer extends StatelessWidget {
//
//  final userData;
//
//  MenuDrawer({this.userData});
//
//  final localStorageService = locator<LocalStorageService>();
//  final AuthService _auth = AuthService();
//
//  @override
//  Widget build(BuildContext context) {
////    return Scaffold(
//
//        body:
//        return Material(
//color: customBlue5,
////          alignment: Alignment.centerLeft,
////          margin: EdgeInsets.fromLTRB(0, 50.0, 200.0, 0),
//          child:
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                ListView(
//                  padding: EdgeInsets.zero,
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Text('Menu'),
//                        SizedBox(
//                          height: 20.0,
//                        ),
//                        CircleAvatar(
//                          radius: 40.0,
//                          backgroundColor: Colors.deepOrangeAccent,
////                        child: Text(
////                          userData.name.substring(0, 1) +
////                              userData.surname.substring(0, 1),
////                          style: TextStyle(fontSize: 25.0, color: Colors.white),
////                        ),
//                        )
//
////    )
//                      ],
//                    ),
//                    ListTile(
//                        title: Text('Edit my categories'),
//                        onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                          Navigator.pushNamed(context, CategoryRoute);
//                        }),
//                    ListTile(
//                        title: Text('Edit my items'),
//                        onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                          Navigator.pushNamed(context, UpdateItemRoute);
//                        }),
//                    ListTile(
//                        title: Text('Edit personal data'),
//                        onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                          Navigator.pushNamed(context, UpdateUserRoute, arguments: userData.uid);
//                        }),
//                    ListTile(
//                        title: Text('Logout'),
//                        onTap: () async {
//                          Navigator.pop(context); // This one for the drawer
////                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
////                setState(() {
//                          localStorageService.clear(); //  Remove all saved values
////                });
//
////                print(localStorageService.stayLoggedIn);
//                          await _auth.logOut();
////                Navigator.pushReplacementNamed(context, CategoryRoute);
//                        })
//                  ],
//                ),
//              ],
//            ),
//
//        );
////      );
//    }
//
//}
class MenuDrawer extends StatelessWidget {

  final User userData;


  MenuDrawer({required this.userData});

  final localStorageService = locator<LocalStorageService>();
  final AuthService _auth = AuthService();
  final textFont = const TextStyle(
      fontSize: 14.0, color: Colors.black87);


  @override
  Widget build(BuildContext context) {
    String? tag = userData.uid;
    return Drawer(
      child: Column(
       // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Menu', style: tabFont,),
                    SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                      tag: 'profilePic$tag',
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.deepOrangeAccent,
//                        child: Image.asset('split_new_blue1.png'),
                        child: Text(
                          userData.name.substring(0, 1) + userData.surname!.substring(0, 1),
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    )

//    )
                  ],
                )),
            decoration: BoxDecoration(
              color: customBlue5,
            ),
          ),

          ListTile(
              leading: Icon(Icons.category),
              title: Text('Edit my categories', style: textFont,),
              onTap: () {
                Navigator.pop(context); // This one for the drawer
                Navigator.pushNamed(context, CategoryRoute,);
              }),

          ListTile(
          leading: Icon(Icons.edit),
//              leading: Icon(Icons.edit_attributes),
          title: Text('My items', style: textFont),
          onTap: () {
            Navigator.pop(context); // This one for the drawer
            Navigator.pushNamed(context, UpdateItemRoute, arguments: userData);
          }),
          ListTile(
          leading: Icon(Icons.message),
//              leading: Icon(Icons.edit_attributes),
          title: Text('Messages', style: textFont),
          onTap: () {
            Navigator.pop(context); // This one for the drawer
            Navigator.pushNamed(context, MessagesRoute , arguments: userData);
          }),
         /* ListTile(

          leading: Icon(Icons.person),
          title: Text('Profile', style: textFont),
          onTap: () {
            print('profilePic$tag');
            Navigator.pop(context); // This one for the drawer
            Navigator.pushNamed(
                context, ProfileRoute, arguments: userData);
          }),*/
         Spacer(),
          ListTile(
          leading: Icon(Icons.call_end),
          title: Text('Logout', style: textFont),
          onTap: () async {
            Navigator.pop(context); // This one for the drawer
//                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
//                setState(() {
            localStorageService.clear(); //  Remove all saved values
//                });

//                print(localStorageService.stayLoggedIn);
            await _auth.logOut();
//                Navigator.pushReplacementNamed(context, CategoryRoute);
          }),
        ],
      ),
    );
  }
}

//class MenuDrawer extends StatelessWidget {
//
//  final userData;
//
//  MenuDrawer({this.userData});
//
//  final localStorageService = locator<LocalStorageService>();
//  final AuthService _auth = AuthService();
//  final textFont = const TextStyle(
//      fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white);
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
////      color: customBlue2,
//      child: SafeArea(
//        child: Theme(
//          data: ThemeData(brightness: Brightness.dark),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisSize: MainAxisSize.max,
//            children: [
//              Container(
//                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0) ,
//                child: CircleAvatar(
//                  radius: 40.0,
//                  backgroundColor: Colors.amberAccent,
////                        child: Text(
////                          userData.name.substring(0, 1) +
////                              userData.surname.substring(0, 1),
////                          style: TextStyle(fontSize: 25.0, color: Colors.white),
////                        ),
//                ),
//              ),
////              Image.asset(
////                'split_new_blue1.png',
////                width: 200,
////              ),
//              ListTile(
////                leading: Icon(Icons.category),
//                  title: Text('Edit my categories', style: textFont,),
//                  onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                    Navigator.pushNamed(context, CategoryRoute);
//                  },
//              ),
//              ListTile(
////                leading: Icon(Icons.edit_attributes),
//                  title: Text('Edit my items', style: textFont),
//                  onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                    Navigator.pushNamed(context, UpdateItemRoute);
//                  },
//              ),
//              ListTile(
////                leading: Icon(Icons.edit),
////                  dense: true,
//                  title: Text('Profile', style: textFont),
//                  onTap: () {
////                      Navigator.pop(context); // This one for the drawer
//                    Navigator.pushNamed(context, UpdateUserRoute, arguments: userData.uid);
//                  }
//              ),
//              ListTile(
////                leading: Icon(Icons.person),
//                title: Text('Logout', style: textFont),
//                onTap: () async {
////                  Navigator.pop(context); // This one for the drawer
////                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
////                setState(() {
//                  localStorageService.clear(); //  Remove all saved values
////                });
//
////                print(localStorageService.stayLoggedIn);
//                  await _auth.logOut();
////                Navigator.pushReplacementNamed(context, CategoryRoute);
//                },
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
