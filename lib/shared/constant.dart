import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);
BoxDecoration profileCardDecortaion = BoxDecoration(
  boxShadow: [
    BoxShadow(blurRadius: 10, color: Colors.black45, offset: Offset(0, 5))
  ],
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
);

//input decoraion
const inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
  filled: true,
);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
    const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

const TextStyle profileCardTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
);
//constant duration transition
const Duration durationTransition = Duration(milliseconds: 1500);

//constact key for secure storage
const String EMAILFORBIOMETRIC = 'emailForBiometric';
const String PASSWORDFORBIOMETRIC = 'passwordForBiometric';
const String HASSETUPBIOMETRIC = 'hasSetupBiometric';