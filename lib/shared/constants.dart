import 'package:flutter/material.dart';

// the stuff in this file can be used as a ready-made building blocks instead of having to write the whole code for it over and over again.
// can be modified in the main code using a function called copyWith(*insert your attributes here*)
// example:  {   decoration:  textInputDecoration.copyWith(hintText: "password")   }
const textInputDecoration = InputDecoration(
  fillColor: Colors.white60,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white60, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
  ),
);