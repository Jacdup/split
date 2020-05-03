import 'package:flutter/material.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/auth.dart';


class MenuDrawer extends StatelessWidget {

  final userData;

  MenuDrawer({this.userData});

  final localStorageService = locator<LocalStorageService>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
//    return Scaffold(

        body:
        return Material(
//          alignment: Alignment.centerLeft,
//          margin: EdgeInsets.fromLTRB(0, 50.0, 200.0, 0),
          child:
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Center(
                    child: Column(
                      children: <Widget>[
                        Text('Menu'),
                        SizedBox(
                          height: 20.0,
                        ),
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.deepOrangeAccent,
//                        child: Text(
//                          userData.name.substring(0, 1) +
//                              userData.surname.substring(0, 1),
//                          style: TextStyle(fontSize: 25.0, color: Colors.white),
//                        ),
                        )

//    )
                      ],
                    )),
                ListTile(
                    title: Text('Edit my categories'),
                    onTap: () {
                      Navigator.pop(context); // This one for the drawer
                      Navigator.pushNamed(context, CategoryRoute);
                    }),
                ListTile(
                    title: Text('Edit my items'),
                    onTap: () {
                      Navigator.pop(context); // This one for the drawer
                      Navigator.pushNamed(context, UpdateItemRoute);
                    }),
                ListTile(
                    title: Text('Edit personal data'),
                    onTap: () {
                      Navigator.pop(context); // This one for the drawer
                      Navigator.pushNamed(context, UpdateUserRoute, arguments: userData.uid);
                    }),
                ListTile(
                    title: Text('Logout'),
                    onTap: () async {
                      Navigator.pop(context); // This one for the drawer
//                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
//                setState(() {
                      localStorageService.clear(); //  Remove all saved values
//                });

//                print(localStorageService.stayLoggedIn);
                      await _auth.logOut();
//                Navigator.pushReplacementNamed(context, CategoryRoute);
                    })
              ],
            ),

        );
//      );
    }

}
