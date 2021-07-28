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
      // color: Colors.black,
      decoration: BoxDecoration(
        color: Color(accentColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "Today",
              style: lightText(22),
            ),
          ),
          // week wheel
          buildDateWidget(),
          Divider(),
          // add habit button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Color(secondaryColor),
                  padding: EdgeInsets.all(6)),
              onPressed: () {},
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(
            height: 15,
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
            ? Color(secondaryColor)
            : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 7, bottom: 7, right: 13, left: 13),
      child: Column(
        children: [
          Text(
            getDayName(day),
            style: hintText(16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            currentWeek.day(day).day.toString(),
            style: lightText(16),
          )
        ],
      ),
    );
  }

  Widget buildDateWidget() {
    // display all days
    // highlight day of week
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < 7; i++) buildWeekDayWidget(i),
      ],
    );
  }
}
