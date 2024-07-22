import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({required Key key, required this.name}) : super(key: key);
  //final String title;


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: Text('Route for $name is not defined'),
        )
    );
  }
//_ChooseCategoryState createState() => _ChooseCategoryState();
}