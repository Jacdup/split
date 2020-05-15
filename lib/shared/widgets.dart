import 'package:flutter/material.dart';
import 'package:twofortwo/utils/screen_size.dart';


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

