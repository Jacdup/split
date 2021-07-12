import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var pricePeriod = <String>[
  'Free',
  'Per Day',
  'Per Month',
  'Once Off',
];

const dialogPadding = 25.0;
const AvatarPadding = 40.0;

const textColor = Colors.black54;
final tabFont = GoogleFonts.mulish(fontSize: 20.0, fontWeight: FontWeight.w600);
final titleDescriptionFont =
    GoogleFonts.mulish(fontSize: 20.0, fontWeight: FontWeight.bold);
//const tabFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
final itemHeaderFont = GoogleFonts.mulish(
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
);
final itemBodyFont = GoogleFonts.mulish(fontSize: 11.0, color: Colors.black87);
final itemDate =
    GoogleFonts.mulish(fontSize: 10.0, fontWeight: FontWeight.w500);
final itemDateFromTo = GoogleFonts.mulish(
    fontSize: 11.0, color: Colors.black87, fontWeight: FontWeight.bold);
final itemDateTitle = const TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.bold, color: textColor);
final spamFont = const TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red);
final messageFromFont = GoogleFonts.mulish(
    fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.w600);

final priceFont = const TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blueAccent);
final priceFreeFont = GoogleFonts.mulish(
    fontSize: 14.0, color: Colors.green, fontWeight: FontWeight.bold);

final headerFont = const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
const textFont = const TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold, color: textColor);
final errorFont = const TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);
final titleFont = const TextStyle(
    fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black87);
final textFontDropDown = const TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
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
const bRad = 16.0;
const borderRadius = const BorderRadius.all(const Radius.circular(bRad));

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
      borderRadius:
          borderRadius, // At the moment, BorderRadius.circular constructor cannot be const
      borderSide: BorderSide(color: borderColour, width: borderWidthFocused)),
  enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: borderColour, width: borderWidth)),
  disabledBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.black38, width: 30)),

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
