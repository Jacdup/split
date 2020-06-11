import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/message_service.dart';
import 'package:twofortwo/services/url_launching.dart';
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
  List<bool> _infoShow = [];

//  ScrollController _scrollController;

  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }


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
//        appBar: _profileAppBar(userData, tag),
        body: Container(
          child: Column(


            children: <Widget>[

              _profileAppBar(userData, tag),
//              Center(child: _buildTitle()), //Text("Messages", style: headerFont)),
              Consumer<List<Message>>(
                builder: (context, value, child) {

                  if (value != null && value.isNotEmpty) {
                    for (var i = 0; i <= value.length; i++){
                      _infoShow.add(false) ;
                    }
                    return _messageBuilder(value);
                  } else {
                    return Center(child: Text("No Messages"),);
                  }
                }
              ),

            ],
          ),
        ),
//        floatingActionButton: FloatingActionButton(onPressed: (){print('profilePic$tag');},),
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


    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        itemCount: thisMessage.length,
        itemBuilder: (BuildContext context, int index) {

          String message = thisMessage[index].message;
          String nameFrom = thisMessage[index].nameFrom;
          String surnameFrom = thisMessage[index].surnameFrom;
          String phoneFrom = thisMessage[index].phoneFrom;
          DateTime dateSent = thisMessage[index].dateSent;
//          print(thisMessage[index].nameFrom);
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
                    child: nameFrom == null ? SizedBox.shrink():Text(
                      nameFrom.substring(0, 1) +
                          surnameFrom.substring(0, 1),
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(12.0),
                  title:  RichText(
                    text: TextSpan(text: "Re: ",
                        style: GoogleFonts.muli(fontSize: 16.0,
                            color: Colors.black87, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: forItem == null ? " " : forItem,
                            style: itemHeaderFont, ),
                        ]),
                  ),
                  subtitle: nameFrom == null ? SizedBox.shrink(): Text(
                    nameFrom,
//                    message,
                    style: messageFromFont,
                  ),
                  trailing: _buildTrailing(forItem, dateSent),
                  onTap: () {
                    _toggleDropdown(index);
                  },
                ),
                Visibility(
                  visible: _infoShow[index] ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: message == null ? SizedBox.shrink():Text(message, style:itemBodyFont),
                          ),
                            borderOnForeground: true,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Text("Contact $nameFrom:", style: itemDateTitle,),
                        Row(
                          children: <Widget>[
//                            Text("$nameFrom's number: "),
                            Expanded(child: phoneFrom == null ? SizedBox.shrink():Text(phoneFrom, style: itemDateTitle)),
                            IconButton(onPressed: (){
                              LaunchWhatsapp(phoneNumber: phoneFrom, message: message).launchWhatsApp();
                              print("in here!");
                            },
                              icon: FaIcon(FontAwesomeIcons.whatsapp),
                              color: Colors.green,)
                          ],
                        ),
                      ],
                    ),
                  )
                )


              ],

            ),

          );
        },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildTrailing(String forItem, DateTime date){

    String yymmdd = date.year.toString() + '/' + date.month.toString() + '/' + date.day.toString();
    String time   = date.hour.toString() + ':' + date.minute.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
//      Text("Availability", style: textFont,),
        Text(time,
          style: itemDate,),
                Text(yymmdd,
                  style: itemDate,),
    ],
                );


  }

  _profileAppBar(User userData, String tag){
    return Stack(
      children: <Widget>[

        Container(
          height: screenHeight(context, dividedBy: 3.6),
          padding: EdgeInsets.fromLTRB(0,30,0,0),
          color: Colors.transparent,
        ),


        Container(
          height: screenHeight(context, dividedBy: 4.5),
          padding: EdgeInsets.fromLTRB(0,30,0,0),
          color: customBlue5,

//        automaticallyImplyLeading: false,
//        centerTitle: true,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButton(onPressed: (){Navigator.pop(context);}),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 48.0),//TODO, responsive. Well, an IconButton has a min size of 48 pixels.
                      child: Hero(
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
                    ),
                  ),
                ],
              ),
              Text(userData.email),
              Text(userData.phone),
//                _buildTitle(),
            ],
          ),
        ),



        Positioned(
          left: dialogPadding*2,
          right: dialogPadding*2,
          top: dialogPadding*6,
          child: Container(
              height: dialogPadding*2,
              decoration: BoxDecoration(color: Colors.amber,border: Border.all(color: Colors.amber), borderRadius: BorderRadius.all(Radius.circular(bRad*4),)) ,
              child: Center(child: Text("Messages", style: tabFont,))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
        ),




      ],
    );
  }

  Widget _buildTitle(){

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Messages", style: headerFont),
          ),
          Positioned(
            left: dialogPadding,
            right: dialogPadding,
            child: Container(
                height: AvatarPadding + dialogPadding,
                decoration: BoxDecoration(color: Colors.amber,border: Border.all(color: Colors.amber), borderRadius: BorderRadius.all(Radius.circular(bRad*4),)) ,
                child: Center(child: Text("Messages", style: tabFont,))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
          ),
        ],
      ),
    );

  }


}
