import 'package:flutter/material.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/ui/responsive/responsive_builder.dart';
import 'package:twofortwo/utils/screen_size.dart';


class Splash extends StatelessWidget {
 // final String argument;
  const Splash({Key key}) : super(key: key);
  //final String title;


  @override
  Widget build(BuildContext context){
    return ResponsiveBuilder(builder: (context, sizingInformation)
    {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(
              context, CategoryRoute);
        }, // handle your image tap here
          child: Scaffold(
      body: Center(
     // child: Text(sizingInformation.toString()),
    //),
        child: Image.asset(
          'split1.png',
          fit: BoxFit.fitHeight, // this is the solution for border
          //width: 110.0,
          height: screenHeight(context),
        ),
      ),
          ),
      );
      /*return Material(
        child: InkWell(
          onTap: () { Navigator.pushNamed(context, LoginRoute, arguments: 'testt');},
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset('split1.png',
                  width: 110.0, height: 110.0),
            ),),
        )
    );*/
      //return Image(image: AssetImage('split1.png'));
      /*return Scaffold(
        body: Center(

          //child: Text(''),
        )
    );*/

    });
  } // Build
//_ChooseCategoryState createState() => _ChooseCategoryState();
}//class