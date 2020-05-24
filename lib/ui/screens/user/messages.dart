import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/message_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import 'package:twofortwo/services/user_service.dart';


class UserMessages extends StatefulWidget {

  final User userData;

  UserMessages({this.userData});

  @override
  _UserMessagesState createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {


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
    return StreamProvider<List<Message>>.value(
      value: DatabaseService(uid: userData.uid).messages,
      child: Scaffold(
        appBar: _profileAppBar(userData, tag),
        body: Container(

          child: Column(
            children: <Widget>[
              Center(child: Text("Messages", style: headerFont)),
              Consumer<List<Message>>(
                builder: (context, value, child) {
                  if (value != null) {
                    return _messageBuilder(value);
                  } else {
                    return Center(child: Text("No Messages"),);
                  }
                }
              ),

            ],
          ),


        ),
        floatingActionButton: FloatingActionButton(onPressed: (){print('profilePic$tag');},),
      ),
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

  _messageBuilder(List<Message> thisMessage){


    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      itemCount: thisMessage.length,
      itemBuilder: (BuildContext context, int index) {

        String message = thisMessage[index].message;
        String nameFrom = thisMessage[index].nameFrom;
        String surnameFrom = thisMessage[index].surnameFrom;
        String phoneFrom = thisMessage[index].phoneFrom;
//        String from = thisMessage[index].uidFrom;
        String forItem = thisMessage[index].forItem;
//        if (chosenCategories.any((item) => allItems[index].categories.contains(item)))  {
//          i = i + 1;
        return Card(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          elevation: 4.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.deepOrangeAccent,
//              child: Image.asset('split_new_blue1.png'),
                  child: Text(
                    nameFrom.substring(0, 1) +
                        surnameFrom.substring(0, 1),
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
                contentPadding: EdgeInsets.all(12.0),
                title: Text(
                  nameFrom,
                  style: itemHeaderFont,
                ),
                subtitle: Text(
                  message,
                  style: itemBodyFont,
                ),
                trailing: Text(
                  forItem,
                  style: itemDate,
                ),
                onTap: () {
                },
              ),
            ],
          ),
        );
      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }



  _profileAppBar(User userData, String tag){
    return PreferredSize(
      preferredSize:  Size.fromHeight(screenHeight(context, dividedBy: 5)),
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
