import 'package:flutter/material.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/shared/loading.dart';
import '../../../utils/service_locator.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/user_service.dart';


class UserDetails extends StatefulWidget {

  final User userData;

  UserDetails({this.userData});

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
            appBar: _profileAppBar(userData, tag),
            body: Container(

              child: Text("My profile"),


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



  _profileAppBar(User userData, String tag){
    return PreferredSize(
      preferredSize:  Size.fromHeight(screenHeight(context, dividedBy: 6)),
      child: Container(
        padding: EdgeInsets.fromLTRB(0,30,0,0),
        color: customBlue5,

//        automaticallyImplyLeading: false,
//        centerTitle: true,
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'profilePic$tag',
            child: CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.deepOrangeAccent,
//              child: Image.asset('split_new_blue1.png'),
              child: Text(
              userData.name.substring(0, 1) +
                  userData.surname.substring(0, 1),
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            ),
          ),
          Text(userData.email),
          Text(userData.phone)
        ],

      ),

//        title: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                'Add item',
//                style: titleFont,
//              ),
//            ],
//          ),
//        ),


//      titleSpacing: 100.0,
//      title: PreferredSize(
//        preferredSize: Size.square(200.0),
//        child: CircleAvatar(
//          radius: 40.0,
//          backgroundColor: Colors.deepOrangeAccent,
//          child: Text(
//          userData.name.substring(0, 1) +
//              userData.surname.substring(0, 1),
//          style: TextStyle(fontSize: 25.0, color: Colors.white),
//        ),),
//      ),


      ),
    );
  }


}
