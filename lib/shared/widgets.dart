import 'dart:ui';

import 'package:flutter/material.dart';
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

Widget itemInfo() {
//    int num = widget.numType[0];
//    int type = widget.numType[1];
//  print('in item info');
//  print(widget.heroTag);

  return Stack(

    children: <Widget>[
      Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(color: Colors.transparent,),)),
      Hero(

        tag: "row0 1" ,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
              border: Border.all(color: Colors.grey,width: 3.0)
          ),
          child: Scaffold(
//        appBar: PreferredSize(
//          preferredSize: Size.fromHeight(5.0),
//          child: AppBar(
//            leading: IconButton(icon: Icon(Icons.close), onPressed: (){showContact.value = false;},),
//            backgroundColor: Colors.white,
//            elevation: 0.0,
//
//          ),
//        ),
            backgroundColor: Colors.white,
            body: Column(
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
                Center(
                  child: Card(
//            child: Text(
//              'test${widget.num}', style: TextStyle(color: Colors. black),
//            ),
                      elevation: 4.0,
                      child: Column(
                        children: <Widget>[
                          Center(child: Text("TODO"))
                        ],
                      )

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

}

