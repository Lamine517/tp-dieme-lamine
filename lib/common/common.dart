// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const regularFont = "Roboto-Regular";
const boldFont = "Roboto-Bold";

Color primaryBackground = const Color(0xff0A155A);
const secondBackground = Color(0xff3D47AF);
const secondFontColor = Color(0xFF4F74FF);
const thirdFontColor = Color(0xFFBBC2D8);

const businessIndicator = Color(0xFFD103FC);
const personalIndicator = Color(0xFF4F74FF);

Color globalWhite = const Color(0xFFFFFFFF).withOpacity(.8);

String backendDN = 'immense-forest-85566.herokuapp.com';

var authenticationtURL = Uri.https(backendDN, '/authenticate');
var tasksListURL = Uri.https(backendDN, '/tasks');

BoxDecoration inputDecoration() {
  return BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    border: Border.all(
      color: secondBackground,
      width: 1.5,
    ),
  );
}