import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twofortwo/services/button_presses.dart';
import 'package:twofortwo/shared/constants.dart';
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
//  final  onPressedBtn2;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText1,
    @required this.buttonText2,
    this.type,
    this.item,
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

                      dynamic result = ButtonPresses().onMarkAsUnavailable(item.docRef, type); //TODO: this is called immediately
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
