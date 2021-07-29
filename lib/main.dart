import 'package:flutter/material.dart';
import 'constants/colors.dart';
// screens
import 'screens/home.dart';

void main() => runApp(
      MaterialApp(
        title: "Habit Maker",
        theme: ThemeData(
          canvasColor: Color(secondaryColorDark),
          primaryColor: Color(secondaryColor),
          fontFamily: "Lato",
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          // timePickerTheme:
        ),
        home: Home(),
      ),
    );
