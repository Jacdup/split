import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/url_launching.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/utils/screen_size.dart';

ValueNotifier<Widget> showContact = ValueNotifier(SizedBox.shrink());

class ButtonWidget extends StatelessWidget {
  ButtonWidget({this.icon, this.onPressed});

  final IconData icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30.0),
      height: screenHeight(context, dividedBy: 16),
      width: screenWidth(context, dividedBy: 3),
//            decoration: InputDecoration(borderRadius: BorderRadius.circular(32.0)),

      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          color: Colors.amberAccent,
          onPressed: onPressed,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.fromLTRB(10, 4, 4, 4)
//                    ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        icon,
//                        Icons.arrow_forward,
                        color: Colors.black87,
                        size: screenWidth(context,
                            dividedBy: 12), // TODO: responsive this
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

}

Widget createContactDialog(BuildContext context){
  final _formKey = GlobalKey<FormState>();
  String message;
  String date;
  Future<UserContact> itemOwnerDetails;

//  itemOwnerDetails = _fetchUserInfo(widget.itemID, widget.type);


  return Container(
    height: screenHeight(context, dividedBy: 1.5),
//    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//    margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 100.0),
    decoration: BoxDecoration(
        color: Colors.white,
//        borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
        border: Border.all(color: Colors.grey,width: 3.0)
    ),
    child: Scaffold(
      floatingActionButton: ButtonWidget(
        icon: Icons.navigate_next,
        onPressed: (){
//          if (_formKey.currentState.validate()) {
//            ButtonPresses().onSendMessage(
//                widget.userUid, widget.itemID, message, date,
//                widget.type);
//            showContact.value = SizedBox.shrink();
//          }
        }, //"true" is available items
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//          resizeToAvoidBottomPadding: true,
////resizeToAvoidBottomInset: true,
////        appBar: PreferredSize(
////          preferredSize: Size.fromHeight(5.0),
////          child: AppBar(
////            leading: IconButton(icon: Icon(Icons.close), onPressed: (){showContact.value = false;},),
////            backgroundColor: Colors.white,
////            elevation: 0.0,
////
////          ),
////        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.close), onPressed: (){showContact.value = SizedBox.shrink();},),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 0,0),
                  child: Text("Send a message", style: itemHeaderFont,),
                ),
//                IconButton(icon: Icon(Icons.arrow_back), iconSize: 32.0,onPressed: (){showContact.value = false;},),
              ],
            ),
            Divider(thickness: 2.0,),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
//                        Center(child: Text("TODO")),
                    TextFormField(
//                      focusNode: _messageNode,
                      maxLines: null,
                      validator: (val) => val.isEmpty ? 'Message to item owner' : null,
                      onChanged: (val) {
//                            setState(() {
                        message = val;
//                            });
                      },
                      decoration: textInputDecoration.copyWith(hintText: 'Message'),
                    ),
                    Divider(),
                    TextFormField(
//                      focusNode: _dateNode,
                      validator: (val) => val.isEmpty ? 'Enter the dates requested' : null,
                      onChanged: (val) {
//                            setState(() {
                        date = val;
//                            });
                      },
                      decoration: textInputDecoration.copyWith(hintText: 'Requested dates'),
                    ),
                    SizedBox(height: 20),
                    Text("OR", style: itemHeaderFont,),
                    FutureBuilder<UserContact>(
                        future: itemOwnerDetails,
//                            initialData: Loading(),
                        builder: (BuildContext context, AsyncSnapshot<UserContact> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(text: "Email address: ",
                                      style: GoogleFonts.muli(fontSize: 13.0,
                                          color: Colors.black87),
                                      children: <TextSpan>[
                                        TextSpan(text: '${snapshot.data.email}', style: itemHeaderFont ),
                                      ]),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(text: "Phone number: ",
                                          style: GoogleFonts.muli(fontSize: 13.0,
                                              color: Colors.black87),
                                          children: <TextSpan>[
                                            TextSpan(text: '${snapshot.data.phone}', style: itemHeaderFont ),
                                          ]),
                                    ),
                                    IconButton(onPressed: (){
                                      LaunchWhatsapp(phoneNumber: snapshot.data.phone, message: message).launchWhatsApp();
                                      print("in here!");
                                    },
                                      icon: FaIcon(FontAwesomeIcons.whatsapp),
                                      color: Colors.green,
                                      visualDensity: VisualDensity.compact,),
                                    FaIcon(FontAwesomeIcons.externalLinkAlt, size: 12.0,),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }else{
                            return Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Loading(backgroundColor: Colors.white,),
                                SizedBox(height: 20),
                              ],
                            );
                          }
                        }
                    ),
//                        contactItemOwner(String messageUid, String documentRef, String messagePayload, String datePayload, bool type)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );


}

Future<UserContact> _fetchUserInfo(String itemID, bool type) async {
  UserContact itemUser;

  if (type){
    itemUser = await DatabaseService(itemID: itemID).itemOwnerDetailsAvail;
  }else{
    itemUser = await DatabaseService(itemID: itemID).itemOwnerDetailsReq;
  }

  return itemUser;
}
