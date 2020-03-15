import 'package:flutter/material.dart';
import 'package:twofortwo/routing_constants.dart';


class HomeView extends StatelessWidget {
 // final String argument;
  const HomeView({Key key}) : super(key: key);
  //final String title;


  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {Navigator.pushReplacementNamed(context, LoginRoute, arguments: 'testt');}, // handle your image tap here
      child: Image.asset(
        'split1.png',
        fit: BoxFit.cover, // this is the solution for border
        width: 110.0,
        height: 110.0,
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
  }
//_ChooseCategoryState createState() => _ChooseCategoryState();
}