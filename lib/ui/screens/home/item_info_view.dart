//import 'dart:ui';
//

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/utils/button_presses.dart';
import 'package:twofortwo/utils/screen_size.dart';
//
class ItemInfo extends StatefulWidget {
  ItemInfo({this.itemID, this.userUid, this.type});

  final String userUid;
  final String itemID;
  final bool type; // if a request, or available. "True" = available

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {

  double bottomInset = 150.0;

  FocusNode _messageNode;
  FocusNode _dateNode;

  String message;
  String date;

  @override
  void initState() {
    super.initState();
    _messageNode = FocusNode();
    _dateNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _messageNode.dispose();
    _dateNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

//Widget itemInfo(String itemID, BuildContext context) {



    void _listener(){ // This listener ensures the Column is not bunched up when keyboard opens, by decreasing the bottom edgeInset
      if(_messageNode.hasFocus || _dateNode.hasFocus){
        setState((){
          bottomInset = 0.0;
        });
        // keyboard appeared
      }
      else{
        setState((){
          bottomInset = 150.0;
        });
        // keyboard dismissed
      }
    }

    _messageNode.addListener(() {_listener();});
    _dateNode.addListener(() {_listener();});

//    int num = widget.numType[0];
//    int type = widget.numType[1];
//  print('in item info');
//  print(widget.heroTag);
    print(bottomInset);
    return Stack(

      children: <Widget>[
        Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.transparent,),)),
        Container(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, bottomInset),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
              border: Border.all(color: Colors.grey,width: 3.0)
          ),
          child: Scaffold(
            floatingActionButton: ButtonWidget(
              icon: Icons.navigate_next,
              onPressed: (){
                onSendMessage(widget.userUid, widget.itemID, message,date, widget.type);
                showContact.value = SizedBox.shrink();
                }, //"true" is available items
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//          resizeToAvoidBottomPadding: true,
//resizeToAvoidBottomInset: true,
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
            body: SingleChildScrollView(
              child: Column(
//              mainAxisSize: MainAxisSize.max,
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
                  Center(
                    child: Column(
                      children: <Widget>[
//                        Center(child: Text("TODO")),
                        TextFormField(
                          focusNode: _messageNode,
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
                          focusNode: _dateNode,
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
                        SizedBox(height: 20),
                        Text("Owner email address: 19083688@sun.ac.za", style : GoogleFonts.muli(fontSize: 13.0, color: Colors.black87)),
                        SizedBox(height: 10),
                        Text("Owner phone: 079 775 0814", style : GoogleFonts.muli(fontSize: 13.0, color: Colors.black87)),
//                        contactItemOwner(String messageUid, String documentRef, String messagePayload, String datePayload, bool type)
                      ],
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
}

//class ItemInfo extends StatefulWidget {
////  final int num;
////  final int type;
//final String heroTag;
////  final List<int> numType;
//////  final bool vis;
//  ItemInfo({this.heroTag});
//
//  @override
//  _ItemInfoState createState() => _ItemInfoState();
//}
//
//class _ItemInfoState extends State<ItemInfo> {
//
////  OverlayEntry _overlayEntry;
//
//
//  @override
//  Widget build(BuildContext context) {
////    int num = widget.numType[0];
////    int type = widget.numType[1];
//    print('in item info');
//    print(widget.heroTag);
//
//    return Stack(
//
//      children: <Widget>[
//        Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//          child: Container(color: Colors.transparent,),)),
//        Hero(
//
//          tag: widget.heroTag ,
//          child: Container(
//            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//            margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
//            decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
//                border: Border.all(color: Colors.grey,width: 3.0)
//            ),
//            child: Scaffold(
////        appBar: PreferredSize(
////          preferredSize: Size.fromHeight(5.0),
////          child: AppBar(
////            leading: IconButton(icon: Icon(Icons.close), onPressed: (){showContact.value = false;},),
////            backgroundColor: Colors.white,
////            elevation: 0.0,
////
////          ),
////        ),
//              backgroundColor: Colors.white,
//              body: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      IconButton(icon: Icon(Icons.close), onPressed: (){showContact.value = SizedBox.shrink();},),
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(25.0, 0, 0,0),
//                        child: Text("Send a message", style: itemHeaderFont,),
//                      ),
////                IconButton(icon: Icon(Icons.arrow_back), iconSize: 32.0,onPressed: (){showContact.value = false;},),
//                    ],
//                  ),
//                  Center(
//                    child: Card(
////            child: Text(
////              'test${widget.num}', style: TextStyle(color: Colors. black),
////            ),
//                        elevation: 4.0,
//                        child: Column(
//                          children: <Widget>[
//                            Center(child: Text("TODO"))
//                          ],
//                        )
//
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//
//  }
//}
