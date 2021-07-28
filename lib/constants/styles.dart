import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';

TextStyle lightText(double size) {
  return TextStyle(color: Colors.white, fontSize: size);
}

TextStyle hintText(double size) {
  return TextStyle(color: Colors.white54, fontSize: size);
}

ButtonStyle cardButton(bool finished) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      Color(finished ? primaryColor : secondaryColor),
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.zero,
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
