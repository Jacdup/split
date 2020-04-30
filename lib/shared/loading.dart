import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';

class Loading extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return Container(
    color: customBlue5,
      child: Center(
        child: SpinKitDualRing(
          color: Colors.amberAccent,
          size: screenWidth(context, dividedBy: 5),
        )
      ),
    );
  }
}