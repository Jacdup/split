import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twofortwo/services/button_presses.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/utils/colours.dart';
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


class CustomDialog extends StatelessWidget {
  final String title, description, buttonText1, buttonText2;
  final dynamic item;
  final bool type;
  final bool availability;
//  final  onPressedBtn2;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText1,
    @required this.buttonText2,
    this.type,
    this.item,
    this.availability,
//    @required this.onPressedBtn1,
//    @required this.onPressedBtn2,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(bRad),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }


  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: AvatarPadding + dialogPadding,
            bottom: dialogPadding,
            left: dialogPadding,
            right: dialogPadding,
          ),
          margin: EdgeInsets.only(top: dialogPadding),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(bRad),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
//              Text(
//                title,
//                style: TextStyle(
//                  fontSize: 24.0,
//                  fontWeight: FontWeight.w700,
//                ),
//              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed:
//                    onPressedBtn2,
                        ()async {

                      dynamic result = ButtonPresses().onMarkAsUnavailable(item.docRef, type, availability); //TODO: this is called immediately
//                      dynamic result = await onPressedBtn1;
                      if (result == null){
                        Navigator.of(context).pop();
                      }
                    },

                    child: Text(buttonText1),
                  ),
                  FlatButton(
//                    onPressed: onPressedBtn2,
                  onPressed: (){
                      Navigator.of(context).pop();
//                      return onPressedBtn2;
                  },
                    child: Text(buttonText2),
                  ),

                ],
              ),

            ],
          ),
        ),
        //...bottom card part,
        //...top circlular image part,
        Positioned(
          left: dialogPadding,
          right: dialogPadding,
          child: Container(
            height: AvatarPadding + dialogPadding,
              decoration: BoxDecoration(color: Colors.amber,border: Border.all(color: Colors.amber), borderRadius: BorderRadius.all(Radius.circular(bRad*4),)) ,
              child: Center(child: Text(title, style: tabFont,))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
        ),
      ],
    );
  }
}


class ProfileAppBar extends StatelessWidget {
  // This builds a custom appbar for a standard 'split' look on some pages.
  // It is basically just a stack that puts a floating yellow title banner over
  // the appbar.

  final User userData;
  final String tag;
  final String title;

  ProfileAppBar({this.userData, this.tag, this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
//          height: screenHeight(context, dividedBy: 3.6),
          height: 170,
          padding: EdgeInsets.fromLTRB(0,30,0,0),
          color: Colors.transparent,
        ),


        Container(
//          height: screenHeightExcludingToolbar(context, dividedBy: 4.2),
        height: 150,
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
//                          radius: screenHeight(context, dividedBy: 18),
                          radius: 40,
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
//              Text(userData.email),
//              Text(userData.phone),
//                _buildTitle(),
            ],
          ),
        ),



        Positioned(
          left: dialogPadding*2,
          right: dialogPadding*2,
//          top: screenHeight(context, dividedBy: 5.4),
        top: 130,
          child: Container(
              height: dialogPadding*1.6,
              decoration: BoxDecoration(color: Colors.amber,border: Border.all(color: Colors.amber), borderRadius: BorderRadius.all(Radius.circular(bRad*4),)) ,
              child: Center(child: Text(title, style: tabFont,))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
        ),




      ],
    );


  }
}

