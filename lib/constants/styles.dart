import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';

TextStyle lightText(double size, [bool bold = false]) {
  return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
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

ButtonStyle roundedButton(int backgroundColor, double size) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
      CircleBorder(),
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.all(size),
    ),
    backgroundColor: MaterialStateProperty.all(
      Color(backgroundColor),
    ),
  );
}

ButtonStyle generalButtonStyle(
    int backgroundColor, double sizeX, double sizeY) {
  return ButtonStyle(
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: sizeX, vertical: sizeY),
    ),
    backgroundColor: MaterialStateProperty.all(
      Color(backgroundColor),
    ),
  );
}

ButtonStyle timerPercentageButtonStyle() {
  return ButtonStyle(
      // shape: MaterialStateProperty.all(Shape.)
      );
}

TextStyle percentageCenterStartStyle(double size) {
  return TextStyle(
    color: Colors.white.withOpacity(1),
    fontSize: size,
  );
}

TextStyle percentageCenterEndStyle(double size) {
  return TextStyle(
    color: Colors.white.withOpacity(0),
    fontSize: size,
  );
}
