import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
// components
import 'components/add_habit.dart';
import 'components/habit_card.dart';
import 'components/bottom_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Habit Builder"),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          Container(
            child: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AddHabitDialog(),
              ),
              icon: Icon(Icons.add_circle_outline_outlined),
              iconSize: 30,
            ),
            padding: EdgeInsets.only(right: 5),
          ),
          Container(
            child: IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (context) => BottomController()),
              icon: Icon(Icons.calendar_today_outlined),
            ),
            padding: EdgeInsets.only(right: 5),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(mainBackgroundColor)),
        // margin: MediaQuery.of(context).padding,
        padding: EdgeInsets.only(left: 15, right: 15),
        // #TODO reduce col's width (too wide)
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 5),
                child: Text(
                  "Overview",
                  style: lightText(22),
                  textAlign: TextAlign.left,
                ),
                // #TODO seperator or smth
              ),
              // unfinished habits for the day
              HabitCard(
                  completed: false,
                  name: "Dance tango",
                  practicedTime: "Practiced for 00:34:12 today",
                  goal: "1:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              // seperator
              Container(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 10),
                child: Text(
                  "Practiced Today",
                  style: hintText(16),
                ),
              ),
              // Divider(
              //   color: Colors.white,
              // ),
              // finished habits for the day
              HabitCard(
                  completed: true,
                  name: "Meditation",
                  practicedTime: "Practiced for 1:24:12 today",
                  goal: "1:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Run 21 miles",
                  practicedTime: "Practiced for 3:14:12 today",
                  goal: "2:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Naked Twister",
                  practicedTime: "Practiced for 4:15:11 today",
                  goal: "3:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Naked Twister",
                  practicedTime: "Practiced for 4:15:11 today",
                  goal: "3:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Naked Twister",
                  practicedTime: "Practiced for 4:15:11 today",
                  goal: "3:00:00 Daily",
                  lorem: "lorem epsum dolor"),
            ],
          ),
        ),
      ),
      // bottom controller thingy
      // bottomSheet: BottomController(),
    );
  }
}
