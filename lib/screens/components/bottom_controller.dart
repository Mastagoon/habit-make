import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:isoweek/isoweek.dart';

class BottomController extends StatefulWidget {
  const BottomController({Key? key}) : super(key: key);

  @override
  BottomControllerState createState() => BottomControllerState();
}

class BottomControllerState extends State<BottomController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(accentColor),
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(50),
        //   topRight: Radius.circular(50),
        // ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Text(
            "Today",
            style: lightText(22),
          ),
          // week wheel
          buildDateWidget(),
          Divider(),
          // add habit button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  String getDayName(day) {
    final List days = [
      "Mo",
      "Tu",
      "We",
      "Th",
      "Fr",
      "Sa",
      "Su"
    ]; // #TODO add functionality to choose first weekday
    return days[day];
  }

  Widget buildWeekDayWidget(day) {
    Week currentWeek = Week.current(); // current week
    return Container(
      decoration: new BoxDecoration(
          color: currentWeek.day(day).day == DateTime.now().day
              ? Colors.black
              : Colors.white),
      child: Column(
        children: [
          Text(getDayName(day)),
          Text(currentWeek.day(day).day.toString())
        ],
      ),
    );
  }

  Widget buildDateWidget() {
    // display all days
    // highlight day of week
    return Row(
      children: [
        for (var i = 0; i < 7; i++) buildWeekDayWidget(i),
      ],
    );
  }
}
