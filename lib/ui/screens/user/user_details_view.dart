import 'package:flutter/material.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/services/user_service.dart';

class UserDetails extends StatefulWidget {

  final User userData;

  UserDetails({required this.userData});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {


  Widget build(BuildContext context) {

    /* Providers are scoped.
    If they are inserted inside a route, other routes cannot access the value.

    If you need other routes to access that value, you need to include the provider in other routes too.
     Alternatively, put the provider above all routes (typically above MaterialApp) like you did in "other info".*/

//    final items = Provider.of<List<Item>>(context) ?? [];
//    final itemsAvailable = Provider.of<List<ItemAvailable>>(context) ?? [];
//    final FUser fUser = Provider.of<FUser>(context) ?? [];

    final User userData = widget.userData;

//    User userData = widget.user;
    String tag = userData.uid;
//    if (userData != null) {
//      print(userData.email);

//      return StreamBuilder<User>(
//        stream: DatabaseService(uid: fUser.uid).userData,
//        builder: (context, snapshot) {
//        if (snapshot.hasData){
          return Scaffold(
//            appBar: _profileAppBar(userData, tag),
            body: Container(

              child: Column(
                children: <Widget>[

                  new ProfileAppBar(title: "Profile", userData: userData,tag: tag,),

                  Text("Coming soon"),
                ],
              ),


            ),
            floatingActionButton: FloatingActionButton(onPressed: (){print('profilePic$tag');},),
          );
//        }
//    else {
//
//    print('test');
//    return Loading();
//    };
//
////      );
//    }
//      );

}

}
