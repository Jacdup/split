import 'package:flutter/material.dart';
final itemFont =
const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
const textFont = const TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);
final errorFont = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);
//  final _itemFont = const TextStyle(fontSize: 18, color: Colors.black);

//final _itemFont =
//const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
//final _textFont = const TextStyle(
//    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black54);
//final _errorFont = const TextStyle(
//    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red);

const borderColour = Colors.black87;
const borderWidth = 1.2;
const bRad = 32.0;
const _borderRadius = const BorderRadius.all(const Radius.circular(bRad));


const textInputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
      borderRadius: _borderRadius, // At the moment, BorderRadius.circular constructor cannot be const
      borderSide: BorderSide(color: borderColour, width: borderWidth)),
  enabledBorder: OutlineInputBorder(borderRadius: _borderRadius),
//  contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
//  labelText: 'email',
  labelStyle: textFont,
);
