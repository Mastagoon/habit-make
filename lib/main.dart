import 'package:flutter/material.dart';
import 'constants/colors.dart';
// screens
import 'screens/home.dart';

void main() => runApp(
      MaterialApp(
        title: "Habit Maker",
        theme: ThemeData(
          primaryColor: Color(secondaryColor),
          fontFamily: "Lato",
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        home: Home(),
      ),
    );
