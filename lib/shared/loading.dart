import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';

class Loading extends StatelessWidget{
//  @override

  final Color? backgroundColor;

  Loading({this.backgroundColor});

//  const Loading({Key key, this.loading}) : super(key: key);
//
//  final ValueNotifier<bool> loading;

  Widget build(BuildContext context){
    return Container(
    color: backgroundColor == null ? customBlue5 : backgroundColor,
      child: Center(
        child: SpinKitDualRing(
          color: Colors.amberAccent,
          size: screenWidth(context, dividedBy: 5),
        )
      ),
    );
  }
}