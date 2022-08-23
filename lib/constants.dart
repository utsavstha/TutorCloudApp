import 'package:flutter/material.dart';

final primaryColor = Color(0xff4c65ff);
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  backgroundColor: primaryColor,
);
