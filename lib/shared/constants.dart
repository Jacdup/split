import 'package:flutter/material.dart';
import 'package:twofortwo/utils/colours.dart';

const textColor = Colors.black54;
final itemFont =
const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
const textFont = const TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold, color: textColor);
final errorFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);
final titleFont = const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black87 );
final textFontDropDown = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
//  final _itemFont = const TextStyle(fontSize: 18, color: Colors.black);

//final _itemFont =s
//const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
//final _textFont = const TextStyle(
//    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);
//final _errorFont = const TextStyle(
//    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);

const borderColour = Colors.white;
const borderWidth = 1.2;
const borderWidthFocused = 1.2;
const bRad = 20.0;
const _borderRadius = const BorderRadius.all(const Radius.circular(bRad));


const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
//  focusColor: Colors.amberAccent,
//  hoverColor: Colors.white,
// hintText: 'test',
hintStyle: textFont,
// border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: borderWidthFocused)),
//  icon: Icon(Icons.map),
  focusedBorder: OutlineInputBorder(
      borderRadius: _borderRadius, // At the moment, BorderRadius.circular constructor cannot be const
      borderSide: BorderSide(color: borderColour, width: borderWidthFocused)),
  enabledBorder: OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide(color: borderColour, width: borderWidth)),

//  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
//  labelText: 'email',
  labelStyle: textFont,

);


//const myOutlineBorder = BoxDecoration(
//color: borderColour,
//borderRadius: BorderRadius.all(const Radius.circular(bRad)),
//border: const Border.all(
//  color: borderColour,
//  width: 5, //               <--- border width here
//),
//);