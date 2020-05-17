//import 'dart:ui';
//
//import 'package:flutter/material.dart';
//import 'package:twofortwo/main.dart';
//import 'package:twofortwo/shared/constants.dart';
//import 'package:twofortwo/shared/widgets.dart';
//
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
