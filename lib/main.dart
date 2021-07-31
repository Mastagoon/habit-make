import 'package:flutter/material.dart';
import 'package:habit_maker/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
// screens
import 'screens/home.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TimerProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Maker",
      theme: ThemeData(
        backgroundColor: Colors.black,
        canvasColor: Color(secondaryColorDark),
        primaryColor: Color(secondaryColor),
        fontFamily: "Lato",
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
        // timePickerTheme:
      ),
      home: Home(),
    );
  }
}
